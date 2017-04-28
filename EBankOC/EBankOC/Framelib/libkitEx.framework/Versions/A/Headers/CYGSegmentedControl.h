//
//  CYGSegmentedControl.h
//
//  Created by apple.
//

#import <UIKit/UIKit.h>

typedef void(^selectedBlcok) (NSInteger  segmentIndex);

@interface CYGSegmentedControl : UIView
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIColor *bgColor;
@property (nonatomic,strong) UIColor *itemBackGroundColor;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *textSelectColor;

//设置默认选项，若不选中任何一个可以设置为－1
@property (nonatomic) NSUInteger currentSelected;

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items andSelectionBlock:(selectedBlcok)block;

- (void)setBadgeValue:(NSUInteger)value atIndex:(NSUInteger)index;

@end
