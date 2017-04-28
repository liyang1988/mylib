//
//  BaseViewController.m
//  AFNetworkDelegate封装
//
//  Created by 羊羊 on 16/12/23.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<MBProgressHUDDelegate>
@property(nonatomic, strong)MBProgressHUD* progressView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void) startWaitCursor:(int)actionTag {
    if (nil == self.progressView) {
        self.progressView = [[MBProgressHUD alloc] initWithView:self.view];
        self.progressView.delegate = self;
        self.progressView.labelFont = [UIFont systemFontOfSize:12.0];
        self.progressView.labelText = @"加载中....";
        self.progressView.opaque = .6;
    } else {
        [self.progressView show:YES];
    }
}

- (void) stopWaitCursor:(int)actionTag {
    if (self.progressView) {
        [self.progressView hide:NO];
    }
}

//- (void) setPageInfo:(NCBPageInfoBO *)page {
//    pageInfo = page;
//}

- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message {
//    if (self.initReqActionTag == actionTag) {
//        self->onceToken = 0;
//    }
//    [NCBToastShow showToast:nil content:message completion:nil];
    NSLog(@"=============error:%@", message);
}

- (void) remoteResponsSuccess:(int)actionTag withMessage:(NSString*)message {
//    ShowMessage(message);
    
}

@end
