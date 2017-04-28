//
//  TPRemoteRequest.m
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//

#import "RemoteRequest.h"


@implementation Remote(Request)


- (NSData *)AES256Encrypt:(NSData*)data key:(NSString *)key {
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [data length];
	
	//See the doc: For block ciphers, the output size will always be less than or
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
	}
    
	free(buffer); //free the buffer;
	return nil;
}

#define PLANT_ID    @"151"   //UAT地址



- (void) setInterfaceHeader:(AFHTTPSessionManager*)manager insType:(NSString*)type{
    
  
    NSString *nameAES = @"";
    
    AFHTTPRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializer];
    requestSerializer.timeoutInterval = 90.0f;
    [requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestSerializer setValue:@"" forHTTPHeaderField:@"deviceCode"]; //设备id
    [requestSerializer setValue:@"0" forHTTPHeaderField:@"deviceType"];//1 andriod, 0 ios
    [requestSerializer setValue:@"" forHTTPHeaderField:@"authToken"];
    [requestSerializer setValue:type forHTTPHeaderField:@"insType"]; //接口
    [requestSerializer setValue:nameAES forHTTPHeaderField:@"gdu"];  //用户名
    manager.requestSerializer = requestSerializer;
    
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"clientkey" ofType:@"cer"];
//    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
//    //设置使用证书验证模式
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    //设置允许使用无效证书（自己创建的证书、非证书机构颁发的证书）
//    securityPolicy.allowInvalidCertificates = YES;
//    //设置是否需要域名验证
//    securityPolicy.validatesDomainName = NO;
//    securityPolicy.pinnedCertificates = [NSSet setWithObject:cerData];
//
//    [manager setSecurityPolicy:securityPolicy];
    
 
    
//            NSString *userName = [ALSecurityTools crypt:[UserDefaults instance].userInfo.userName];
//            [request addRequestHeader:@"_lun" value:userName];
////            [request addRequestHeader:@"_login_user_name" value:[UserDefaults instance].userInfo.userName];
//            [request addRequestHeader:@"deviceCode" value:[UserDefaults instance].deviceIdentifier];
//            [request addRequestHeader:@"versionId" value:[UserDefaults instance].appVersion];
//

}

- (void)get:(NSString *)requestUrl parms:(NSDictionary *)parm  doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate {
    
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    if (nil != delegate) {
        [userInfo setObject:delegate forKey:@"delegate"];
    }
    [userInfo setObject:@(actionTag) forKey:@"actionTag"];
        //开始等待光标
    [self performSelector:@selector(startWaitCursor:) withObject:userInfo];
    NSString* serverUrl;
    if (![requestUrl hasPrefix:httpPrefix]) {
        serverUrl = [self.serverUrl stringByAppendingString:requestUrl];
    }
    @try {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager GET:serverUrl parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //获取响应头
            NSHTTPURLResponse *respose = (NSHTTPURLResponse*)task.response;
//            [self ActionReceiveResponseHeaders:respose];
            NSLog(@"%@",respose.allHeaderFields);
//            success(responseObject);
            [self performSelector:@selector(ActionFinish: userInfo:) withObject:@{@"head":respose.allHeaderFields,@"responseObject":responseObject} withObject:userInfo];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *respose = (NSHTTPURLResponse*)task.response;
            [self performSelector:@selector(ActionFailed: userInfo:) withObject:@{@"head":respose.allHeaderFields,@"error":error} withObject:userInfo];
        }];
    } @catch (NSException *exception) {
        [self performSelector:@selector(stopWaitCursor:)
                   withObject:exception];
    }
}
- (void)post:(NSString *)requestUrl parms:(NSDictionary *)parm doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate insType:(NSString*)type{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    if (nil != delegate) {
        [userInfo setObject:delegate forKey:@"delegate"];
    }
    [userInfo setObject:@(actionTag) forKey:@"actionTag"];
    //开始等待光标
    [self performSelector:@selector(startWaitCursor:) withObject:userInfo];
    NSString* serverUrl;
    if (![requestUrl hasPrefix:httpPrefix]) {
        serverUrl = [self.serverUrl stringByAppendingString:requestUrl];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setInterfaceHeader:manager insType:type];
    [manager POST:serverUrl parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取响应头
        NSHTTPURLResponse *respose = (NSHTTPURLResponse*)task.response;
        NSLog(@"%@",respose.allHeaderFields);
        [self performSelector:@selector(ActionFinish: userInfo:) withObject:@{@"head":respose.allHeaderFields,@"responseObject":responseObject} withObject:userInfo];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *respose = (NSHTTPURLResponse*)task.response;
        [self performSelector:@selector(ActionFailed: userInfo:) withObject:@{@"head":(respose != nil ? respose.allHeaderFields : @""),@"error":error} withObject:userInfo];
    }];
}
- (void)post:(NSString *)url parms:(NSDictionary *)parm arrayImage:(NSArray *)arrayImg doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate insType:(NSString*)type{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    if (nil != delegate) {
        [userInfo setObject:delegate forKey:@"delegate"];
    }
    [userInfo setObject:@(actionTag) forKey:@"actionTag"];
    //开始等待光标
    [self performSelector:@selector(startWaitCursor:) withObject:userInfo];
    NSString* serverUrl;
    if (![url hasPrefix:httpPrefix]) {
        serverUrl = [self.serverUrl stringByAppendingString:url];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self setInterfaceHeader:manager insType:type];
    [manager POST:serverUrl parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *img = [arrayImg firstObject];
        NSData *data = UIImageJPEGRepresentation(img, 1.0);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:data name:@"images" fileName:fileName mimeType:@"image/jpeg"];
        
        //     NSString *path = [[NSBundle mainBundle]pathForResource:@"jingzhi.txt" ofType:nil];
        //        NSData *data = [NSData dataWithContentsOfFile:path];
        //        [formData appendPartWithFileData:data name:@"file" fileName:@"123.txt" mimeType:@"text/plain"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取响应头
        NSHTTPURLResponse *respose = (NSHTTPURLResponse*)task.response;
        NSLog(@"%@",respose.allHeaderFields);
        if ([self respondsToSelector:@selector(ActionFinish: userInfo:)]) {
             [self performSelector:@selector(ActionFinish: userInfo:) withObject:@{@"head":respose.allHeaderFields,@"responseObject":responseObject} withObject:userInfo];
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *respose = (NSHTTPURLResponse*)task.response;
        if ([self respondsToSelector:@selector(ActionFailed: userInfo:)]) {
            [self performSelector:@selector(ActionFailed: userInfo:) withObject:@{@"head":respose.allHeaderFields,@"error":error} withObject:userInfo];
        }
    }];
    
}
+ (void)get:(NSString *)requestUrl parms:(NSDictionary *)parm doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate{
     [[Remote instance] get:requestUrl parms:parm doAction:actionTag delegate:delegate];
}
+ (void)post:(NSString *)requestUrl parms:(NSDictionary *)parm doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate insType:(NSString*)type{
    [[Remote instance] post:requestUrl parms:parm doAction:actionTag delegate:delegate insType:type];
}
+ (void)post:(NSString *)url parms:(NSDictionary *)parm arrayImage:(NSArray *)arrayImg doAction:(int)actionTag delegate:(id<RemoteDelegate>)delegate insType:(NSString*)type{
    [[Remote instance] post:url parms:parm arrayImage:arrayImg doAction:actionTag delegate:delegate insType:type];
}

//Creating a Download Task
+ (void)downloadTaskWithRequest{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://127.0.0.1:8080/1.1/images/Notepad.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

//Creating an Upload Task
+ (void)uploadTaskWithRequest{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"jingzhi.txt" ofType:nil];
    //    UIImage *img = [UIImage imageWithContentsOfFile:path];
    
    
    //    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURL *URL = [NSURL URLWithString:@"http://127.0.0.1:8080/1.1/images/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURL *filePath = [NSURL fileURLWithPath:path];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}


@end
