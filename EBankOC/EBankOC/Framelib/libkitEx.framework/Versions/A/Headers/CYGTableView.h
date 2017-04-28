//
//  CYGTableView.h
//  framework
//
//  Created by 崔玉国 on 14-6-5.
//
//

#import <UIKit/UIKit.h>


#define DECLARE_TABLEVIEWCELL_HEIGHT_CONTROL +(void)load{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
[self swizzleTableViewCellHeightMethod];\
});}

@interface UIViewController(CYGTableViewCellHeight)
+ (void)swizzleTableViewCellHeightMethod;
//- (void)swizzleTableViewCellHeightMethod;
@end



@protocol CYGTableViewIndexDelegate <NSObject>
- (NSArray *)indexTitlesForTableView:(UITableView *)tableView;
@end


@interface CYGTableView : UITableView
@property (nonatomic, strong) UIImage* flotageLabelBack;
@property (nonatomic, strong) UIColor* indexTextColor;
@property (nonatomic, assign) NSInteger indexFontSize;
@property (nonatomic, weak) id<CYGTableViewIndexDelegate> indexDelegate;
@end


/**
 *  获得字符串的中文首字母
 *
 *  @param Chinese 中文字符串
 *
 *  @return 首字母字符串
 */
UIKIT_EXTERN NSString* GetChineseSpell(NSString* Chinese);