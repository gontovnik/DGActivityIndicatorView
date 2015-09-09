//
//  DGActivityIndicatorBallScaleRippleMultipleAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallScaleRippleMultipleAnimation.h"

@implementation DGActivityIndicatorBallScaleRippleMultipleAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 1.25f;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.21f :0.53f :0.56f :0.8f];
    NSArray *timeOffsets = @[@0.0f, @0.2f, @0.4f];
    
    // Scale animation
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.keyTimes = @[@0.0f, @0.7f];
    scaleAnimation.values = @[@0.1f, @1.0f];
    scaleAnimation.timingFunction = timingFunction;
    
    // Opacity animation
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0.0f, @0.7f, @1.0f];
    opacityAnimation.values = @[@1.0f, @0.7f, @0.0f];
    opacityAnimation.timingFunctions = @[timingFunction, timingFunction];
    
    // Animation
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    
    animation.animations = @[scaleAnimation, opacityAnimation];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    animation.beginTime = CACurrentMediaTime();
    
    // Draw circles
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *circle = [CAShapeLayer layer];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width / 2];
        
        animation.timeOffset = [timeOffsets[i] floatValue];
        circle.fillColor = nil;
        circle.lineWidth = 2;
        circle.strokeColor = tintColor.CGColor;
        circle.path = circlePath.CGPath;
        [circle addAnimation:animation forKey:@"animation"];
        circle.frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
        [layer addSublayer:circle];
    }
}

@end
