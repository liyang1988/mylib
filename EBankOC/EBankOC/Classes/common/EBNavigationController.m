//
//  EBNavigationController.m
//  EBankOC
//
//  Created by 羊羊 on 16/12/1.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import "EBNavigationController.h"

@interface EBNavigationController ()

@end

@implementation EBNavigationController
+ (void)initialize{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题.
    [self setupBarButtonItemTheme];
    
}
+ (void)setupNavigationBarTheme{
    UINavigationBar *navigatBar = [UINavigationBar appearance];
    navigatBar.backgroundColor = [UIColor blueColor];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
//    textAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetZero];
    textAttrs[NSFontAttributeName] = EBNormalFont;
    [navigatBar setTitleTextAttributes:textAttrs];
    
}
+ (void)setupBarButtonItemTheme{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
//    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
}

@end
