//
//  DGActivityIndicatorRotatingTrigonsAnimation.m
//  DGActivityIndicatorExample
//
//  Created by tripleCC on 15/6/26.
//  Copyright (c) 2015年 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorRotatingTrigonAnimation.h"

@implementation DGActivityIndicatorRotatingTrigonAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat circleSize = size.width / 4.0f;;
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - size.width) / 2.0f;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circleSize, circleSize)];
    CGPoint pointA = CGPointMake(oX + size.width / 2.0f, oY + circleSize / 2.0f);
    CGPoint pointB = CGPointMake(oX + circleSize / 2.0f, oY + circleSize / 2.0f + sqrtf(powf((size.width - circleSize), 2) - powf((size.width / 2.0f - circleSize / 2.0f), 2)));
    CGPoint pointC = CGPointMake(oX + size.width - circleSize / 2.0f, pointB.y);
    
    for (int i = 0; i < 3; i++) {
        CAShapeLayer *circle = [CAShapeLayer layer];
        circle.path = path.CGPath;
        circle.fillColor = [UIColor clearColor].CGColor;
        circle.strokeColor = tintColor.CGColor;
        circle.bounds = CGRectMake(0, 0, circleSize, circleSize);
        circle.position = pointA;
        circle.anchorPoint = CGPointMake(0.5f, 0.5f);
        circle.transform = CATransform3DMakeScale(0.0f, 0.0f, 0.0f);
        circle.shouldRasterize = YES;
        circle.rasterizationScale = [[UIScreen mainScreen] scale];
        
        CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.repeatCount = HUGE_VALF;
        transformAnimation.duration = 2.0f;
        transformAnimation.beginTime = beginTime - (i * transformAnimation.duration / 3.0f);;
        transformAnimation.keyTimes = @[@(0.0f), @(1.0f / 3.0f), @(2.0f / 3.0f), @(1.0)];

        transformAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];

        CATransform3D t1 = CATransform3DMakeTranslation(pointB.x - pointA.x, pointB.y - pointA.y, 0.0f);

        CATransform3D t2 = CATransform3DMakeTranslation(pointC.x - pointA.x, pointC.y - pointA.y, 0.0f);
        
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
