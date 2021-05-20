//
//  DGActivityIndicatorTriplePulseAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorTriplePulseAnimation.h"

@implementation DGActivityIndicatorTriplePulseAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - size.height) / 2.0f;
    for (int i = 0; i < 4; i++) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(oX, oY, size.width, size.height);
        circle.backgroundColor = tintColor.CGColor;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.opacity = 0.8f;
        circle.cornerRadius = circle.bounds.size.height / 2.0f;
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        
        CABasicAnimation *transformAnimation = [self createBasicAnimationWithKeyPath:@"transform"];
        transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0f, 0.0f, 0.0f)];
        transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 0.0f)];
        
        CABasicAnimation *opacityAnimation = [self createBasicAnimationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = @(0.8f);
        opacityAnimation.toValue = @(0.0f);
        
        CAAnimationGroup *animationGroup = [self createAnimationGroup];;
        animationGroup.beginTime = beginTime + i * 0.2f;
        animationGroup.repeatCount = HUGE_VALF;
        animationGroup.duration = 1.2f;
        animationGroup.animations = @[transformAnimation, opacityAnimation];
        
        [layer addSublayer:circle];
        [circle addAnimation:animationGroup forKey:@"animation"];
    }
}

@end
