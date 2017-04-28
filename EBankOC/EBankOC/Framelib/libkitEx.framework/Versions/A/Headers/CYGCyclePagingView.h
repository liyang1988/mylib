//
//  CYGCyclePagingView.h
//
//  Created by cuiyuguo on 14-9-17.
//  Copyright 2014 __MyCompanyName__. All rights reserved.
//


/**
 *	@brief	无限循环的控件
 *
 */
@protocol CYGCyclePagingViewDelegate;
@interface CYGCyclePagingView : UIView

@property (nonatomic, readonly) UIScrollView    *scrollView;
@property (nonatomic, readonly) UIPageControl   *pageControl;
@property (nonatomic, readonly)   NSInteger   currentPageIndex;
@property (nonatomic, weak)     id<CYGCyclePagingViewDelegate> delegate;
@property (nonatomic, assign)   BOOL  recyclingEnabled;

- (void)reloadData;
- (UIView *)dequeueReusablePage;  // nil if none

//向前
- (void)previousPage;
//向后
- (void)nextPage;
@end

@protocol CYGCyclePagingViewDelegate <NSObject>
@required
- (NSInteger)numberOfPagesInCyclePagingView:(CYGCyclePagingView *)pagingView;
- (UIView *)viewForPageInCyclePagingView:(CYGCyclePagingView *)pagingView atIndex:(NSInteger)index;

@optional
- (void)currentPageDidChangeInCyclePagingView:(CYGCyclePagingView *)pagingView;
- (void)didClickedInCyclePagingView:(CYGCyclePagingView *)pagingView;
@end