//
//  ViewController.m
//  DGActivityIndicatorExample
//
//  Created by Danil Gontovnik on 5/23/15.
//  Copyright (c) 2015 Danil Gontovnik. All rights reserved.
//

#import "ViewController.h"

#import "DGActivityIndicatorView.h"

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:237/255.0f green:85/255.0f blue:101/255.0f alpha:1.0f];
    
    NSArray *activityTypes = @[@(DGActivityIndicatorAnimationTypeNineDots), @(DGActivityIndicatorAnimationTypeTriplePulse),
                               @(DGActivityIndicatorAnimationTypeFiveDots), @(DGActivityIndicatorAnimationTypeRotatingSquares),
                               @(DGActivityIndicatorAnimationTypeDoubleBounce), @(DGActivityIndicatorAnimationTypeTwoDots),
                               @(DGActivityIndicatorAnimationTypeThreeDots),
                               @(DGActivityIndicatorAnimationTypeBallPulse),
                               @(DGActivityIndicatorAnimationTypeBallClipRotate),
                               @(DGActivityIndicatorAnimationTypeBallClipRotatePulse),
                               @(DGActivityIndicatorAnimationTypeBallClipRotateMultiple),
                               @(DGActivityIndicatorAnimationTypeBallRotate),
                               @(DGActivityIndicatorAnimationTypeBallZigZag),
                               @(DGActivityIndicatorAnimationTypeBallZigZagDeflect),
                               @(DGActivityIndicatorAnimationTypeBallTrianglePath),
                               @(DGActivityIndicatorAnimationTypeBallScale),
                               @(DGActivityIndicatorAnimationTypeLineScale),
                               @(DGActivityIndicatorAnimationTypeLineScaleParty),
                               @(DGActivityIndicatorAnimationTypeBallScaleMultiple)];
    
    for (int i = 0; i < activityTypes.count; i++) {
        DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[activityTypes[i] integerValue] tintColor:[UIColor whiteColor]];
        
        CGFloat width = self.view.bounds.size.width / 5.0f;
        CGFloat height = self.view.bounds.size.height / 5.0f;
        activityIndicatorView.frame = CGRectMake(width * (i % 5), height * (int)(i / 5), width, height);
        
        [self.view addSubview:activityIndicatorView];
        
        [activityIndicatorView startAnimating];
    }
}

@end
