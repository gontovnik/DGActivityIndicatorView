//
//  DGActivityIndicatorBallZigZagAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallZigZagAnimation.h"

@implementation DGActivityIndicatorBallZigZagAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 0.7f;
    CGFloat circleSize = size.width / 5;
    CGFloat deltaX = size.width / 2 - circleSize / 2;
    CGFloat deltaY = size.height / 2 - circleSize / 2;
    
    // Circle 1 animation
    CAKeyframeAnimation *animation = [self createKeyframeAnimationWithKeyPath:@"transform"];
    
    animation.duration = duration;
    animation.keyTimes = @[@0.0f, @0.33f, @0.66f, @1.0f];
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-deltaX, -deltaY, 0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(deltaX, -deltaY, 0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = HUGE_VALF;
    
    // Draw circle 1
    {
        CALayer *circle = [CALayer layer];
        
        circle.backgroundColor = tintColor.CGColor;
        circle.cornerRadius = circleSize / 2;
        circle.frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
        [circle addAnimation:animation forKey:@"animation"];
        [layer addSublayer:circle];
    }
    
    // Circle 2 animation
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(deltaX, deltaY, 0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-deltaX, deltaY, 0)],
                          [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)]];
    
    // Draw circle 2
    {
        CALayer *circle = [CALayer layer];
        
        circle.backgroundColor = tintColor.CGColor;
        circle.cornerRadius = circleSize / 2;
        circle.frame = CGRectMake((layer.bounds.size.width - circleSize) / 2, (layer.bounds.size.height - circleSize) / 2, circleSize, circleSize);
        [circle addAnimation:animation forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

@end
