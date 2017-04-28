//
//  EBUserDefaults.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/4.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBUserDefaults.h"

static EBUserDefaults *userDefaultsInstance = nil;
@interface EBUserDefaults ()
@property(nonatomic, strong)NSUserDefaults *defaults;
@property(nonatomic, strong)NSDictionary *constantSetting;
@property(nonatomic, strong)NSDictionary *skinColors;

@end

@implementation EBUserDefaults
+ (EBUserDefaults *)instance{
    @synchronized (self) {
        if (userDefaultsInstance == nil) {
            userDefaultsInstance = [[EBUserDefaults alloc] init];
        }
    }
    return userDefaultsInstance;
}
- (instancetype)init{
    if (self = [super init]) {
        _defaults = [NSUserDefaults standardUserDefaults];
        
    }
    return self;
}
//保存的用户名
- (NSString*) userName {
    return [self.defaults objectForKey:@"userName"];
}
- (void) setUserName:(NSString*)username {
    if (nil == username) {
        [self.defaults removeObjectForKey:@"userName"];
    } else {
        [self.defaults setObject:username forKey:@"userName"];
    }
    [self.defaults synchronize];
}
- (NSString *)password{
     return [self.defaults objectForKey:@"password"];
}
-(void)setPassword:(NSString *)password{
    [self.defaults setObject:password forKey:@"password"];
    [self.defaults synchronize];
}
- (NSString *)userId{
     return [self.defaults objectForKey:@"userId"];
}
-(void)setUserId:(NSString *)userId{
    [self.defaults setObject:userId forKey:@"userId"];
    [self.defaults synchronize];
}
- (NSString *)supportBack{
     return [self.defaults objectForKey:@"supportBack"];
}
- (void)setSupportBack:(NSString *)supportBack{ // 是否能退回/0否1是
    [self.defaults setObject:supportBack forKey:@"supportBack"];
    [self.defaults synchronize];
}
- (NSString *)operateType{
     return [self.defaults objectForKey:@"operateType"];
}
-(void)setOperateType:(NSString *)operateType{ // 操作类型/0新增1提交2审核 4多级审核
    [self.defaults setObject:operateType forKey:@"operateType"];
    [self.defaults synchronize];
}
- (NSString *)roleCode{
     return [self.defaults objectForKey:@"roleCode"];
}
- (void)setRoleCode:(NSString *)roleCode{ // 角色名称/工作流-岗位ID
    [self.defaults setObject:roleCode forKey:@"roleCode"];
    [self.defaults synchronize];
}
- (NSString *)roleName{
     return [self.defaults objectForKey:@"roleName"];
}
- (void)setRoleName:(NSString *)roleName{// 角色名称/工作流-岗位名称
    [self.defaults setObject:roleName forKey:@"roleName"];
    [self.defaults synchronize];
}
- (NSString *)roleType{
     return [self.defaults objectForKey:@""];
}
-(void)setRoleType:(NSString *)roleType{// 角色类型/工作流-岗位ID工作流-岗位类型  (0:security-role-管理员权限1:assignment-参与流程图中任务的角色)
    
}
- (NSString *)role{
    return [self.defaults objectForKey:@""];
}
-(void)setRole:(NSString *)role{
    [self.defaults setObject:role forKey:@"role"];
    [self.defaults synchronize];
}
- (NSString *)deviceID{
    return [[UIDevice currentDevice] uniqueDeviceIdentifier];
}

- (NSString *)authToken{
     return [self.defaults objectForKey:@""];
}
-(void)setAuthToken:(NSString *)authToken{
    [self.defaults setObject:authToken forKey:@"authToken"];
    [self.defaults synchronize];
}


/**
// 存取用户消息推送的会话令牌
- (NSString*) deviceToken {
    return [self.defaults objectForKey:@"deviceToken"];
}
- (void) setDeviceToken:(NSString *)deviceToken {
    [self.defaults setObject:deviceToken forKey:@"deviceToken"];
    [self.defaults synchronize];
}
*/
@end
