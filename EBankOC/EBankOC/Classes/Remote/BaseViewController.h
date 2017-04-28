//
//  BaseViewController.h
//  AFNetworkDelegate封装
//
//  Created by 羊羊 on 16/12/23.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Remote.h"
#import "EBViewController.h"
@interface BaseViewController : EBViewController<RemoteDelegate>
//@property(nonatomic, readonly)NCBPageInfoBO* pageInfo; //列表页面的页码信息

@end
