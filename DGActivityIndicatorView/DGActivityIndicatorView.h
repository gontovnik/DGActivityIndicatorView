//
//  DGActivityIndicatorView.h
//  DGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DGActivityIndicatorAnimationType) {
    DGActivityIndicatorAnimationTypeNineDots,
    DGActivityIndicatorAnimationTypeTriplePulse,
    DGActivityIndicatorAnimationTypeFiveDots,
    DGActivityIndicatorAnimationTypeRotatingSquares,
    DGActivityIndicatorAnimationTypeDoubleBounce,
    DGActivityIndicatorAnimationTypeTwoDots,
    DGActivityIndicatorAnimationTypeThreeDots,
    DGActivityIndicatorAnimationTypeBallPulse,
    DGActivityIndicatorAnimationTypeBallClipRotate,
    DGActivityIndicatorAnimationTypeBallClipRotatePulse,
    DGActivityIndicatorAnimationTypeBallClipRotateMultiple,
    DGActivityIndicatorAnimationTypeBallRotate,
    DGActivityIndicatorAnimationTypeBallZigZag,
    DGActivityIndicatorAnimationTypeBallZigZagDeflect,
    DGActivityIndicatorAnimationTypeBallTrianglePath,
    DGActivityIndicatorAnimationTypeBallScale,
    DGActivityIndicatorAnimationTypeLineScale,
    DGActivityIndicatorAnimationTypeLineScaleParty,
    DGActivityIndicatorAnimationTypeBallScaleMultiple,
    DGActivityIndicatorAnimationTypeBallPulseSync,
    DGActivityIndicatorAnimationTypeBallBeat,
    DGActivityIndicatorAnimationTypeLineScalePulseOut,
    DGActivityIndicatorAnimationTypeLineScalePulseOutRapid,
    DGActivityIndicatorAnimationTypeBallScaleRipple,
    DGActivityIndicatorAnimationTypeBallScaleRippleMultiple,
    DGActivityIndicatorAnimationTypeTriangleSkewSpin,
    DGActivityIndicatorAnimationTypeBallGridBeat,
    DGActivityIndicatorAnimationTypeBallGridPulse,
    DGActivityIndicatorAnimationTypeRotatingSandglass,
    DGActivityIndicatorAnimationTypeRotatingTrigons,
    DGActivityIndicatorAnimationTypeTripleRings,
    DGActivityIndicatorAnimationTypeCookieTerminator,
    DGActivityIndicatorAnimationTypeBallSpinFadeLoader
};

@interface DGActivityIndicatorView : UIView

- (id)initWithType:(DGActivityIndicatorAnimationType)type;
- (id)initWithType:(DGActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor;
- (id)initWithType:(DGActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size;

@property (nonatomic) DGActivityIndicatorAnimationType type;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) CGFloat size;

@property (nonatomic, readonly) BOOL animating;

- (void)startAnimating;
- (void)stopAnimating;

@end
