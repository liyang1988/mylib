//
//  EBUserDefaults.h
//  EBankOC
//
//  Created by 羊羊 on 17/1/4.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBUserDefaults : NSObject

@property(strong, nonatomic, readonly)NSString*     appVersion;

@property(nonatomic, strong)NSString* userId;
@property(nonatomic, strong)NSString* supportBack; // 是否能退回/0否1是
@property(nonatomic, strong)NSString* operateType;    // 操作类型/0新增1提交2审核 4多级审核
@property(nonatomic, strong)NSString* roleCode;      // 角色名称/工作流-岗位ID
@property(nonatomic, strong)NSString* roleName;    // 角色名称/工作流-岗位名称
@property(nonatomic, strong)NSString* roleType;      // 角色类型/工作流-岗位ID工作流-岗位类型(0:security-role-管理员权限1:assignment-参与流程图中任务的角色)
@property(nonatomic, strong)NSString* role;

@property(nonatomic, strong)NSString* deviceID;
//用户名称，登录动作时保存
@property(nonatomic, strong)NSString*  userName;
//用户密码，登录动作时保存
@property(nonatomic, strong)NSString*  password;
//AUTH_TOKEN
@property(nonatomic, strong)NSString*  authToken;

////应用间跳转，临时会话令牌
//@property(nonatomic, strong)NSString* deviceToken;
// 静态全局的改对象实例
+ (EBUserDefaults *)instance;
@end
