//
//  EBViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/12.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBViewController.h"

@interface EBViewController ()

@end

@implementation EBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255 green:242/255.0 blue:242/255.0 alpha:1.0];
}
- (UIViewController*) rootViewController {
    return ((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
}
- (void) setRootViewController:(UIViewController *)rootViewController {
    ((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController = rootViewController;
}

@end
