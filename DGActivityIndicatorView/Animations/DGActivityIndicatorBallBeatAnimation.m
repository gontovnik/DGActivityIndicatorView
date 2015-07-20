//
//  DGActivityIndicatorBallBeatAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallBeatAnimation.h"

@implementation DGActivityIndicatorBallBeatAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 0.7f;
    NSArray *beginTimes = @[@0.35f, @0.0f, @0.35f];
    CGFloat circleSpacing = 2.0f;
    CGFloat circleSize = (size.width - circleSpacing * 2) / 3;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - circleSize) / 2;
    
    // Scale animation
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    scaleAnimation.values = @[@1.0f, @0.75f, @1.0f];
    
    // Opacity animation
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    opacityAnimation.values = @[@1.0f, @0.2f, @1.0f];
    
    // Aniamtion
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    
    animation.duration = duration;
    animation.animations = @[scaleAnimation, opacityAnimation];
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Draw circles
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *circle = [CAShapeLayer layer];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, circleSize, circleSize) cornerRadius:circleSize / 2];
        
        animation.beginTime = [beginTimes[i] floatValue];
        circle.fillColor = tintColor.CGColor;
        circle.path = circlePath.CGPath;
        [circle addAnimation:animation forKey:@"animation"];
        circle.frame = CGRectMake(x + circleSize * i + circleSpacing * i, y, circleSize, circleSize);
        [layer addSublayer:circle];
    }
}

@end
