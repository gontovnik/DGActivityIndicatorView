//
//  DGActivityIndicatorBallScaleMultipleAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallScaleMultipleAnimation.h"

@implementation DGActivityIndicatorBallScaleMultipleAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 1.0f;
    NSArray *beginTimes = @[@0.0f, @0.2f, @0.4f];
    
    // Scale animation
    CABasicAnimation *scaleAnimation = [self createBasicAnimationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.fromValue = @0.0f;
    scaleAnimation.toValue = @1.0f;
    
    // Opacity animation
    CAKeyframeAnimation *opacityAnimation = [self createKeyframeAnimationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0.0f, @0.05f, @1.0f];
    opacityAnimation.values = @[@0.0f, @1.0f, @0.0f];
    
    // Animation
    CAAnimationGroup *animation = [self createAnimationGroup];;
    
    animation.animations = @[scaleAnimation, opacityAnimation];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *circle = [CAShapeLayer layer];
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width / 2];
        
        animation.beginTime = [beginTimes[i] floatValue];
        circle.fillColor = tintColor.CGColor;
        circle.path = circlePath.CGPath;
        circle.opacity = 0.0f;
        [circle addAnimation:animation forKey:@"animation"];
        circle.frame = CGRectMake((layer.bounds.size.width - size.width) / 2, (layer.bounds.size.height - size.height) / 2, size.width, size.height);
        [layer addSublayer:circle];
    }
}

@end
