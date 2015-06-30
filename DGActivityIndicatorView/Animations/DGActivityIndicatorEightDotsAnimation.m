//
//  DGActivityIndicatorEightDotsAnimation.m
//  DGActivityIndicatorExample
//
//  Created by tripleCC on 15/6/30.
//  Copyright (c) 2015年 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorEightDotsAnimation.h"

@implementation DGActivityIndicatorEightDotsAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat circleSize = size.width / 4.0f;
    
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f;
    CGFloat oY = layer.bounds.size.height / 2.0f;
 
    CALayer *circle = [CALayer layer];
    circle.bounds = CGRectMake(0.0f, 0.0f, circleSize, circleSize);
    circle.position = CGPointMake(oX + circleSize / 2.0f, layer.bounds.size.height / 4.0f);
    circle.backgroundColor = tintColor.CGColor;
    circle.anchorPoint = CGPointMake(0.5f, 0.5f);
    circle.opacity = 1.0f;
    circle.cornerRadius = circle.bounds.size.height / 2.0f;
    
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    transformAnimation.fromValue = @1.0;
    transformAnimation.toValue = @0.4;
    transformAnimation.repeatCount = HUGE_VALF;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1.0;
    opacityAnimation.toValue = @0.4;
    opacityAnimation.repeatCount = HUGE_VALF;

    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.removedOnCompletion = NO;
    animationGroup.beginTime = beginTime;
    animationGroup.repeatCount = HUGE_VALF;
    animationGroup.duration = 0.8f;
    animationGroup.animations = @[transformAnimation, opacityAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [circle addAnimation:animationGroup forKey:@"animation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = 8;
    replicatorLayer.bounds = CGRectMake(0.0f, 0.0f, size.width, size.height);
    replicatorLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    replicatorLayer.instanceDelay = -0.8f / 8;
    replicatorLayer.position = CGPointMake(oX + size.width / 2.0f, oY);
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI * 2.0f / 8, 0.0f, 0.0f, 1.0f);
    replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    [replicatorLayer addSublayer:circle];
    [layer addSublayer:replicatorLayer];
}

@end
