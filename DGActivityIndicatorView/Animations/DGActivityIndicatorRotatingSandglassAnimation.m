//
//  DGActivityIndicatorRotatingTrigonsAnimation.m
//  DGActivityIndicatorExample
//
//  Created by tripleCC on 15/6/26.
//  Copyright (c) 2015年 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorRotatingSandglassAnimation.h"

@implementation DGActivityIndicatorRotatingSandglassAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat circleSize = size.width / 4.0f;;
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - size.width) / 2.0f;

    for (int i = 0; i < 2; i++) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(oX + i * (size.width - 2.0f * circleSize), (size.height - circleSize) * i + oY, circleSize, circleSize);
        circle.cornerRadius = circle.bounds.size.height / 2.0f;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        circle.backgroundColor = tintColor.CGColor;
        circle.shouldRasterize = YES;
        circle.rasterizationScale = [[UIScreen mainScreen] scale];
        
        CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.repeatCount = HUGE_VALF;
        transformAnimation.duration = 0.8f;
        transformAnimation.beginTime = beginTime;
        transformAnimation.keyTimes = @[@(0.0f), @(1.0f / 3.0f), @(2.0f / 3.0f), @(1.0)];
        
        transformAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        
        CATransform3D t1 = CATransform3DMakeTranslation((1.0f - 2.0f * i) * (size.width - 2.0f * circleSize), 0.0f, 0.0f);
        
        CATransform3D t2 = CATransform3DMakeTranslation((1.0f - 2.0f * i) * (size.width - 2.0f * circleSize) / 2.0f, (1.0f - 2.0f * i) * (size.height - circleSize) / 2.0f, 0.0f);
        
        CATransform3D t3 = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);

        
        transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                      [NSValue valueWithCATransform3D:t1],
                                      [NSValue valueWithCATransform3D:t2],
                                      [NSValue valueWithCATransform3D:t3]];
        
        [layer addSublayer:circle];
        [circle addAnimation:transformAnimation forKey:@"animation"];
    }
}
@end
