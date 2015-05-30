//
//  DGActivityIndicatorRotatingSquaresAnimation.m
//  DGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorRotatingSquaresAnimation.h"

static CGFloat degreesToRadians(CGFloat degrees) { return (degrees) / 180.0 * M_PI; };

@implementation DGActivityIndicatorRotatingSquaresAnimation

#pragma mark -
#pragma mark DGActivityIndicatorAnimation Protocol

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor {
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat squareSize = floor(size.width / 4.0f);
    
    CGFloat oX = (layer.bounds.size.width - size.width) / 2.0f;
    CGFloat oY = (layer.bounds.size.height - size.height) / 2.0f;
    for (int i = 0; i < 2; i++) {
        CALayer *square = [CALayer layer];
        square.frame = CGRectMake(oX, oY, squareSize, squareSize);
        square.anchorPoint = CGPointMake(0.5f, 0.5f);
        square.backgroundColor = tintColor.CGColor;
        square.shouldRasterize = YES;
        square.rasterizationScale = [[UIScreen mainScreen] scale];
        
        CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        transformAnimation.removedOnCompletion = NO;
        transformAnimation.duration = 1.6f;
        transformAnimation.beginTime = beginTime - (i * transformAnimation.duration / 2.0f);
        transformAnimation.repeatCount = HUGE_VALF;
        
        transformAnimation.keyTimes = @[@(0.0f), @(0.25f), @(0.50f), @(0.75f), @(1.0f)];
        transformAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                               [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        
        CATransform3D t1 = CATransform3DMakeTranslation(size.width - squareSize, 0.0f, 0.0f);
        t1 = CATransform3DRotate(t1, degreesToRadians(-90.0f), 0.0f, 0.0f, 1.0f);
        t1 = CATransform3DScale(t1, 0.5f, 0.5f, 1.0f);
        
        CATransform3D t2 = CATransform3DMakeTranslation(size.width - squareSize, size.height - squareSize, 0.0f);
        t2 = CATransform3DRotate(t2, degreesToRadians(-180.0f), 0.0f, 0.0f, 1.0f);
        t2 = CATransform3DScale(t2, 1.0, 1.0, 1.0f);
        
        CATransform3D t3 = CATransform3DMakeTranslation(0.0f, size.height - squareSize, 0.0f);
        t3 = CATransform3DRotate(t3, degreesToRadians(-270.0f), 0.0f, 0.0f, 1.0f);
        t3 = CATransform3DScale(t3, 0.5f, 0.5f, 1.0f);
        
        CATransform3D t4 = CATransform3DMakeTranslation(0.0f, 0.0f, 0.0f);
        t4 = CATransform3DRotate(t4, degreesToRadians(-360.0f), 0.0f, 0.0f, 1.0f);
        t4 = CATransform3DScale(t4, 1.0, 1.0, 1.0f);
        
        transformAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DIdentity],
                                      [NSValue valueWithCATransform3D:t1],
                                      [NSValue valueWithCATransform3D:t2],
                                      [NSValue valueWithCATransform3D:t3],
                                      [NSValue valueWithCATransform3D:t4]];
        
        [layer addSublayer:square];
        [square addAnimation:transformAnimation forKey:@"animation"];
    }
}

@end
