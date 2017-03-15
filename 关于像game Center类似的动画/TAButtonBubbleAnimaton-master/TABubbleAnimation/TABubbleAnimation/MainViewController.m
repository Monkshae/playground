//
//  MainViewController.m
//  TABubbleAnimation
//
//  Created by Tri Vo on 4/27/16.
//  Copyright © 2016 acumen. All rights reserved.
//

#import "MainViewController.h"
#import "TABubbleView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TABubbleView *bubbleView = [[TABubbleView alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [bubbleView setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:bubbleView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) initBalloonView {
    UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    [mView setBackgroundColor:[UIColor redColor]];
    mView.layer.cornerRadius = mView.frame.size.width/2;
    [self.view addSubview:mView];
    
    // create an animation to follow a circular path
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    pathAnimation.calculationMode = kCAAnimationPaced;
    // apply transformation at the end of animation
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    // run forever
    pathAnimation.repeatCount = INFINITY;
    
    // no ease in/out to have the same speed along the path
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.duration = 5.0f;
    
    //The circle to follow will be inside the circleContainer frame.
    //it should be a frame around the center of your view to animate.
    //do not make it to large, a width/height of 3-4 will be enough.
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGRect circleContainer = CGRectInset(mView.frame, mView.frame.size.width/4, mView.frame.size.height/4);
    CGPathAddEllipseInRect(curvedPath, NULL, circleContainer);
    
    // add the path to the animation
    pathAnimation.path = curvedPath;
    // release path
    CGPathRelease(curvedPath);
    // add animation to the view's layer
    [mView.layer addAnimation:pathAnimation forKey:@"myCircleAnimation"];
    
    CAKeyframeAnimation *scaleX = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    // set the duration
    scaleX.duration = 1;
     //it starts from scale factor 1, scales to 1.05 and back to 1
    scaleX.values = @[@1.0f, @1.05f, @1.0];
    //time percentage when the values above will be reached.
    //i.e. 1.05 will be reached just as half the duration has passed.
    scaleX.keyTimes = @[@0.0f, @0.5f, @1.0f];
    //keep repeating
    scaleX.repeatCount = INFINITY;
    //play animation backwards on repeat (not really needed since it scales back to 1)
    scaleX.autoreverses = YES;
    // ease in/out animation for more natural look
    scaleX.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // add the animation to the view's layer
    [mView.layer addAnimation:scaleX forKey:@"scaleXAnimation"];
    
}

@end
