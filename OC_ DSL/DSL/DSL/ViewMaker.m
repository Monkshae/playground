//
//  ViewMaker.m
//  DSL
//
//  Created by licong on 2017/2/27.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import "ViewMaker.h"


@implementation ViewMaker


+ (ViewMaker*)makeView{
    ViewMaker *maker = [[ViewMaker alloc]init];
    maker.viewClass = self;
    return maker;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        __weak typeof(self) weakSelf = self;
        _position = ^ViewMaker *(CGFloat x, CGFloat y) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.lc_position = CGPointMake(x, y);
            return strongSelf;
        };
        _size = ^ViewMaker *(CGFloat width, CGFloat height) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.lc_size = CGSizeMake(width, height);
            return strongSelf;
        };
        _bgColor = ^ViewMaker *(UIColor *color) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.lc_color = color;
            return strongSelf;
        };
        
        _intoView = ^UIView *(UIView *superView) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            CGRect rect = CGRectMake(strongSelf.lc_position.x, strongSelf.lc_position.y,
                                     strongSelf.lc_size.width, strongSelf.lc_size.height);
            UIView *view = [[UIView alloc] initWithFrame:rect];
            view.backgroundColor = strongSelf.lc_color;
            [superView addSubview:view];
            return view;
        };

        
    }
    return self;
}

- (ViewMaker *)with
{
    return self;
}


@end
