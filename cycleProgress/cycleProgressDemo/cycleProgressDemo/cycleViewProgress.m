//
//  cycleViewProgress.m
//  cycleProgressDemo
//
//  Created by 孙明喆 on 2020/2/6.
//  Copyright © 2020 孙明喆. All rights reserved.
//

#import "cycleViewProgress.h"
#define RYUIColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface cycleViewProgress()

@property(nonatomic,strong)CAShapeLayer * progressLayer;
@property(nonatomic,assign)float lastProgress;
@property(nonatomic,assign)BOOL firstTime;

@end

@implementation cycleViewProgress

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        CGPoint arcCenter = CGPointMake(frame.size.width/2, frame.size.width/2);
        // 计算半径时候需要结合上线宽才行，这个问题困扰了一会
        CGFloat radius = (frame.size.width - PROGRESS_LINE_WIDTH) / 2;
        // 圆形路径
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                            radius:radius
                                                        startAngle:M_PI_2
                                                          endAngle:M_PI*2+M_PI_2
                                                         clockwise:YES];
        
        //CAShapeLayer
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        shapLayer.path = path.CGPath;
        shapLayer.fillColor = [UIColor clearColor].CGColor;//图形填充色
        UIColor *grayColor =  [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:0.8];
        shapLayer.strokeColor =  grayColor.CGColor;//边线颜色
        shapLayer.lineWidth = PROGRESS_LINE_WIDTH;
        [self.layer addSublayer:shapLayer];
        
        //渐变图层 渐变：RYUIColorWithRGB(140, 94, 0)   >>  RYUIColorWithRGB(229, 168, 46)   >>    RYUIColorWithRGB(140, 94, 0)
        CALayer * grain = [CALayer layer];
        [self.layer addSublayer:grain];
        //采用一个渐变底层
        CAGradientLayer * gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        // 颜色分配
//        [gradientLayer setColors:[NSArray arrayWithObjects:
//                                   (id)[RYUIColorWithRGB(46, 201, 144) CGColor],
//                                   (id)[RYUIColorWithRGB(21, 203, 210) CGColor], nil]];
        // 颜色分配
        [gradientLayer setColors:[NSArray arrayWithObjects:
                                   (id)[UIColorWithRGBStart CGColor],
                                   (id)[UIColorWithRGBEnd CGColor], nil]];

        [gradientLayer setLocations:@[@0.3,@1]];// 颜色分割线
        [gradientLayer setStartPoint:CGPointMake(0, 0)];// 起始点
        [gradientLayer setEndPoint:CGPointMake(1, 1)];// 结束点
        [grain addSublayer:gradientLayer];
        //进度layer
        _progressLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.path = path.CGPath;
        _progressLayer.strokeColor = [UIColor blueColor].CGColor;
        _progressLayer.fillColor = [[UIColor clearColor] CGColor];
        _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
        _progressLayer.strokeEnd = 0.f;
        _progressLayer.strokeStart = 0.0f;
        _firstTime = true;
        grain.mask = _progressLayer;//设置遮盖层
    }
    return self;
}

- (void)setProgress:(float)progress {
//    [self startAninationWithStart:self.start withPro:progress];
    [self endAninationWithValue:progress];
}

// 此方法，实现的是规定开始与结束位置，实现一次性的绘制
- (void)startAninationWithStart:(CGFloat)start withPro:(CGFloat)pro
{
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    // 开始位置
    pathAnimation.fromValue = [NSNumber numberWithFloat:start];
    // 过程中的位置，即到什么位置结束
    pathAnimation.toValue = [NSNumber numberWithFloat:pro];
    // 插入值
    //pathAnimation.byValue = [NSNumber numberWithFloat:0.5];
    pathAnimation.autoreverses=NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

// 此方法实现绘制过程中，实时定制绘制的终点
-(void)endAninationWithValue:(CGFloat)end
{
    CABasicAnimation *pathAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    if (_firstTime){
        pathAnimation.fromValue = [NSNumber numberWithFloat:0];
    } else {
        pathAnimation.fromValue = [NSNumber numberWithFloat:_lastProgress];
    }
    // 插入值
//    pathAnimation.byValue = [NSNumber numberWithFloat:end];
    // 终点值
    pathAnimation.toValue = [NSNumber numberWithFloat:end];

    pathAnimation.autoreverses=NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.repeatCount = 1;
    _lastProgress = end;
    _firstTime = false;
    [_progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}


@end
