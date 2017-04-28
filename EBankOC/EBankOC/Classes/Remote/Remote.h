//
//  TPRemote.h
//  Pension
//
//  Created by on .
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
// 


@protocol RemoteDelegate<NSObject>
@required
- (void) startWaitCursor:(int)actionTag;
- (void) stopWaitCursor:(int)actionTag;
@optional
//actionTag:客户端在发送请求时可以随便定义一个数值，以便于接收消息的delegate能够区分返回的数据是哪个命令的反馈数据
- (void) remoteResponsSuccess:(int)actionTag withResponsData:(id)responsData;
- (void) remoteResponsFailed:(int)actionTag withMessage:(NSString*)message;
@end



/**
 *	@brief	远程调用接口类
 */
@interface Remote : NSObject
//网络是否可用
@property(nonatomic, assign)BOOL isNetReachability;
//接口请求地址
@property(nonatomic,readonly)NSString*  serverIP;
//接口请求地址
@property(nonatomic,readonly)NSString*  serverUrl;
//资源服务器地址(个金)
@property(nonatomic,readonly)NSString*  downloadServerUrl;

//文件上传地址
@property(nonatomic,readonly)NSString*  uploadServerUrl;

@property(nonatomic,readonly)NSString*  sqliteServerUrl;

+ (Remote *)instance;


//+ (void)clearMethodCacheData:(NSString*)methodName;
+ (BOOL)hasCacheData:(NSString*)methodName md5ParamKey:(NSString*)md5ParamKey cacheMinutes:(NSInteger)minutes;
+ (NSData*)getCacheData:(NSString*)methodName md5ParamKey:(NSString*)md5ParamKey;
@end

