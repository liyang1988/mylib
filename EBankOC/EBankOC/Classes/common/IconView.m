//
//  IconView.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/13.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "IconView.h"

@interface IconView ()
{
    UIButton *iconBtn;
    UILabel *titLbl;
}

@end

@implementation IconView

- (instancetype)init{
    if (self = [super init]) {
        iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       
        [self addSubview:iconBtn];
        titLbl = [[UILabel alloc] init];
        titLbl.textAlignment = NSTextAlignmentCenter;
        titLbl.font = EBNormalFont;
        [self addSubview:titLbl];
        
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    _title = title;
    titLbl.text = title;
    
}
- (void)setIconImg:(NSString *)iconImg{
    _iconImg = iconImg;
    [iconBtn setBackgroundImage:[UIImage imageNamed:iconImg] forState:UIControlStateNormal];
    
}
- (void)setTag:(NSInteger)tag{
    iconBtn.tag = tag;
}
- (void)setTarget:(id)target withSel:(SEL)sel {
    [iconBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    iconBtn.frame = CGRectMake(0, 0, self.width, 70);
    titLbl.frame = CGRectMake(0, CGRectGetMaxY(iconBtn.frame), self.width, self.height-70);
}
@end
