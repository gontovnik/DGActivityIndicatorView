//
//  DGActivityIndicatorFiveDotsAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorFiveDotsAnimation.h"

@implementation DGActivityIndicatorFiveDotsAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat circleSize = size.width / 5.0f;
    
    CGFloat oX = (layer.bounds.size.width - circleSize * 5) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - circleSize) / 2.0f;
    for (int i = 0; i < 3; i++) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(oX + circleSize * 2 * i, oY, circleSize, circleSize);
        circle.backgroundColor = tintColor.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 1.0f;
        circle.cornerRadius = circle.bounds.size.height / 2.0f;
        
        CATransform3D t1 = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);
        t1 = CATransform3DScale(t1, 1.0f, 1.0f, 0.0f);
        
        CATransform3D t2 = CATransform3DMakeTranslation(0.0f, -2 * circleSize, 0.0f);
        t2 = CATransform3DScale(t2, 1.0f, 1.0f, 0.0f);
        
        CATransform3D t3 = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);
        t3 = CATransform3DScale(t3, 0.3f, 0.3f, 0.0f);
        
        CATransform3D t4 = CATransform3DMakeTranslation(0.0f, 2 * circleSize, 0.0f);
        t4 = CATransform3DScale(t4, 1.0f, 1.0f, 0.0f);
        
        CATransform3D t5 = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);
        t5 = CATransform3DScale(t5, 1.f, 1.0f, 0.0f);
        
        CAKeyframeAnimation *transformAnimation = [self createKeyframeAnimationWithKeyPath:@"transform"];
        transformAnimation.values = @[[NSValue valueWithCATransform3D:t1],
                                      [NSValue valueWithCATransform3D:t2],
                                      [NSValue valueWithCATransform3D:t3],
                                      [NSValue valueWithCATransform3D:t4],
                                      [NSValue valueWithCATransform3D:t5]];
        transformAnimation.beginTime = beginTime;
        transformAnimation.repeatCount = HUGE_VALF;
        transformAnimation.duration = 1.0f;
        transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [layer addSublayer:circle];
        [circle addAnimation:transformAnimation forKey:@"animation"];
    }
    
    for (int i = 0; i < 2; i++) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake((layer.bounds.size.width - circleSize * 5) / 2.0f + circleSize + circleSize * 2 * i, (layer.bounds.size.height - circleSize) / 2.0f, circleSize, circleSize);
        circle.backgroundColor = tintColor.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 1.0f;
        circle.cornerRadius = circle.bounds.size.height / 2.0f;
        
        CATransform3D t1 = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);
        t1 = CATransform3DScale(t1, 0.3f, 0.3f, 0.0f);
        
        CATransform3D t2 = CATransform3DMakeTranslation(0.0f, 2 * circleSize, 0.0f);
        t2 = CATransform3DScale(t2, 1.0f, 1.0f, 0.0f);
        
        CATransform3D t3 = CATransform3DMakeTranslation(0.0f, -2 * circleSize, 0.0f);
        t3 = CATransform3DScale(t3, 1.f, 1.0f, 0.0f);
        
        CATransform3D t4 = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);
        t4 = CATransform3DScale(t4, 0.3f, 0.3f, 0.0f);
        
        CAKeyframeAnimation *transformAnimation = [self createKeyframeAnimationWithKeyPath:@"transform"];
        transformAnimation.values = @[[NSValue valueWithCATransform3D:t1],
                                      [NSValue valueWithCATransform3D:t2],
                                      [NSValue valueWithCATransform3D:t3],
                                      [NSValue valueWithCATransform3D:t4]];
        transformAnimation.keyTimes = @[@(0.0f), @(0.25f), @(0.75f), @(1.0f)];
        transformAnimation.beginTime = beginTime;
        transformAnimation.repeatCount = HUGE_VALF;
        transformAnimation.duration = 1.0f;
        transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [layer addSublayer:circle];
        [circle addAnimation:transformAnimation forKey:@"animation"];
    }
}

@end
