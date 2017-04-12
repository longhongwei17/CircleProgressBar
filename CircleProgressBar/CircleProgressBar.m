//
//  CircleProgressBar.m
//  CircleProgressBar
//
//  Created by appleDeveloper on 16/4/8.
//  Copyright © 2016年 appleDeveloper. All rights reserved.
//

#import "CircleProgressBar.h"

@interface CircleProgressBar (){
    CAShapeLayer *_trackLayer;
    UIBezierPath *_trackPath;
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}

@property (nonatomic, strong) UILabel *endLabel;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic) float progress;

@property (nonatomic) float perTimer;

@property (nonatomic) NSInteger allTimes;

@end

@implementation CircleProgressBar
#pragma mark - init

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.progress = 0.f;
    
    _trackLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [UIColor clearColor].CGColor;

    _progressLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_progressLayer];
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.lineCap = kCALineCapButt;

    [self addSubview:self.endLabel];

    //默认5
    self.progressWidth = 5;
}

- (UILabel *)endLabel
{
    if (!_endLabel) {
        _endLabel = [[UILabel alloc] init];
        _endLabel.font = [UIFont boldSystemFontOfSize:25.f];
        _endLabel.backgroundColor = [UIColor clearColor];
        _endLabel.textColor = [UIColor blackColor];
        _endLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _endLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    _trackLayer.frame = self.bounds;
    _progressLayer.frame = self.bounds;
    
    _endLabel.frame = CGRectMake(self.progressWidth, (CGRectGetHeight(self.bounds) - 20)/2, CGRectGetWidth(self.bounds) - 2 * self.progressWidth, 25);
    
    [self setTrack];
}

- (void)setTrack
{
    CGPoint center = CGPointMake(CGRectGetMidX(_trackLayer.frame), CGRectGetMidY(_trackLayer.frame));
    _trackPath = [UIBezierPath bezierPathWithArcCenter:center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:- M_PI_2 endAngle:M_PI * 1.5 clockwise:YES];

    _trackLayer.path = _trackPath.CGPath;
}

- (void)setProgress
{
    CGPoint center = CGPointMake(CGRectGetMidX(_progressLayer.frame), CGRectGetMidY(_progressLayer.frame));
    _progressPath = [UIBezierPath bezierPathWithArcCenter:center radius:(self.bounds.size.width - _progressWidth)/ 2 startAngle:- M_PI_2 endAngle:(M_PI * 2) * _progress - M_PI_2 clockwise:YES];

    _progressLayer.path = _progressPath.CGPath;
}

- (void)setProgressWidth:(float)progressWidth
{
    _progressWidth = progressWidth;
    _trackLayer.lineWidth = _progressWidth;
    _progressLayer.lineWidth = _progressWidth;
    
    [self setTrack];
}

- (void)setTrackColor:(UIColor *)trackColor
{
    _trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    
    [self setProgress];
}

- (void)startEndTimerval:(CGFloat)timerval
{
    NSAssert(timerval > 1, @"倒计时的时间太短");
    
    [self setTrack];
    self.allTimes = (NSInteger)timerval;
    
    [self updateLabel];
    self.perTimer = 1.f / timerval;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCircle) userInfo:nil repeats:YES];
}

- (void)updateCircle
{
    self.allTimes --;
    [self updateLabel];
    self.progress += self.perTimer;
    if (_progress >= 1.0 ){
        [self invalidTimer];
    }
}

- (void)updateLabel
{
    self.endLabel.text = [NSString stringWithFormat:@"%@",@(self.allTimes)];
}

- (void)invalidTimer
{
    if ([self.timer isValid]) {
        [self.timer invalidate], self.timer = nil;
    }
}

- (void)dealloc
{
    [self invalidTimer];
}
@end
