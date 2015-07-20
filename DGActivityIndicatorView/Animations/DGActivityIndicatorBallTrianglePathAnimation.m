//
//  DGActivityIndicatorBallTrianglePathAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Nguyen Vinh on 7/20/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorBallTrianglePathAnimation.h"

@implementation DGActivityIndicatorBallTrianglePathAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    CGFloat duration = 2.0f;
    CGFloat circleSize = size.width / 5;
    CGFloat deltaX = size.width / 2 - circleSize / 2;
    CGFloat deltaY = size.height / 2 - circleSize / 2;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.keyTimes = @[@0.0f, @0.33f, @0.66f, @1.0f];
    animation.duration = duration;
    animation.timingFunctions = @[timingFunction, timingFunction, timingFunction];
    animation.repeatCount = HUGE_VALF;
    
    // Top-center circle
    CALayer *topCenterCircle = [self createCircleWithSize:circleSize color:tintColor];
    
    [self changeAnimation:animation values:@[@"{0,0}", @"{hx,fy}", @"{-hx,fy}", @"{0,0}"] deltaX:deltaX deltaY:deltaY];
    topCenterCircle.frame = CGRectMake(x + size.width / 2 - circleSize / 2, y, circleSize, circleSize);
    [topCenterCircle addAnimation:animation forKey:@"animation"];
    [layer addSublayer:topCenterCircle];
    
    // Bottom-left circle
    CALayer *bottomLeftCircle = [self createCircleWithSize:circleSize color:tintColor];
    
    [self changeAnimation:animation values:@[@"{0,0}", @"{hx,-fy}", @"{fx,0}", @"{0,0}"] deltaX:deltaX deltaY:deltaY];
    bottomLeftCircle.frame = CGRectMake(x, y + size.height - circleSize, circleSize, circleSize);
    [bottomLeftCircle addAnimation:animation forKey:@"animation"];
    [layer addSublayer:bottomLeftCircle];
    
    // Bottom-right circle
    CALayer *bottomRigthCircle = [self createCircleWithSize:circleSize color:tintColor];
    
    [self changeAnimation:animation values:@[@"{0,0}", @"{-fx,0}", @"{-hx,-fy}", @"{0,0}"] deltaX:deltaX deltaY:deltaY];
    bottomRigthCircle.frame = CGRectMake(x + size.width - circleSize, y + size.height - circleSize, circleSize, circleSize);
    [bottomRigthCircle addAnimation:animation forKey:@"animation"];
    [layer addSublayer:bottomRigthCircle];
}

- (CALayer *)createCircleWithSize:(CGFloat)size color:(UIColor *)color {
    CAShapeLayer *circle = [CAShapeLayer layer];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size, size) cornerRadius:size / 2];
    
    circle.fillColor = nil;
    circle.strokeColor = color.CGColor;
    circle.lineWidth = 1;
    circle.path = circlePath.CGPath;
    
    return circle;
}

- (CAAnimation *)changeAnimation:(CAKeyframeAnimation *)animation values:(NSArray *)rawValues deltaX:(CGFloat)deltaX deltaY:(CGFloat)deltaY {
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:5];
    
    for (NSString *rawValue in rawValues) {
        CGPoint point = CGPointFromString([self translate:rawValue withDeltaX:deltaX deltaY:deltaY]);
        
        [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(point.x, point.y, 0)]];
    }
    animation.values = values;
    
    return animation;
}

- (NSString *)translate:(NSString *)valueString withDeltaX:(CGFloat)deltaX deltaY:(CGFloat)deltaY {
    NSMutableString *valueMutableString = [NSMutableString stringWithString:valueString];
    CGFloat fullDeltaX = 2 * deltaX;
    CGFloat fullDeltaY = 2 * deltaY;
    NSRange range;
    
    range.location = 0;
    range.length = valueString.length;
    
    [valueMutableString replaceOccurrencesOfString:@"hx" withString:[NSString stringWithFormat:@"%f", deltaX] options:NSCaseInsensitiveSearch range:range];
    range.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"fx" withString:[NSString stringWithFormat:@"%f", fullDeltaX] options:NSCaseInsensitiveSearch range:range];
    range.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"hy" withString:[NSString stringWithFormat:@"%f", deltaY] options:NSCaseInsensitiveSearch range:range];
    range.length = valueMutableString.length;
    [valueMutableString replaceOccurrencesOfString:@"fy" withString:[NSString stringWithFormat:@"%f", fullDeltaY] options:NSCaseInsensitiveSearch range:range];
    
    return valueMutableString;
}

@end
