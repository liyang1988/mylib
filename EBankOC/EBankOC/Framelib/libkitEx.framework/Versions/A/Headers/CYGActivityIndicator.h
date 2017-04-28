

#import <UIKit/UIKit.h>

@interface CYGActivityIndicator : UIView
@property (nonatomic,readonly)BOOL isAnimating;

@property (nonatomic) UIColor *barColor;
@property (nonatomic) CGFloat barWidth;
@property (nonatomic) CGFloat barHeight;
@property (nonatomic) CGFloat aperture;

- (void)startAnimating;
+ (void)startAnimating:(UIView*)inView;

- (void)stopAnimating;
+ (void)stopAnimating;

@end


/**
 *	@brief	CYGActivityIndicator的属性值调整，以根据需要调整出适合自己的属性值
 */
@interface CYGActivityIndicatorPropertyRegulateController : UIViewController
@end
