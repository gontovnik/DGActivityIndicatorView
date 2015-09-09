//
//  DGActivityIndicatorLineScalePulseOutRapidAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorLineScalePulseOutRapidAnimation.h"

@implementation DGActivityIndicatorLineScalePulseOutRapidAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 0.9f;
    NSArray *beginTimes = @[@0.5f, @0.25f, @0.0f, @0.25f, @0.5f];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.11f :0.49f :0.38f :0.78f];
    CGFloat lineSize = size.width / 9;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    
    animation.keyTimes = @[@0.0f, @0.8f, @0.9f];
    animation.values = @[@1.0f, @0.3f, @1.0f];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.repeatCount = HUGE_VALF;
    animation.duration = duration;
    
    for (int i = 0; i < 5; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, lineSize, size.height) cornerRadius:lineSize / 2];
        
        animation.beginTime = [beginTimes[i] floatValue];
        line.fillColor = tintColor.CGColor;
        line.path = linePath.CGPath;
        [line addAnimation:animation forKey:@"animation"];
        line.frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, size.height);
        [layer addSublayer:line];
    }
}

@end
