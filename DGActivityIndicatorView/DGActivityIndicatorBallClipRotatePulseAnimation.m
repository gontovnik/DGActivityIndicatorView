//
//  DGActivityIndicatorBallClipRotatePulseAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/19/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallClipRotatePulseAnimation.h"

@implementation DGActivityIndicatorBallClipRotatePulseAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 1.0f;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.09f :0.57f :0.49f :0.9f];
    
    // Small circle
    {
        CAKeyframeAnimation *scaleAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.scale"];
        
        scaleAnimation.keyTimes = @[@0.0f, @0.3f, @1.0f];
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3f, 0.3f, 1.0f)],
                                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
        scaleAnimation.duration = duration;
        scaleAnimation.repeatCount = HUGE_VALF;
        scaleAnimation.timingFunctions = @[timingFunction, timingFunction];
        
        CGFloat circleSize = size.width / 2;
        CALayer *circle = [CALayer layer];
        
        circle.frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
        circle.backgroundColor = tintColor.CGColor;
        circle.cornerRadius = circleSize / 2;
        [circle addAnimation:scaleAnimation forKey:@"animation"];
        [layer addSublayer:circle];
    }
    
    // Big circle
    {
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
        
        rotateAnimation.values = @[@0, @M_PI, @(2 * M_PI)];
        rotateAnimation.keyTimes = scaleAnimation.keyTimes;
        rotateAnimation.duration = duration;
        rotateAnimation.timingFunctions = @[timingFunction, timingFunction];
        
        // Animation
        CAAnimationGroup *animation = [self createAnimationGroup];;
        
        animation.animations = @[scaleAnimation, rotateAnimation];
        animation.duration = duration;
        animation.repeatCount = HUGE_VALF;
        
        // Draw big circle
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
        [circle addAnimation:animation forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

@end
