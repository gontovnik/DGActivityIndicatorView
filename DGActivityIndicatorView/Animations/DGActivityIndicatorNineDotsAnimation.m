//
//  DGActivityIndicatorNineDotsAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorNineDotsAnimation.h"

@implementation DGActivityIndicatorNineDotsAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat circleSize = size.width / 4.0f;
    CGFloat circlePadding = circleSize / 2.0f;
    
    CGFloat oX = (layer.bounds.size.width - circleSize * 3 - circlePadding * 2) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - circleSize * 3 - circlePadding * 2) / 2.0f;
    
    NSArray *timeOffsets = @[@(0.11f), @(0.42f), @(0.0f),
                             @(0.65f), @(0.48f), @(0.2f),
                             @(0.63f), @(0.95f), @(0.62f)];
    NSArray *durations = @[@(0.72f), @(1.02f), @(1.28f),
                           @(1.42f), @(1.45f), @(1.18f),
                           @(0.87f), @(1.45f), @(1.06f)];
    
    for (int i = 0; i < MIN(timeOffsets.count, durations.count); i++) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(oX + (circleSize + circlePadding) * (i % 3), oY + (circleSize + circlePadding) * (int)(i / 3), circleSize, circleSize);
        circle.backgroundColor = tintColor.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 1.0f;
        circle.cornerRadius = circle.bounds.size.height / 2.0f;
        
        CAKeyframeAnimation *transformAnimation = [self createKeyframeAnimationWithKeyPath:@"transform"];
        transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5f, 0.5f, 0.0f)],
                                      [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)],
                                      [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5f, 0.5f, 0.0f)]];
        
        CAKeyframeAnimation *opacityAnimation = [self createKeyframeAnimationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@(0.5f), @(1.0f), @(0.5f)];
        
        CAAnimationGroup *animationGroup = [self createAnimationGroup];;
        animationGroup.beginTime = beginTime;
        animationGroup.repeatCount = HUGE_VALF;
        animationGroup.duration = [durations[i] doubleValue];
        animationGroup.animations = @[transformAnimation, opacityAnimation];
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        animationGroup.timeOffset = [timeOffsets[i] doubleValue];
        
        [layer addSublayer:circle];
        [circle addAnimation:animationGroup forKey:@"animation"];
    }
}

@end
