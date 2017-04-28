//
//  EBTitleTableViewCell.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/16.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBTitleTableViewCell.h"

#define TitLblWIDTH 100
#define LeftSPACE 10
@interface EBTitleTableViewCell ()<UITextFieldDelegate>
@property(nonatomic, strong)UILabel *titLbl;
@property(nonatomic, strong)UITextField *textF;
@property(nonatomic, copy)UITextFieldTextChangeBlock TexBlock;
@end

@implementation EBTitleTableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tabView{
    static NSString *indeStr = @"cell";
    EBTitleTableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:indeStr];
    if (nil == cell) {
        cell = [[EBTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indeStr];
        
    }
    return cell;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titLbl = [[UILabel alloc] init];
        self.titLbl.textAlignment = NSTextAlignmentLeft;
        self.titLbl.font = EBNormalFont;
        self.titLbl.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.titLbl];
        self.textF = [[UITextField alloc] init];
   
        [self.textF  addTarget:self action:@selector(textFieldTextDidChanges1) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:self.textF];
    }
    return self;
}

- (void)setPlaceHodle:(NSString *)placeHodle{
    self.textF.placeholder = placeHodle;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titLbl.text = title;
}
- (void)setTitleLableFont:(UIFont *)font{
    self.titLbl.font = font;
}
- (void)setTextFieldFont:(UIFont *)font{
    self.textF.font = font;
}
- (void)setTextFieldTextAliment:(NSTextAlignment)textAliment{
    self.textF.textAlignment = textAliment;
}
- (void)settitleLableTextAliment:(NSTextAlignment)textAliment{
    self.titLbl.textAlignment = textAliment;
}
- (void)setTag:(NSInteger)tag{
    self.textF.tag = tag;
}
- (void)layoutSubviews{
    
    self.titLbl.frame = CGRectMake(15, 5, TitLblWIDTH, self.height-10);
    self.textF.frame = CGRectMake(CGRectGetMaxX(self.titLbl.frame) + 10 , 5, 150, self.height-10);
}
- (void)textFieldTextDidChanges1{
    
//    NSLog(@"%@",textField.text);
    if (self.TexBlock) {
        self.TexBlock(self.textF.text,self.textF.tag);
    }
}
- (void)getTextValue:(UITextFieldTextChangeBlock)block{
    self.TexBlock = block;
}

@end
