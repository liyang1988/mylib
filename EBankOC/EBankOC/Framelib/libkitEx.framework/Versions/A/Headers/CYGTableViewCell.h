//
//  CYGTableViewCell.h
//
//
// WARNING (for iOS 8 and above):
// ==============================
// The functionality of this library will be disabled if 'tableView:editActionsForRowAtIndexPath:'
// is implemented in the cell's tableView's delegate! For further information why this is
// necessary take a look at the implementation and the comments of CYGMoreOptionTableViewCell's
// 'insertSubview:atIndex:' method.
//


@protocol CYGTableViewCellDelegate<NSObject>

@optional

// 'more' button

/*
 * Tells the delegate that the 'more' button for specified row was pressed.
 */
- (void)tableView:(UITableView *)tableView moreOptionButtonPressedInRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * When property 'configurationBlock' is nil:
 * ==========================================
 * If not implemented or returning nil the 'More' button will neither be created
 * nor displayed, the cell will act like a common UITableViewCell and the only
 * two delegate methods which will have an impact will be:
 *
 * - tableView:backgroundColorForDeleteConfirmationButtonForRowAtIndexPath:
 * - tableView:titleColorForDeleteConfirmationButtonForRowAtIndexPath:
 *
 * This behaviour is needed to ensure compatiblity of code from developers
 * that was written for usage of CYGMoreOptionTableViewCell 1.x
 *
 * When property 'configurationBlock' is set (NOT nil):
 * ====================================================
 * The 'more' button will be created then customized using the delegate methods,
 * passed to the configuration block and added to the view hierarchy afterwards.
 *
 * NOTE:
 * =====
 * The 'more' button also supports multiline titles.
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the 'more' button will have [UIColor whiteColor]
 * as titleColor.
 *
 */
- (UIColor *)tableView:(UITableView *)tableView titleColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the 'more' button will have [UIColor lightGrayColor]
 * as backgroundColor.
 *
 */
- (UIColor *)tableView:(UITableView *)tableView backgroundColorForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning a lower value than the 'more' button's 'fitting' value,
 * the 'More' button width will not be changed.
 *
 */
- (CGFloat)tableView:(UITableView *)tableView minimumWidthForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented the 'more' button will have (0, 15, 0, 15) as 'edgeInsets'.
 *
 */
- (UIEdgeInsets)tableView:(UITableView *)tableView edgeInsetsForMoreOptionButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

// 'delete' button

/*
 * If not implemented or returning nil the 'delete' button will have it's default backgroundColor.
 *
 */
- (UIColor *)tableView:(UITableView *)tableView backgroundColorForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented or returning nil the 'delete' button will have it's default titleColor.
 *
 */
- (UIColor *)tableView:(UITableView *)tableView titleColorForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * If not implemented the 'delete' button will have (0, 15, 0, 15) as 'edgeInsets'.
 *
 */
- (UIEdgeInsets)tableView:(UITableView *)tableView edgeInsetsForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


extern const CGFloat CYGMoreOptionTableViewCellButtonWidthSizeToFit;

/*
 * deleteConfirmationButton       - Button created by UIKit, already customized using
 *                                  using the 'CYGMoreOptionTableViewCellDelegate'
 *
 * moreOptionButton               - Button created by CYGMoreOptionTableViewCell, already
 *                                  customized using the 'CYGMoreOptionTableViewCellDelegate'
 *
 * *deleteConfirmationButtonWidth - Pointer to the width that 'deleteConfirmationButton' should
 *                                  get when beeing displayed.
 *                                  Overrides an eventually set frame.size.width during the
 *                                  'configurationBlock' execution.
 *                                  When set to 'CYGMoreOptionTableViewCellButtonWidthSizeToFit'
 *                                  the width will be calculated: 'contentSize + edgeInsets'
 *
 * *moreOptionButtonWidth         - Pointer to the width that 'moreOptionButton' should
 *                                  get when beeing displayed.
 *                                  Overrides an eventually set frame.size.width during the
 *                                  'configurationBlock' execution.
 *                                  When set to 'CYGMoreOptionTableViewCellButtonWidthSizeToFit'
 *                                  the width will be calculated: 'contentSize + edgeInsets'
 *
 */
typedef void (^CYGMoreOptionTableViewCellConfigurationBlock)(UIButton *deleteConfirmationButton,
                                                             UIButton *moreOptionButton,
                                                             CGFloat *deleteConfirmationButtonWidth,
                                                             CGFloat *moreOptionButtonWidth);

@interface CYGTableViewCell : UITableViewCell

@property (nonatomic, weak) id<CYGTableViewCellDelegate> delegate;
@property (nonatomic, weak, readonly) UITableView* tableView;
@property (nonatomic, copy) CYGMoreOptionTableViewCellConfigurationBlock configurationBlock;

- (void)hideDeleteConfirmation;
@end
