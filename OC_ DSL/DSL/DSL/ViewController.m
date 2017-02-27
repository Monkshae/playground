//
//  ViewController.m
//  DSL
//
//  Created by licong on 2017/2/27.
//  Copyright © 2017年 Richard. All rights reserved.
//

//http://chuansong.me/n/1554838228427

#import "ViewController.h"
#import "ViewMaker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [ViewMaker makeView].with.position(80,80).size(100,100).bgColor([UIColor blueColor]).intoView(self.view);

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
