//
//  DGActivityIndicatorBallRotateAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallRotateAnimation.h"

@implementation DGActivityIndicatorBallRotateAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 1.0f;
    CGFloat circleSize = size.width / 5;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7f :-0.13f :0.22f :0.86f];
    
    // Scale animation
    CAKeyframeAnimation *scaleAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6f, 0.6f, 1.0f)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    scaleAnimation.duration = duration;
    scaleAnimation.timingFunctions = @[timingFunction, timingFunction];
    
    // Rotate animation
    CAKeyframeAnimation *rotateAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.rotation.z"];
    
    rotateAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    rotateAnimation.values = @[@0, @-M_PI, @(-2 * M_PI)];
    rotateAnimation.duration = duration;
    rotateAnimation.timingFunctions = @[timingFunction, timingFunction];
    
    // Animation
    CAAnimationGroup *animation = [self createAnimationGroup];;
    
    animation.animations = @[scaleAnimation, rotateAnimation];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    
    // Draw circles
    CALayer *leftCircle = [CALayer layer];
    
    leftCircle.backgroundColor = tintColor.CGColor;
    leftCircle.opacity = 0.8f;
    leftCircle.cornerRadius = circleSize / 2;
    leftCircle.frame = CGRectMake(0, (size.height - circleSize) / 2, circleSize, circleSize);
    
    CALayer *rightCircle = [CALayer layer];
    
    rightCircle.backgroundColor = tintColor.CGColor;
    rightCircle.opacity = 0.8f;
    rightCircle.cornerRadius = circleSize / 2;
    rightCircle.frame = CGRectMake(size.width - circleSize, (size.height - circleSize) / 2, circleSize, circleSize);
    
    CALayer *centerCircle = [CALayer layer];
    
    centerCircle.backgroundColor = tintColor.CGColor;
    centerCircle.cornerRadius = circleSize / 2;
    centerCircle.frame = CGRectMake((size.width - circleSize) / 2, (size.height - circleSize) / 2, circleSize, circleSize);
    
    CALayer *circle = [CALayer layer];
    
    circle.frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
    [circle addSublayer:leftCircle];
    [circle addSublayer:rightCircle];
    [circle addSublayer:centerCircle];
    [circle addAnimation:animation forKey:@"animation"];
    [layer addSublayer:circle];
}

@end
