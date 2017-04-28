//
//  UITapOutsideGestureRecognizer.h
//  AMPTouchOutside
//
//  Created by Alejandro Martinez on 05/07/12.
//  Copyright (c) 2012 Alejandro Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@brief	点击视图外部区域的手势
 */
@interface UITapOutsideGestureRecognizer : UIGestureRecognizer
/**
 *	@brief	初始化手势
 *
 *	@param 	target 	响应目标
 *	@param 	action 	响应函数
 *	@param 	view 	参考视图
 *
 *	说明：本手势应加载view所在的上级视图上，这样当点击上级视图除了view之外的区域才有效
 */
- (instancetype)initWithTarget:(id)target action:(SEL)action view:(UIView *)view;

@end

