//
//  ViewMaker.h
//  DSL
//
//  Created by licong on 2017/2/27.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewMaker : NSObject

@property (nonatomic, strong) Class viewClass;
@property (nonatomic, assign) CGPoint lc_position;
@property (nonatomic, assign) CGSize  lc_size;
@property (nonatomic, strong) UIColor *lc_color;
@property (nonatomic, readonly) ViewMaker *with;
@property (nonatomic, copy) ViewMaker* (^position)(CGFloat x, CGFloat y);
@property (nonatomic, copy) ViewMaker* (^size)(CGFloat width, CGFloat height);
@property (nonatomic, copy) ViewMaker* (^bgColor)(UIColor *color);
@property (nonatomic, copy) UIView* (^intoView)(UIView *superView);



+ (ViewMaker*)makeView;

@end

