//
//  EBTitleTableViewCell.h
//  EBankOC
//
//  Created by 羊羊 on 17/1/16.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UITextFieldTextChangeBlock)(NSString *newText,NSUInteger index);

@interface EBTitleTableViewCell : UITableViewCell
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *placeHodle;
+ (instancetype)cellWithTableView:(UITableView*)tabView;
- (void)setTitleLableFont:(UIFont*)font;
- (void)setTextFieldFont:(UIFont*)font;
- (void)settitleLableTextAliment:(NSTextAlignment)textAliment;
- (void)setTextFieldTextAliment:(NSTextAlignment)textAliment;
- (void)getTextValue:(UITextFieldTextChangeBlock)block;
@end
