//
//  DGActivityIndicatorBallPulseSyncAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallPulseSyncAnimation.h"

@implementation DGActivityIndicatorBallPulseSyncAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 0.6f;
    NSArray *beginTimes = @[@0.07f, @0.14f, @0.21f];
    CGFloat circleSpacing = 2.0f;
    CGFloat circleSize = (size.width - circleSpacing * 2) / 3;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - circleSize) / 2;
    CGFloat deltaY = (size.height / 2 - circleSize / 2) / 2;
    CAMediaTimingFunction *timingFunciton = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.duration = duration;
    animation.keyTimes = @[@0.0f, @0.33f, @0.66f, @1.0f];
    animation.values = @[@0.0f, @(deltaY), @(-deltaY), @0.0f];
    animation.timingFunctions = @[timingFunciton, timingFunciton, timingFunciton];
    animation.repeatCount = HUGE_VALF;
    
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
