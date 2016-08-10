//
//  DGActivityIndicatorTriangleSkewSpinAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorTriangleSkewSpinAnimation.h"

@implementation DGActivityIndicatorTriangleSkewSpinAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 3.0f;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.09f :0.57f :0.49f :0.9f];
    
    // Rotation x animation
    CAKeyframeAnimation *rotationXAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.rotation.x"];
    
    rotationXAnimation.duration = duration;
    rotationXAnimation.keyTimes = @[@0.0f, @0.25f, @0.5f, @0.75f, @1.0f];
    rotationXAnimation.values = @[@0.0f, @M_PI, @M_PI, @0.0f, @0.0f];
    rotationXAnimation.timingFunctions = @[timingFunction, timingFunction, timingFunction, timingFunction];
    
    // Rotation x animation
    CAKeyframeAnimation *rotationYAnimation = [self createKeyframeAnimationWithKeyPath:@"transform.rotation.y"];
    
    rotationYAnimation.duration = duration;
    rotationYAnimation.keyTimes = @[@0.0f, @0.25f, @0.5f, @0.75f, @1.0f];
    rotationYAnimation.values = @[@0.0f, @0.0f, @M_PI, @M_PI, @0.0f];
    rotationYAnimation.timingFunctions = @[timingFunction, timingFunction, timingFunction, timingFunction];
    
    // Animation
    CAAnimationGroup *animation = [self createAnimationGroup];;
    
    animation.animations = @[rotationXAnimation, rotationYAnimation];
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    
    // Draw triangle
    CAShapeLayer *triangle = [CAShapeLayer layer];
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    CGFloat offsetY = size.height / 4;
    
    [trianglePath  moveToPoint:CGPointMake(0, size.height - offsetY)];
    [trianglePath addLineToPoint:CGPointMake(size.width / 2, size.height / 2 - offsetY)];
    [trianglePath addLineToPoint:CGPointMake(size.width, size.height - offsetY)];
    [trianglePath closePath];
    triangle.fillColor = tintColor.CGColor;
    triangle.path = trianglePath.CGPath;
    [triangle addAnimation:animation forKey:@"animation"];
    triangle.frame = CGRectMake(x, y, size.width, size.height);
    [layer addSublayer:triangle];
}

@end
