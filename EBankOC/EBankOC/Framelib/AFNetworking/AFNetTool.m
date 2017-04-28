//
//  AFNetTool.m
//  AFNetworking封装
//
//  Created by 羊羊 on 16/7/6.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import "AFNetTool.h"
#import "AFNetworking.h"

@implementation AFNetTool
- (AFSecurityPolicy *)customSecurityPolicy {
    
    // 先导入证书 证书由服务端生成，具体由服务端人员操作
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES;
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData,nil];
    
    return securityPolicy;
}
+ (void)ActionReceiveResponseHeaders:(NSHTTPURLResponse *)respose{
    
}

+ (void)get:(NSString *)url parms:(NSDictionary *)parm success:(void (^)(id))success failure:(void (^)(id))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.加上这个函数，https ssl 验证。
    //[manager setSecurityPolicy:[self customSecurityPolicy]];
    
    [manager GET:url parameters:parm progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //获取请求头
        NSHTTPURLResponse *respose = (NSHTTPURLResponse*)task.response;
        [self ActionReceiveResponseHeaders:respose];
        NSLog(@"%@",respose.allHeaderFields);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
+ (void)post:(NSString *)url parms:(NSDictionary *)parm success:(void (^)(id))success failure:(void (^)(id))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:parm progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)post:(NSString *)url parms:(NSDictionary *)parm arrayImage:(NSArray *)arrayImg success:(void (^)(id))success failure:(void (^)(id))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:url parameters:parm constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
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
//Creating an Upload Task for a Multi-Part Request, with Progress
+ (void)uploadTaskMultiPartWithRequest{
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://example.com/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"file://path/to/image.jpg"] name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpeg" error:nil];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
//                          [progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                      }
                  }];
    
    [uploadTask resume];
}
//Creating a Data Task
+ (void)uploadTaskDataWithRequest{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
    /*
     *GET http://example.com?foo=bar&baz[]=1&baz[]=2&baz[]=3
    NSString *URLString = @"http://example.com";
    NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
    NSMutableURLRequest *requ = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:URLString parameters:parameters error:nil];
     
     [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
     POST http://example.com/
     Content-Type: application/x-www-form-urlencoded
     foo=bar&baz[]=1&baz[]=2&baz[]=3
     
     
     [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
     POST http://example.com/
     Content-Type: application/json
     
     {"foo": "bar", "baz": [1,2,3]}
     */
    
}
//Shared Network Reachability
+ (void)monitorsReachabilityOfDomains{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
//Allowing Invalid SSL Certificates
+ (void)allowingInvalidSSLCertificate{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES; // not recommended for production
}
@end
