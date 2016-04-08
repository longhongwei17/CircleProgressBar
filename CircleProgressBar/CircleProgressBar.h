//
//  CircleProgressBar.h
//  CircleProgressBar
//
//  Created by appleDeveloper on 16/4/8.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleProgressBar : UIView

@property (nonatomic, strong) UIColor *trackColor;

@property (nonatomic, strong) UIColor *progressColor;



@property (nonatomic) float progressWidth;

// 开始倒计时
- (void)startEndTimerval:(CGFloat)timerval;


@end

NS_ASSUME_NONNULL_END
