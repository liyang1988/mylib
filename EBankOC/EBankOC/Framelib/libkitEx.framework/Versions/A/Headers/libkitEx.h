//
//  libkitEx.h
//  libkitEx
//
//  Created by cuiyuguo on 13-11-15.
//  Copyright 2013年 cuiyuguo. All rights reserved.
//



//addition
#import <libkitEx/nstimer.h>
#import <libkitEx/UIButton+ImageRect.h>
#import <libkitEx/NSObject+Block.h>
#import <libkitEx/UIControl+Block.h>
#import <libkitEx/UIPopView+Block.h>
#import <libkitEx/NSData+Crypt.h>
#import <libkitEx/NSData+zlib.h>
#import <libkitEx/NSDate+Extensions.h>
#import <libkitEx/NSObject+KSJSON.h>
#import <libkitEx/NSObjectAdditions.h>
#import <libkitEx/NSStringAdditions.h>
#import <libkitEx/UIView+Toast.h>
#import <libkitEx/UIColor+Expanded.h>
#import <libkitEx/UIImageAdditions.h>
#import <libkitEx/UITableViewAdditions.h>
#import <libkitEx/UIToolbarAdditions.h>
#import <libkitEx/UIView+AutoSizing.h>
#import <libkitEx/UIView+FromNib.h>
#import <libkitEx/UIViewAdditions.h>
#import <libkitEx/UIDevice+IdentifierAddition.h>
#import <libkitEx/UIView+Badge.h>
#import <libkitEx/UITableViewCell+CellHeight.h>
#import <libkitEx/UIView+KeyboardTapDismiss.h>
#import <libkitEx/UIView+Borders.h>
#import <libkitEx/UIWebView+RemoveShadow.h>
#import <libkitEx/NSArray+Convert.h>
#import <libkitEx/UIImageView+AGCInitials.h>
#import <libkitEx/UIBarButtonItem+Badge.h>
#import <libkitEx/UIView+GJRedDot.h>
#import <libkitEx/UITabBarItem+GJRedDot.h>

//{@等待光标
#import <libkitEx/MBProgressHUD.h>
#import <libkitEx/CYGIndicatorView.h>
#import <libkitEx/CYGImageIndicatorView.h>
#import <libkitEx/MZLoadingCircle.h>
//通过修改参数可以变幻出多样的等待光标
#import <libkitEx/CYGActivityIndicator.h>
//@}


//uiview
#import <libkitEx/FloatTextField.h>
#import <libkitEx/FloatTextView.h>

#import <libkitEx/CYGToolBar.h>
#import <libkitEx/CYGPopupWindow.h>
#import <libkitEx/CYGComboBox.h>
#import <libkitEx/CYGModelWindow.h>
#import <libkitEx/CYGModelView.h>
#import <libkitEx/CYGListView.h>
#import <libkitEx/CYGSliderSegmControl.h>
#import <libkitEx/CYGTableView.h>
#import <libkitEx/CYGTableViewCell.h>
#import <libkitEx/CYGSegmentedControl.h>
#import <libkitEx/CYGNotificationView.h>
#import <libkitEx/CYGArrayView.h>
#import <libkitEx/CYGPagingView.h>
#import <libkitEx/CYGPickerWindow.h>
#import <libkitEx/CYGDateTimePickerWindow.h>
#import <libkitEx/CYGPopTipView.h>
#import <libkitEx/CYGQRScanView.h>
#import <libkitEx/CYGCyclePagingView.h>


//手势
#import <libkitEx/UITapOutsideGestureRecognizer.h>
#import <libkitEx/UIDragGestureRecognizer.h>
#import <libkitEx/UIOneFingerZoomGestureRecognizer.h>
#import <libkitEx/UICircularGestureRecognizer.h>


#import <libkitEx/RESideMenuController.h>

//将html文字转化为AttributedString，此可以赋值给uilabel
//可极大减少开发代码工作量
#import <libkitEx/HTMLAttributedString.h>

typedef void (^NullBlock)(void);
typedef void (^IDBlock)(id object);
