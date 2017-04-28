#import <Foundation/Foundation.h>



@protocol CYGPagingViewDelegate;

// a wrapper around UIScrollView in (horizontal) paging mode, with an API similar to UITableView
@interface CYGPagingView : UIImageView

@property(nonatomic, weak) IBOutlet id<CYGPagingViewDelegate> delegate;
@property(nonatomic, assign) CGFloat gapBetweenPages;  // default is 20
@property(nonatomic, assign) NSInteger pagesToPreload;  // number of invisible pages to keep loaded to each side of the visible pages, default is 1

@property(nonatomic, readonly) NSInteger pageCount;
@property(nonatomic, assign) NSInteger currentPageIndex;
@property(nonatomic, assign, readonly) NSInteger previousPageIndex; // only for reading inside currentPageDidChangeInPagingView
@property(nonatomic, assign, readonly) NSInteger firstVisiblePageIndex;
@property(nonatomic, assign, readonly) NSInteger lastVisiblePageIndex;
@property(nonatomic, assign, readonly) NSInteger firstLoadedPageIndex;
@property(nonatomic, assign, readonly) NSInteger lastLoadedPageIndex;
@property(nonatomic, assign, readonly) BOOL moving;
@property(nonatomic, assign) BOOL recyclingEnabled;
@property(nonatomic, assign) BOOL scrollEnabled;
//如果CYGPagingView内的页面是view还是viewController,默认是viewController
//也即NO,此时当切换时会调用UIViewController的生命周期内函数
@property(nonatomic, assign) BOOL pageOnlyView;

- (void)reloadData;  // must be called at least once to display something
- (UIView *)viewForPageAtIndex:(NSUInteger)index;  // nil if not loaded
- (UIView *)dequeueReusablePage;  // nil if none
- (void)willAnimateRotation;  // call this from willAnimateRotationToInterfaceOrientation:duration:
- (void)didRotate;  // call this from didRotateFromInterfaceOrientation:

@end


@protocol CYGPagingViewDelegate <NSObject, UIScrollViewDelegate>

@required

- (NSInteger)numberOfPagesInCYGPagingView:(CYGPagingView *)pagingView;

- (UIView *)viewForPageInCYGPagingView:(CYGPagingView *)pagingView atIndex:(NSInteger)index;

@optional
- (void)currentPageDidChangeInCYGPagingView:(CYGPagingView *)pagingView;

- (void)pagesDidChangeInCYGPagingView:(CYGPagingView *)pagingView;

// a good place to start and stop background processing
- (void)pagingViewWillBeginMoving:(CYGPagingView *)pagingView;
- (void)pagingViewDidEndMoving:(CYGPagingView *)pagingView;
@end

