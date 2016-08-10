//
//  DGActivityIndicatorBallClipRotateMultipleAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/19/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallClipRotateMultipleAnimation.h"

@implementation DGActivityIndicatorBallClipRotateMultipleAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat bigDuration = 1.0f;
    CGFloat smallDuration = bigDuration / 2;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Big circle
    {
        CGFloat circleSize = size.width;
        CAShapeLayer *circle = [CAShapeLayer layer];
        UIBezierPath *circlePath = [UIBezierPath bezierPath];
        
        [circlePath addArcWithCenter:CGPointMake(circleSize / 2, circleSize / 2) radius:circleSize / 2 startAngle:-3 * M_PI / 4 endAngle:-M_PI / 4 clockwise:true];
        [circlePath moveToPoint:CGPointMake(circleSize / 2 - circleSize / 2 * cosf(M_PI / 4), circleSize / 2 + circleSize / 2 * sinf(M_PI / 4))];
        [circlePath addArcWithCenter:CGPointMake(circleSize / 2, circleSize / 2) radius:circleSize / 2 startAngle:-5 * M_PI / 4 endAngle:-7 * M_PI / 4 clockwise:false];
        circle.path = circlePath.CGPath;
        circle.lineWidth = 2;
        circle.fillColor = nil;
        circle.strokeColor = tintColor.CGColor;
        
        circle.frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
        [circle addAnimation: [self createAnimationInDuration:bigDuration withTimingFunction:timingFunction reverse:false] forKey:@"animation"];
        [layer addSublayer:circle];
    }
    
    // Small circle
    {
        CGFloat circleSize = size.width / 2;
        CAShapeLayer *circle = [CAShapeLayer layer];
        UIBezierPath *circlePath = [UIBezierPath bezierPath];
        
        [circlePath addArcWithCenter:CGPointMake(circleSize / 2, circleSize / 2) radius:circleSize / 2 startAngle:3 * M_PI / 4 endAngle:5 * M_PI / 4 clockwise:true];
        [circlePath moveToPoint:CGPointMake(circleSize / 2 + circleSize / 2 * cosf(M_PI / 4), circleSize / 2 - circleSize / 2 * sinf(M_PI / 4))];
        [circlePath addArcWithCenter:CGPointMake(circleSize / 2, circleSize / 2) radius:circleSize / 2 startAngle:-M_PI / 4 endAngle:M_PI / 4 clockwise:true];
        circle.path = circlePath.CGPath;
        circle.lineWidth = 2;
        circle.fillColor = nil;
        circle.strokeColor = tintColor.CGColor;
        
        circle.frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
        [circle addAnimation:[self createAnimationInDuration:smallDuration withTimingFunction:timingFunction reverse:true] forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

- (CAAnimation *)createAnimationInDuration:(CGFloat) duration withTimingFunction:(CAMediaTimingFunction *) timingFunction reverse:(BOOL) reverse {
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
    
    if (!reverse) {
        rotateAnimation.values = @[@0, @M_PI, @(2 * M_PI)];
    } else {
        rotateAnimation.values = @[@0, @-M_PI, @(-2 * M_PI)];
    }
    rotateAnimation.keyTimes = scaleAnimation.keyTimes;
    rotateAnimation.duration = duration;
    rotateAnimation.timingFunctions = @[timingFunction, timingFunction];
    
    // Animation
    CAAnimationGroup *animation = [self createAnimationGroup];;
    
    animation.animations = @[scaleAnimation, rotateAnimation];
    animation.repeatCount = HUGE_VALF;
    animation.duration = duration;
    
    return animation;
}

@end
