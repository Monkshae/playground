//
//  ViewController.m
//  FrameAndBounds
//
//  Created by licong on 2017/2/27.
//  Copyright © 2017年 Richard. All rights reserved.
//

#import "ViewController.h"

// http://www.cocoachina.com/ios/20140925/9755.html
// http://blog.csdn.net/mad1989/article/details/8711697
// http://natashatherobot.com/ios-frame-vs-bounds-resize-basic-uitableview-cell/

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
    
    
//    NSLog(@"s0->%p",s0);
//    NSLog(@"s1->%p",s1);
//    NSLog(@"s2->%p",s2);
//    NSLog(@"s3->%p",s3);
//    NSLog(@"s4->%p",s4);
//    NSLog(@"s5->%p",s5);
//    NSLog(@"s6->%p",s6);
//    
//    
//    NSLog(@"s0 vaule->%@",s0);
//    NSLog(@"s1 vaule->%@",s1);
//    NSLog(@"s2 vaule->%@",s2);
//    NSLog(@"s3 vaule->%@",s3);
//    NSLog(@"s4 vaule->%@",s4);
//    NSLog(@"s5 vaule->%@",s5);
//    NSLog(@"s6 vaule->%@",s6);
//    
//    
//    NSLog(@"s0 <-> s2 %d", s0 == s2);
//    NSLog(@"s2 <-> s3 %d", s2 == s3);
//    
//    
//    NSLog(@"s0 Equal s2 %d", [s0 isEqualToString: s2]);
//    NSLog(@"s2 Equal s3 %d", [s2 isEqualToString: s3]);
    
    //总结isEqualToString是比较值,==号是比较指针。
    //stringWithFormat生成的不再数据常量去
    //stringWithString生成得在数据常量区
    
    
    
    /*
     frame定义了一个相对父视图的一个框架（容器），bounds则是真实显示区域
     bounds的有以下两个特点：
     
     1. 它可以修改自己坐标系的原点位置，进而影想到“子view”的显示位置。这个作用更像是移动原点的意思。
     
     2. bounds，它可以改变的frame。如果bounds比frame大。那么frame也会跟着变大。这个作用更像边界和大小的意思。
     */
    
    
//    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
//    [view1 setBounds:CGRectMake(-30, -30, 250, 250)];
//    view1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:view1];//添加到self.view
//    NSLog(@"view1 frame:%@========view1 bounds:%@",NSStringFromCGRect(view1.frame),NSStringFromCGRect(view1.bounds));
//    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    view2.backgroundColor = [UIColor yellowColor];
//    [view1 addSubview:view2];//添加到view1上,[此时view1坐标系左上角起点为(-30,-30)]
//    NSLog(@"view2 frame:%@========view2 bounds:%@",NSStringFromCGRect(view2.frame),NSStringFromCGRect(view2.bounds));
    

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"test.plist"];
    //输入写入
    
    NSMutableDictionary * city = [[NSMutableDictionary alloc]init];
    city[@"name"] = @"杭州";
    city[@"id"] = @"hanghzhou";
    NSMutableArray * citys = [[NSMutableArray alloc]init];
    NSInteger i = 0;
    while (i<3) {
        [citys addObject:city];
        i++;
    }
    
    
    
    
    NSMutableDictionary * province = [[NSMutableDictionary alloc]init];
    province[@"citys"] = citys;
    province[@"name"] = @"浙江";
    province[@"id"] = @"1";
    NSMutableArray * provinces = [[NSMutableArray alloc]init];
    NSInteger j = 0;
    while (j<12) {
        [provinces addObject:province];
        j++;
    }
    
    
    NSMutableDictionary * country = [[NSMutableDictionary alloc]init];
    country[@"name"] = @"中国全部";
    country[@"id"] = @"0";
    country[@"provinces"] = provinces;
    NSMutableArray * countrys = [[NSMutableArray alloc]init];
    NSInteger k = 0;
    while (k<3) {
        [countrys addObject:country];
        k++;
    }

    [countrys writeToFile:filename atomically:YES];
    
    NSLog(@"%@",plistPath1);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
