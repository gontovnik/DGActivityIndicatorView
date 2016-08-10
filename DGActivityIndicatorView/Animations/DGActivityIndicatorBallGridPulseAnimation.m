//
//  DGActivityIndicatorBallGridPulseAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallGridPulseAnimation.h"

@implementation DGActivityIndicatorBallGridPulseAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSArray *durations = @[@0.72f, @1.02f, @1.28f, @1.42f, @1.45f, @1.18f, @0.87f, @1.45f, @1.06f];
    NSArray *timeOffsets = @[@-0.06f, @0.25f, @-0.17f, @0.48f, @0.31f, @0.03f, @0.46f, @0.78f, @0.45f];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CGFloat circleSpacing = 2;
    CGFloat circleSize = (size.width - circleSpacing * 2) / 3;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    
    // Scale animation
    CAKeyframeAnimation *scaleAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    scaleAnimation.values = @[@1.0f, @0.5f, @1.0f];
    scaleAnimation.timingFunctions = @[timingFunction, timingFunction];

    // Animation
    CAKeyframeAnimation *opacityAnimation = [self createKeyframeAnimationWithKeyPath:@"opacity"];
    
    opacityAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    opacityAnimation.values = @[@1.0f, @0.7f, @1.0f];
    opacityAnimation.timingFunctions = @[timingFunction, timingFunction];
    
    // Animation
    CAAnimationGroup *animation = [self createAnimationGroup];;
    
    animation.animations = @[scaleAnimation, opacityAnimation];
    animation.beginTime = CACurrentMediaTime();
    animation.repeatCount = HUGE_VALF;
    
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
