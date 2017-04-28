//
//  EBBaseTableViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/19.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBBaseTableViewController.h"

@interface EBBaseTableViewController ()<MBProgressHUDDelegate>
@property(nonatomic, strong)MBProgressHUD* progressView;
@end

@implementation EBBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
