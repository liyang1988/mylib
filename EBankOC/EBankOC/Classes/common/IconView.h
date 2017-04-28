//
//  IconView.h
//  EBankOC
//
//  Created by 羊羊 on 17/1/13.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconView : UIView
@property(nonatomic,copy)NSString *iconImg;
@property(nonatomic,copy)NSString *title;
- (void)setTarget:(id)target withSel:(SEL)sel;
@end
