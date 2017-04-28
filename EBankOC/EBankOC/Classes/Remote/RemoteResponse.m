//
//  TPRemoteResponse.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "RemoteResponse.h"




@implementation Remote(Response)


/*===============================================================================================*/
/*                                  下载文件相关的响应处理部分                                         */
/*===============================================================================================*/
//- (void)DownloadFinish:(ASIHTTPRequest *)request {
//	@synchronized(self) {
//		@try {
//            id<RemoteDelegate> delegate = [[request userInfo] objectForKey:@"delegate"];
//            int commandTag = [[[request userInfo] objectForKey:@"actionTag"] intValue];
//			NSString* fileName = [[request userInfo] objectForKey:@"fileName"];
//			
//			//通知已成功下载消息给相关代理
//			if ([delegate respondsToSelector:@selector(remoteResponsSuccess:withResponsData:)]) {
//				[delegate remoteResponsSuccess:commandTag withResponsData:fileName];
//			}
//			
//			//停止等待光标
//            [self performSelector:@selector(stopWaitCursor:)
//                       withObject:[request userInfo]];
//            request.userInfo = nil;
//		}
//		@catch (NSException * e) {
//            [self performSelector:@selector(onError:userInfo:)
//                       withObject:[e reason]
//                       withObject:[request userInfo]];
//		}
//        @finally {
//            [self performSelector:@selector(stopWaitCursor:)
//                       withObject:request.userInfo];
//            request.userInfo = nil;
//        }
//	}
//}
//
//- (void)DownloadFailed:(ASIHTTPRequest *)request {
//	@synchronized(self) {
//		@try {
//            NSError *error = [request error];
//			//通知错误消息
//            [self performSelector:@selector(onError:userInfo:)
//                       withObject:[error localizedDescription]
//                       withObject:[request userInfo]];
//		}
//		@catch (NSException * e) {
//			[self performSelector:@selector(onError:userInfo:)
//                       withObject:[e reason]
//                       withObject:[request userInfo]];
//		}
//        @finally {
//            [self performSelector:@selector(stopWaitCursor:)
//                       withObject:request.userInfo];
//            request.userInfo = nil;
//        }
//	}
//}
//
///*===============================================================================================*/
///*                                  上传文件相关的响应处理部分                                         */
///*===============================================================================================*/
//- (void)UploadActionFinish:(ASIHTTPRequest *)request {
//    @synchronized(self) {
//        id<RemoteDelegate> delegate = [[request userInfo] objectForKey:@"delegate"];
//        int actionTag = [[[request userInfo] objectForKey:@"actionTag"] intValue];
//        @try {
//            NSString *responseString = request.responseHeaders[@"ResultObj"];
//            //解析返回的json报文
//            NSError* error = nil;
//            NSDictionary *resDic = [NSObject JSONDecoder:responseString error:&error];
//            
//            NCBLOG(@"----response data=%@----", responseString);
//            if ([delegate respondsToSelector:@selector(remoteResponsSuccess:withResponsData:)]) {
//                [delegate remoteResponsSuccess:actionTag
//                               withResponsData:resDic];
//            }
//        }
//        @catch (NSException * e) {
//            [self performSelector:@selector(onError:userInfo:)
//                       withObject:[e reason]
//                       withObject:[request userInfo]];
//        }
//        @finally {
//            [self performSelector:@selector(stopWaitCursor:)
//                       withObject:request.userInfo];
//            request.userInfo = nil;
//        }
//    }
//}
/*===============================================================================================*/
/*                                     doAction响应处理部分                                         */
/*===============================================================================================*/
static const int STATUS_SUCCESS = 90001;
- (BOOL)ActionReceiveResponseHeaders:(NSDictionary *)header withUserInfo:(NSDictionary*)userInfo {
	@synchronized(self) {
		@try {
//            if ([head objectForKey:@"INTSERV_TOKEN"]) {
//                [UserDefaults instance].intservToken = [head objectForKey:@"INTSERV_TOKEN"];
//            }
            id<RemoteDelegate> delegate = [userInfo objectForKey:@"delegate"];
            int actionTag = [[userInfo objectForKey:@"actionTag"] intValue];
            //没有错误代码，放过
            if (nil == [header valueForKey:@"errorcode"]) {
                return false;
            }
            //服务器返回非成功状态，cancel请求链接
            NSArray* eCodes = [[header valueForKey:@"errorcode"] componentsSeparatedByString:@","];
            int responseStatus = [[eCodes lastObject] intValue];
            //检查新版本发布
            if (20001 == responseStatus) {
                if ([delegate isKindOfClass:[UIViewController class]]) {
                    NSMutableDictionary* newVersion = [NSMutableDictionary dictionary];
                    [newVersion setObject:[header valueForKey:@"versioncode"] forKey:@"versioncode"];
                    [newVersion setObject:[header valueForKey:@"versionaddr"] forKey:@"versionaddr"];
                    [newVersion setObject:[header valueForKey:@"versionstatus"] forKey:@"versionstatus"];
//                    NotificationPost(NotificationMsg_HAS_NEW_VERSION, nil, newVersion);
                }
                return true;
            } else if (responseStatus != STATUS_SUCCESS) {
                //返回错误信息
//                NSString *errorMsg = [NCBErrorManager parseErrorMsg:responseStatus];
//                [delegate  onResponsFailed:-101 withMsg:errorMsg];
                [self performSelector:@selector(onError:userInfo:)
                           withObject:@"responseStatus"
                           withObject:userInfo];
                [self performSelector:@selector(stopWaitCursor:)
                           withObject:userInfo];
                return true;
            }else{
                return false;
            }
		}
		@catch (NSException * e) {
			[self performSelector:@selector(onError:userInfo:)
                       withObject:[e reason]
                       withObject:userInfo];
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:userInfo];
            return NO;
		}
	}
}

- (void)ActionFailed:(NSDictionary *)response  userInfo:(NSDictionary*)userInfo{
    @synchronized(self) {
        @try {
            //通知错误消息
            [self performSelector:@selector(onError:userInfo:)
                       withObject:[userInfo objectForKey:@"delegate"]
                       withObject:userInfo];
        }
        @catch (NSException *e) {
            [self performSelector:@selector(onError:userInfo:)
                       withObject:[e reason]
                       withObject:userInfo];
        }
        @finally {
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:userInfo];
        }
    }
}


- (void)ActionFinish:(NSDictionary *)response userInfo:(NSDictionary*)userInfo{
//    @synchronized(self) {
        id<RemoteDelegate> delegate = [userInfo objectForKey:@"delegate"];
        int actionTag = [[userInfo objectForKey:@"actionTag"] intValue];
        NSDictionary *head = [userInfo objectForKey:@"head"];
        id  jsonData = [userInfo objectForKey:@"responseObject"];
        BOOL isSuccess = [self ActionReceiveResponseHeaders:head withUserInfo:userInfo];
        if (isSuccess) {
            return;
        }
        @try {
            //解密：先还原数据串
            
            //解析返回的json报文
            NSError* error = nil;
//            NSDictionary *resDic = [NSObject JSONDecoder:tempBase64 error:&error];
            if (error) {
                [self performSelector:@selector(onError:userInfo:)
                           withObject:[error localizedDescription]
                           withObject:userInfo];
                return;
            }
            if ([delegate respondsToSelector:@selector(remoteResponsSuccess:withResponsData:)]) {
                [delegate remoteResponsSuccess:actionTag
                               withResponsData:jsonData];
            }
        }
        @catch (NSException * e) {
            [self performSelector:@selector(onError:userInfo:)
                       withObject:[e reason]
                       withObject:userInfo];
        }
        @finally {
            [self performSelector:@selector(stopWaitCursor:)
                       withObject:userInfo];
        }
//    }
}

@end
