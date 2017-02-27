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
    
    //关于数据常量区的测试
    NSString *s0 = @"hello";
    NSString *s1 = @"hello";
    NSString *s2 = [NSString stringWithFormat:@"hello"];
    NSString *s3 = [NSString stringWithFormat:@"hello"];
    NSString *s4 = [NSString stringWithFormat:@"hello"];
    NSString *s5 = [NSString stringWithString:s0];
    NSString *s6 = [NSString stringWithFormat:@"%@", s1];
    

    NSLog(@"s0->%p",s0);
    NSLog(@"s1->%p",s1);
    NSLog(@"s2->%p",s2);
    NSLog(@"s3->%p",s3);
    NSLog(@"s4->%p",s4);
    NSLog(@"s5->%p",s5);
    NSLog(@"s6->%p",s6);


    NSLog(@"s0 vaule->%@",s0);
    NSLog(@"s1 vaule->%@",s1);
    NSLog(@"s2 vaule->%@",s2);
    NSLog(@"s3 vaule->%@",s3);
    NSLog(@"s4 vaule->%@",s4);
    NSLog(@"s5 vaule->%@",s5);
    NSLog(@"s6 vaule->%@",s6);
    
    
    NSLog(@"s0 <-> s2 %d", s0 == s2);
    NSLog(@"s2 <-> s3 %d", s2 == s3);

    
    NSLog(@"s0 Equal s2 %d", [s0 isEqualToString: s2]);
    NSLog(@"s2 Equal s3 %d", [s2 isEqualToString: s3]);

    //总结isEqualToString是比较值,==号是比较指针。
    //stringWithFormat生成的不再数据常量去
    //stringWithString生成得在数据常量区
    
    
    
    [ViewMaker makeView].with.position(80,80).size(100,100).bgColor([UIColor blueColor]).intoView(self.view);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
