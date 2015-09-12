//
//  DGActivityIndicatorBallSpinFadeLoader.m
//  CheeseDigest
//
//  Created by Robin.Chao on 9/8/15.
//  Copyright (c) 2015 mRocker. All rights reserved.
//

#import "DGActivityIndicatorBallSpinFadeLoader.h"

@implementation DGActivityIndicatorBallSpinFadeLoader


#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {

    CGFloat circleSpacing = -2;
    CGFloat circleSize = (size.width - 4 * circleSpacing) / 5;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    
    CFTimeInterval duration = 1;
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    NSArray *beginTimes = @[@0, @0.12, @0.24, @0.36, @0.48, @0.6, @0.72, @0.84];
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0, @0.5, @1];
    scaleAnimation.values = @[@1, @0.4, @1];
    scaleAnimation.duration = duration;
    
    
    CAKeyframeAnimation *opacityAnimaton = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    
    opacityAnimaton.keyTimes = @[@0, @0.5, @1];
    opacityAnimaton.values = @[@1, @0.3, @1];
    opacityAnimaton.duration = duration;
    
    
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[scaleAnimation, opacityAnimaton];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationGroup.duration = duration;
    animationGroup.repeatCount = HUGE;
    animationGroup.removedOnCompletion = NO;
    
    
    for (int i = 0; i < 8; i++) {
        CALayer *circle = [self circleLayer:(M_PI_4 * i) size:circleSize origin:CGPointMake(x, y) containerSize:size color:tintColor];
        animationGroup.beginTime = beginTime + [beginTimes[i] doubleValue];
        
        [layer addSublayer:circle];
        [circle addAnimation:animationGroup forKey:@"animation"];
    }
    
}


- (CALayer *)circleLayer:(CGFloat)angle size:(CGFloat)size origin:(CGPoint)origin containerSize:(CGSize)containerSize color:(UIColor *)color{
    CGFloat radius = containerSize.width/2;
    CALayer *circle = [self createLayerWith:CGSizeMake(size, size) color:color];
    CGRect frame = CGRectMake((origin.x + radius * (cos(angle) + 1) - size / 2), origin.y + radius * (sin(angle) + 1) - size / 2, size, size);
    circle.frame = frame;
    
    return circle;
}

- (CALayer *)createLayerWith:(CGSize)size color:(UIColor *)color{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path addArcWithCenter:CGPointMake(size.width / 2,size.height / 2) radius:(size.width / 2) startAngle:0 endAngle:2 * M_PI clockwise:NO];
    layer.fillColor = color.CGColor;
    layer.backgroundColor = nil;
    layer.path = path.CGPath;
    
    return layer;
}

@end
