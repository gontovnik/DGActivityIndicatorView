//
//  DGActivityIndicatorLineScalePartyAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorLineScalePartyAnimation.h"

@implementation DGActivityIndicatorLineScalePartyAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSArray *durations = @[@1.26f, @0.43f, @1.01f, @0.73f];
    NSArray *beginTimes = @[@0.77f, @0.29f, @0.28f, @0.74f];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CGFloat lineSize = size.width / 7;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    animation.values = @[@1.0f, @0.5f, @1.0f];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.repeatCount = HUGE_VALF;
    
    for (int i = 0; i < 4; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, lineSize, size.height) cornerRadius:lineSize / 2];
        
        animation.duration = [durations[i] floatValue];
        animation.beginTime = [beginTimes[i] floatValue];
        line.fillColor = tintColor.CGColor;
        line.path = linePath.CGPath;
        [line addAnimation:animation forKey:@"animation"];
        line.frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, size.height);
        [layer addSublayer:line];
    }
}

@end
