//
//  ViewController.m
//  CircleProgressBar
//
//  Created by appleDeveloper on 16/4/8.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import "ViewController.h"
#import "CircleProgressBar.h"

@interface ViewController ()
@property (strong, nonatomic) CircleProgressBar *circleProgress;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 我添加了代码
    _circleProgress = [[CircleProgressBar alloc] initWithFrame:CGRectMake(100, 70, 80 , 80)];
    _circleProgress.trackColor = [UIColor blackColor];
    _circleProgress.progressColor = [UIColor orangeColor];
    _circleProgress.progressWidth = 10;
    
    [self.view addSubview:self.circleProgress];
    
    [_circleProgress startEndTimerval:10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

@end
