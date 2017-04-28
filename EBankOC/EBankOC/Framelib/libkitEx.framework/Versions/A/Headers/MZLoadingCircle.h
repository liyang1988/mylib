//
//  MZLoadingCircle.h
//  MZLoading
//
//  Created by Serghei Mazur on 10/31/13.
//  Copyright (c) 2013 Serghei Mazur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface MZLoadingCircle : UIView
@property (nonatomic,readonly)BOOL  isAnimating;
@property (weak,nonatomic) UIColor *colorCustomLayer  UI_APPEARANCE_SELECTOR;
@property (weak,nonatomic) UIColor *colorCustomLayer2 UI_APPEARANCE_SELECTOR;
@property (weak,nonatomic) UIColor *colorCustomLayer3 UI_APPEARANCE_SELECTOR;

- (void)startAnimating;
+ (void)startAnimating:(UIView*)inView;

- (void)stopAnimating;
+ (void)stopAnimating;

@end
