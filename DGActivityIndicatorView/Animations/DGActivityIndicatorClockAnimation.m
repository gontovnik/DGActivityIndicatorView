//
//  DGActivityIndicatorClockAnimation.m
//  DGActivityIndicatorExample
//
//  Created by lilingang on 16/8/23.
//  Copyright © 2016年 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorClockAnimation.h"

/**@brief The length of the hand ratio*/
CGFloat const DGLengthOfHandRatio = 0.618f;
/**@brief The Radius of cap*/
CGFloat const DGCapRadius = 1.5f;

@implementation DGActivityIndicatorClockAnimation

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor{
    //secondHand
    CGFloat secondHandLayerLength = size.width/2.0 * DGLengthOfHandRatio;
    CAShapeLayer *secondHandLayer = [self handLayerWithSize:size handWidth:1.5f handLength:secondHandLayerLength tailLength:5 tickLength:5 tintColor:tintColor];
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT32_MAX;
    rotationAnimation.removedOnCompletion = NO;
    [secondHandLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //miniteHand
    CGFloat miniteHandLayerLength = secondHandLayerLength * DGLengthOfHandRatio;
    CAShapeLayer *miniteHandLayer = [self handLayerWithSize:size handWidth:1.5f handLength:miniteHandLayerLength tailLength:1.5f tickLength:1.5f tintColor:tintColor];
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 30;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = INT32_MAX;
    rotationAnimation.removedOnCompletion = NO;
    [miniteHandLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //caplayer
    CAShapeLayer *capLayer = [CAShapeLayer layer];
    capLayer.masksToBounds = YES;
    capLayer.frame = CGRectMake(size.width / 2 - DGCapRadius, size.height / 2 - DGCapRadius, DGCapRadius * 2, DGCapRadius * 2);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:capLayer.bounds cornerRadius:DGCapRadius];
    capLayer.path = path.CGPath;
    capLayer.cornerRadius = DGCapRadius;
    capLayer.fillColor = tintColor.CGColor;
    capLayer.strokeColor = tintColor.CGColor;
    
    //clock dial
    CAShapeLayer *dialShareLayer = [CAShapeLayer layer];
    dialShareLayer.frame = CGRectMake((CGRectGetWidth(layer.bounds) - size.width)/2.0, (CGRectGetHeight(layer.bounds) - size.height)/2.0, size.width, size.height);
    dialShareLayer.cornerRadius = size.width/2.0;
    dialShareLayer.masksToBounds = YES;
    dialShareLayer.borderColor = tintColor.CGColor;
    dialShareLayer.borderWidth = 1.5f;
    [dialShareLayer addSublayer:miniteHandLayer];
    [dialShareLayer addSublayer:secondHandLayer];
    [dialShareLayer addSublayer:capLayer];
    [layer addSublayer:dialShareLayer];
}



- (CAShapeLayer *)handLayerWithSize:(CGSize)size
                            handWidth:(CGFloat)width
                           handLength:(CGFloat)length
                           tailLength:(CGFloat)tailLength
                           tickLength:(CGFloat)tickLength
                            tintColor:(UIColor *)tintColor{
    CGPoint dialCenter = CGPointMake(size.width/2.0, size.height/2.0);
    CGFloat layerWidth = width;
    CGFloat layerLength = length;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    CGPoint addingPoint;
    addingPoint = CGPointMake(dialCenter.x, dialCenter.y - layerWidth/2.0);
    [bezierPath moveToPoint:addingPoint];
    addingPoint = CGPointMake(dialCenter.x, dialCenter.y + layerWidth/2.0);
    [bezierPath addLineToPoint:addingPoint];
    addingPoint = CGPointMake(dialCenter.x + layerLength, dialCenter.y + layerWidth / 2.0);
    [bezierPath addLineToPoint:addingPoint];
    addingPoint =  CGPointMake(dialCenter.x + layerLength + tickLength,dialCenter.y);
    [bezierPath addLineToPoint:addingPoint];
    addingPoint = CGPointMake(dialCenter.x + layerLength, dialCenter.y - layerWidth / 2.0);
    [bezierPath addLineToPoint:addingPoint];
    [bezierPath closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.frame = CGRectMake(0, 0, size.width, size.height);
    shapeLayer.lineWidth = 0.2;
    shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer.fillColor = tintColor.CGColor;
    return shapeLayer;
}

@end
