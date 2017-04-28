//
//  UIView+Borders.h
//  UIKit Additions
//
//  Created by Alejandro Martínez on 19/03/12.
//  Copyright (c) 2012 Alejandro Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface UIView (Borders)

- (void)setBorderLineWidth:(CGFloat)width;
- (void)setTopBorderColor:(UIColor *)color insets:(UIEdgeInsets)insets;
- (void)setBottomBorderColor:(UIColor *)color insets:(UIEdgeInsets)insets;
- (void)setLeftBorderColor:(UIColor *)color insets:(UIEdgeInsets)insets;
- (void)setRightBorderColor:(UIColor *)color insets:(UIEdgeInsets)insets;

@end
