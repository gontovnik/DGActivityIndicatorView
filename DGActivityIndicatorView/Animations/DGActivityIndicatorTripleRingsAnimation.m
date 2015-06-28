//
//  DGActivityIndicatorTripleRingsPulseAnimation.m
//  DGActivityIndicatorExample
//
//  Created by tripleCC on 15/6/28.
//  Copyright (c) 2015年 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorTripleRingsAnimation.h"

@implementation DGActivityIndicatorTripleRingsAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.0f, 0.0f, size.width, size.width)];
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - size.height) / 2.0f;
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *circle = [CAShapeLayer layer];
        circle.path = path.CGPath;
        circle.fillColor = [UIColor clearColor].CGColor;
        circle.strokeColor = tintColor.CGColor;
        circle.frame = CGRectMake(oX, oY, size.width, size.height);
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 1.0f;
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        
        CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        transformAnimation.duration = 2.0f - i * 0.4f;
        transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1f, 0.1f, 0.0f)];
        transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)];
        transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.duration = transformAnimation.duration;
        opacityAnimation.fromValue = @(1.0f);
        opacityAnimation.toValue = @(0.8f);
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.removedOnCompletion = NO;
        animationGroup.beginTime = beginTime + i * 0.4f;
        animationGroup.repeatCount = HUGE_VALF;
        animationGroup.duration = 2.0f;
        animationGroup.animations = @[transformAnimation, opacityAnimation];
        
        [layer addSublayer:circle];
        [circle addAnimation:animationGroup forKey:@"animation"];
    }
}
@end
