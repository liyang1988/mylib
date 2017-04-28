//
//  TPRemote.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "Remote.h"


static Remote* g_remoteInstance;


@interface Remote ()
//@property(nonatomic, strong)Reachability* hostReach;
@end
@implementation Remote
//@synthesize hostReach;


- (instancetype)init {
    if (self = [super init]) {
        // 监测网络情况
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(reachabilityChanged:)
//                                                     name: kReachabilityChangedNotification
//                                                   object: nil];
//        hostReach = [Reachability reachabilityForInternetConnection];
//        [hostReach startNotifier];
    }
    return self;
}
//- (void)reachabilityChanged:(NSNotification *)note {
//    Reachability* curReach = [note object];
//    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    NetworkStatus status = [curReach currentReachabilityStatus];
//    
//    self.isNetReachability = (status != NotReachable);
//}

- (NSString*)serverIP{
    return @"http://192.168.10.20/";//测试环境
}

//接口请求地址
- (NSString*)serverUrl {
    return [self.serverIP stringByAppendingString:@"nc_mobile_service/"];
}

//资源服务器地址NCBDatePicker
- (NSString*)downloadServerUrl {
    NSString*head = [self.serverIP stringByAppendingString:@"ncPersonal/com.nc.personal.app.base.webapp.action.DownloadServlet?productUrl="];
    return head;
}
//资源服务器地址
- (NSString*)downloadServerUrl_nc {
    NSString*head = [self.serverIP stringByAppendingString:@"nc/com.nc.app.base.webapp.action.DownloadServlet?productUrl="];
    return head;
}

//码表同步管理地址
- (NSString*)sqliteServerUrl {
    return [self.serverIP stringByAppendingString:@"ncPersonal/com.nc.personal.app.base.webapp.action.BasicTableServlet"];
}

//文件上传地址
- (NSString*)uploadServerUrl {
    return [self.serverIP stringByAppendingString:@"ncPersonal/com.nc.app.business.webapp.action.PlanPhotoUploadServlet?id="];
}


- (void) startWaitCursor:(NSDictionary*)userInfo {
    id<RemoteDelegate> delegate = userInfo[@"delegate"];
    
	if ([delegate conformsToProtocol:@protocol(RemoteDelegate)] &&
		[delegate respondsToSelector:@selector(startWaitCursor:)]) {
		[delegate startWaitCursor:[userInfo[@"actionTag"] intValue]];
	}
}

- (void) stopWaitCursor:(NSDictionary*)userInfo {
    id<RemoteDelegate> delegate = userInfo[@"delegate"];

	if ([delegate conformsToProtocol:@protocol(RemoteDelegate)] &&
		[delegate respondsToSelector:@selector(stopWaitCursor:)]) {
		[delegate stopWaitCursor:[userInfo[@"actionTag"] intValue]];
	}
}

- (void)onError:(NSString*)message userInfo:(NSDictionary*)userInfo{
    id<RemoteDelegate> delegate = userInfo[@"delegate"];
    int actionTag = [userInfo[@"actionTag"] intValue];
    
	if ([delegate conformsToProtocol:@protocol(RemoteDelegate)] &&
		[delegate respondsToSelector:@selector(remoteResponsFailed:withMessage:)]) {
		[delegate remoteResponsFailed:actionTag withMessage:message];
	}
//    //将页码数据信息返回给页面
//    if ([delegate respondsToSelector:@selector(setPageInfo:)]) {
//        [(NSObject*)delegate setValue:nil forKey:@"pageInfo"];
//    }
}

//- (void)restoreRefreshState:(id<RemoteDelegate>)delegate {
//    if ([delegate respondsToSelector:@selector(setPageInfo:)]) {
//        [(NSObject*)delegate setValue:nil forKey:@"pageInfo"];
//    }
//}

+ (Remote *)instance {
    @synchronized(self) {
        if (nil == g_remoteInstance) {
            g_remoteInstance = [[Remote alloc] init];
            //设置网络超时时间
//            [afn setDefaultTimeOutSeconds:30];
        }
    }
    return g_remoteInstance;
}



@end
