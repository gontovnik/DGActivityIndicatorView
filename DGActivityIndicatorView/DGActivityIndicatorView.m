//
//  DGActivityIndicatorView.m
//  DGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "DGActivityIndicatorView.h"

#import "DGActivityIndicatorNineDotsAnimation.h"
#import "DGActivityIndicatorTriplePulseAnimation.h"
#import "DGActivityIndicatorFiveDotsAnimation.h"
#import "DGActivityIndicatorRotatingSquaresAnimation.h"
#import "DGActivityIndicatorDoubleBounceAnimation.h"
#import "DGActivityIndicatorTwoDotsAnimation.h"
#import "DGActivityIndicatorThreeDotsAnimation.h"
#import "DGActivityIndicatorBallPulseAnimation.h"
#import "DGActivityIndicatorBallClipRotateAnimation.h"
#import "DGActivityIndicatorBallClipRotatePulseAnimation.h"
#import "DGActivityIndicatorBallClipRotateMultipleAnimation.h"
#import "DGActivityIndicatorBallRotateAnimation.h"
#import "DGActivityIndicatorBallZigZagAnimation.h"
#import "DGActivityIndicatorBallZigZagDeflectAnimation.h"
#import "DGActivityIndicatorBallTrianglePathAnimation.h"
#import "DGActivityIndicatorBallScaleAnimation.h"
#import "DGActivityIndicatorLineScaleAnimation.h"
#import "DGActivityIndicatorLineScalePartyAnimation.h"
#import "DGActivityIndicatorBallScaleMultipleAnimation.h"
#import "DGActivityIndicatorBallPulseSyncAnimation.h"
#import "DGActivityIndicatorBallBeatAnimation.h"
#import "DGActivityIndicatorLineScalePulseOutAnimation.h"
#import "DGActivityIndicatorLineScalePulseOutRapidAnimation.h"
#import "DGActivityIndicatorBallScaleRippleAnimation.h"
#import "DGActivityIndicatorBallScaleRippleMultipleAnimation.h"
#import "DGActivityIndicatorTriangleSkewSpinAnimation.h"
#import "DGActivityIndicatorBallGridBeatAnimation.h"
#import "DGActivityIndicatorBallGridPulseAnimation.h"
#import "DGActivityIndicatorRotatingSandglassAnimation.h"
#import "DGActivityIndicatorRotatingTrigonAnimation.h"
#import "DGActivityIndicatorTripleRingsAnimation.h"
#import "DGActivityIndicatorCookieTerminatorAnimation.h"
#import "DGActivityIndicatorBallSpinFadeLoader.h"

static const CGFloat kDGActivityIndicatorDefaultSize = 40.0f;

@interface DGActivityIndicatorView () {
    CALayer *_animationLayer;
}

@end

@implementation DGActivityIndicatorView

#pragma mark -
#pragma mark Constructors

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _tintColor = [UIColor whiteColor];
        _size = kDGActivityIndicatorDefaultSize;
        [self commonInit];
    }
    return self;
}

- (id)initWithType:(DGActivityIndicatorAnimationType)type {
    return [self initWithType:type tintColor:[UIColor whiteColor] size:kDGActivityIndicatorDefaultSize];
}

- (id)initWithType:(DGActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor {
    return [self initWithType:type tintColor:tintColor size:kDGActivityIndicatorDefaultSize];
}

- (id)initWithType:(DGActivityIndicatorAnimationType)type tintColor:(UIColor *)tintColor size:(CGFloat)size {
    self = [super init];
    if (self) {
        _type = type;
        _size = size;
        _tintColor = tintColor;
        [self commonInit];
    }
    return self;
}

#pragma mark -
#pragma mark Methods

- (void)commonInit {
    self.userInteractionEnabled = NO;
    self.hidden = YES;
    
    _animationLayer = [[CALayer alloc] init];
    [self.layer addSublayer:_animationLayer];

    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}

- (void)setupAnimation {
    _animationLayer.sublayers = nil;
    
    id<DGActivityIndicatorAnimationProtocol> animation = [DGActivityIndicatorView activityIndicatorAnimationForAnimationType:_type];
    
    if ([animation respondsToSelector:@selector(setupAnimationInLayer:withSize:tintColor:)]) {
        [animation setupAnimationInLayer:_animationLayer withSize:CGSizeMake(_size, _size) tintColor:_tintColor];
        _animationLayer.speed = 0.0f;
    }
}

- (void)startAnimating {
    if (!_animationLayer.sublayers) {
        [self setupAnimation];
    }
    self.hidden = NO;
    _animationLayer.speed = 1.0f;
    _animating = YES;
}

- (void)stopAnimating {
    _animationLayer.speed = 0.0f;
    _animating = NO;
    self.hidden = YES;
}

#pragma mark -
#pragma mark Setters

- (void)setType:(DGActivityIndicatorAnimationType)type {
    if (_type != type) {
        _type = type;
        
        [self setupAnimation];
    }
}

- (void)setSize:(CGFloat)size {
    if (_size != size) {
        _size = size;
        
        [self setupAnimation];
        [self invalidateIntrinsicContentSize];
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (![_tintColor isEqual:tintColor]) {
        _tintColor = tintColor;
        
        CGColorRef tintColorRef = tintColor.CGColor;
        for (CALayer *sublayer in _animationLayer.sublayers) {
            sublayer.backgroundColor = tintColorRef;
            
            if ([sublayer isKindOfClass:[CAShapeLayer class]]) {
                CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
                shapeLayer.strokeColor = tintColorRef;
                shapeLayer.fillColor = tintColorRef;
            }
        }
    }
}

#pragma mark -
#pragma mark Getters

+ (id<DGActivityIndicatorAnimationProtocol>)activityIndicatorAnimationForAnimationType:(DGActivityIndicatorAnimationType)type {
    switch (type) {
        case DGActivityIndicatorAnimationTypeNineDots:
            return [[DGActivityIndicatorNineDotsAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeTriplePulse:
            return [[DGActivityIndicatorTriplePulseAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeFiveDots:
            return [[DGActivityIndicatorFiveDotsAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeRotatingSquares:
            return [[DGActivityIndicatorRotatingSquaresAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeDoubleBounce:
            return [[DGActivityIndicatorDoubleBounceAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeTwoDots:
            return [[DGActivityIndicatorTwoDotsAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeThreeDots:
            return [[DGActivityIndicatorThreeDotsAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallPulse:
            return [[DGActivityIndicatorBallPulseAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallClipRotate:
            return [[DGActivityIndicatorBallClipRotateAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallClipRotatePulse:
            return [[DGActivityIndicatorBallClipRotatePulseAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallClipRotateMultiple:
            return [[DGActivityIndicatorBallClipRotateMultipleAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallRotate:
            return [[DGActivityIndicatorBallRotateAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallZigZag:
            return [[DGActivityIndicatorBallZigZagAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallZigZagDeflect:
            return [[DGActivityIndicatorBallZigZagDeflectAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallTrianglePath:
            return [[DGActivityIndicatorBallTrianglePathAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallScale:
            return [[DGActivityIndicatorBallScaleAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeLineScale:
            return [[DGActivityIndicatorLineScaleAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeLineScaleParty:
            return [[DGActivityIndicatorLineScalePartyAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallScaleMultiple:
            return [[DGActivityIndicatorBallScaleMultipleAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallPulseSync:
            return [[DGActivityIndicatorBallPulseSyncAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallBeat:
            return [[DGActivityIndicatorBallBeatAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeLineScalePulseOut:
            return [[DGActivityIndicatorLineScalePulseOutAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeLineScalePulseOutRapid:
            return [[DGActivityIndicatorLineScalePulseOutRapidAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallScaleRipple:
            return [[DGActivityIndicatorBallScaleRippleAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallScaleRippleMultiple:
            return [[DGActivityIndicatorBallScaleRippleMultipleAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeTriangleSkewSpin:
            return [[DGActivityIndicatorTriangleSkewSpinAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallGridBeat:
            return [[DGActivityIndicatorBallGridBeatAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeBallGridPulse:
            return [[DGActivityIndicatorBallGridPulseAnimation alloc] init];
        case DGActivityIndicatorAnimationTypeRotatingSandglass:
            return [[DGActivityIndicatorRotatingSandglassAnimation alloc]init];
        case DGActivityIndicatorAnimationTypeRotatingTrigons:
            return [[DGActivityIndicatorRotatingTrigonAnimation alloc]init];
        case DGActivityIndicatorAnimationTypeTripleRings:
            return [[DGActivityIndicatorTripleRingsAnimation alloc]init];
        case DGActivityIndicatorAnimationTypeCookieTerminator:
            return [[DGActivityIndicatorCookieTerminatorAnimation alloc]init];
        case DGActivityIndicatorAnimationTypeBallSpinFadeLoader:
            return [[DGActivityIndicatorBallSpinFadeLoader alloc] init];
    }
    return nil;
}

#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _animationLayer.frame = self.bounds;

    BOOL animating = _animating;

    if (animating)
        [self stopAnimating];

    [self setupAnimation];

    if (animating)
        [self startAnimating];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(_size, _size);
}

@end
