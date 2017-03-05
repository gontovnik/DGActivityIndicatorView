//
//  DGActivityIndicatorBallGridBeatAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallGridBeatAnimation.h"

@implementation DGActivityIndicatorBallGridBeatAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSArray *durations = @[@0.96f, @0.93f, @1.19f, @1.13f, @1.34f, @0.94f, @1.2f, @0.82f, @1.19f];
    NSArray *timeOffsets = @[@0.36f, @0.4f, @0.68f, @0.41f, @0.71f, @-0.15f, @-0.12f, @0.01f, @0.32f];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CGFloat circleSpacing = 2;
    CGFloat circleSize = (size.width - circleSpacing * 2) / 3;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    
    // Animation
    CAKeyframeAnimation *animation = [self createKeyframeAnimationWithKeyPath:@"opacity"];
    
    animation.beginTime = CACurrentMediaTime();
    animation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    animation.values = @[@1.0f, @0.7f, @1.0f];
    animation.repeatCount = HUGE_VALF;
    animation.timingFunctions = @[timingFunction, timingFunction];
    
    // Draw circle
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            CALayer *circle = [self createCirleWith:circleSize color:tintColor];
            
            animation.duration = [durations[3 * i + j] floatValue];
            animation.timeOffset = [timeOffsets[3 * i + j] floatValue];
            circle.frame = CGRectMake(x + circleSize * j + circleSpacing * j, y + circleSize * i + circleSpacing * i, circleSize, circleSize);
            [circle addAnimation:animation forKey:@"animation"];
            [layer addSublayer:circle];
        }
    }
}

- (CALayer *)createCirleWith:(CGFloat)size color:(UIColor *)color {
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size, size) cornerRadius:size / 2];
    
    circle.fillColor = color.CGColor;
    circle.path = circlePath.CGPath;
    
    return circle;
}

@end
