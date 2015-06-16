//
//  DGActivityIndicatorThreeDotsAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 6/15/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorThreeDotsAnimation.h"

@implementation DGActivityIndicatorThreeDotsAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    NSTimeInterval duration = 0.5f;
    
    CGFloat circleSize = size.width / 4.0f;
    CGFloat circlePadding = circleSize / 2.0f;
    
    CGFloat oX = (layer.bounds.size.width - circleSize * 3 - circlePadding * 2) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - circleSize * 1) / 2.0f;
    
    for (int i = 0; i < 3; i++) {
        CALayer *circle = [CALayer layer];
        
        circle.frame = CGRectMake(oX + (circleSize + circlePadding) * (i % 3), oY, circleSize, circleSize);
        circle.backgroundColor = tintColor.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 1.0f;
        circle.cornerRadius = circle.bounds.size.width / 2.0f;
        
        CAKeyframeAnimation *tranformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        tranformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5f, 0.5f, 0.0f)],
                                     [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)]];
        
        CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        
        opacityAnimation.values = @[@(0.25f), @(1.0f)];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        
        animationGroup.removedOnCompletion = NO;
        animationGroup.autoreverses = YES;
        animationGroup.beginTime = beginTime;
        animationGroup.repeatCount = HUGE_VALF;
        animationGroup.duration = duration;
        animationGroup.animations = @[tranformAnimation, opacityAnimation];
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

        [layer addSublayer:circle];
        [circle addAnimation:animationGroup forKey:@"animation"];
    }
}

@end
