//
//  AFNetTool.h
//  AFNetworking封装
//
//  Created by 羊羊 on 16/7/6.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNetTool : NSObject
+ (void)get:(NSString*)url parms:(NSDictionary*)parm success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;
+ (void)post:(NSString*)url parms:(NSDictionary*)parm success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;
+ (void)post:(NSString*)url parms:(NSDictionary*)parm arrayImage:(NSArray*)arrayImg success:(void (^)(id responseObject))success failure:(void (^)(id error))failure;

+ (void)downloadTaskWithRequest;
+ (void)uploadTaskWithRequest;
@end
