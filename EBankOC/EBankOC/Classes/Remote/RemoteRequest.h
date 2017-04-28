//
//  TPRemoteRequest.h
//  Pension
//
//  Created by on .
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//
#import "Remote.h"
#import "RemoteResponse.h"

@interface Remote(Request)

//
//typedef NS_ENUM(NSInteger, RemoteInterfaceType) {
//    RemoteInterfaceTypeBase,    //基础数据调用类型
//    RemoteInterfaceTypeLogout,  //用户登出
//    
//};


+ (void)get:(NSString *)requestUrl parms:(NSDictionary *)parm  doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate;
+ (void)post:(NSString *)requestUrl parms:(NSDictionary *)parm  doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate insType:(NSString*)type;
+ (void)post:(NSString*)url parms:(NSDictionary*)parm arrayImage:(NSArray*)arrayImg  doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate insType:(NSString*)type;

+ (void)downloadFileAsync:(NSString*)requestUrl
                actionTag:(int)actionTag
                 filePath:(NSString*)filePath
                 delegate:(id<RemoteDelegate>)delegate;

+ (void)uploadFileAsyncWithPath:(NSString*)filePath
                  withActionTag:(int)actionTag
                  withParameter:(NSDictionary*)parameter
                     requestUrl:(NSString*)requestUrl
                   withDelegate:(id<RemoteDelegate>)delegate;

@end
