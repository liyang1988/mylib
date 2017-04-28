//
//  LoginViewController.m
//  EBankOC
//
//  Created by 羊羊 on 16/12/1.
//  Copyright © 2016年 Bruce. All rights reserved.
//

#import "LoginViewController.h"
#import "EBHomeMenuViewController.h"

@interface LoginViewController ()
{
    UITextField *userN;
    UITextField *passwordF;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    UIImageView *imgBg =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    imgBg.width = SCREENW;
    imgBg.height = SCREENH;
    [self.view addSubview:imgBg];
    
    UIImageView *logoImg =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang.png"]];
    logoImg.width = 180;
    logoImg.height = 180;
    logoImg.centerX = SCREENW/2;
    logoImg.centerY = 20 + (180/2);
    [self.view addSubview:logoImg];
    
    UIView *loginView = [[UIView alloc] init];

    loginView.width = SCREENW;
    loginView.height = 150;
    loginView.centerX = SCREENW/2;
    loginView.centerY = SCREENH/2;
    [self.view addSubview:loginView];
    
    userN = [[UITextField alloc] initWithFrame:CGRectMake(20, 20,  SCREENW-40, 35)];
    UIView *viewUser = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 28)];
    [viewUser addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username.png"]]];
    userN.leftView = viewUser;
    userN.placeholder = @"请输入用户名";
    userN.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *line1 =  [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userN.frame), userN.frame.size.width, 1)];
    line1.backgroundColor = [UIColor whiteColor];
    
    passwordF = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(userN.frame)+20, SCREENW-40, 35)];
    passwordF.leftViewMode = UITextFieldViewModeAlways;
    UIView *viewPwd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 35, 28)];
    [viewPwd addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password.png"]]];
    passwordF.leftView = viewPwd;
    passwordF.placeholder = @"请输入密码";
    UIImageView *line2 =  [[UIImageView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(passwordF.frame), passwordF.frame.size.width, 1)];
    line2.backgroundColor = [UIColor whiteColor];
    [loginView addSubview:line2];
    [loginView addSubview:passwordF];
    [loginView addSubview:line1];
    [loginView addSubview:userN];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.width = SCREENW-40;
    loginBtn.height = 35;
    loginBtn.centerY = CGRectGetMaxY(loginView.frame) + 35;
    loginBtn.centerX = SCREENW/2;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor blueColor]];
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = 16.0;
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIImageView *bottomLogo =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    bottomLogo.centerX = SCREENW/2;
    bottomLogo.centerY = SCREENH-50;
    [self.view addSubview:bottomLogo];
    IQKeyboardManager *mange = [IQKeyboardManager sharedManager];
    mange.enableAutoToolbar = NO;
    
}
- (void)keyboardWillShow:(NSNotification*)not{
    NSLog(@"keyboardWillShow");
}
- (void)keyboardWillHide:(NSNotification*)not{
    NSLog(@"keyboardWillHide");
}
- (void)loginBtnClick:(UIButton*)sender{
#if TARGET_IPHONE_SIMULATOR
    self.rootViewController = [[EBNavigationController alloc] initWithRootViewController:[[EBHomeMenuViewController alloc] init]];
    return;
    
#else
    
#endif
    
    if (userN.text.length < 1) {
        ShowMessage(@"请输入用户名");
    }
    if (passwordF.text.length <1) {
        ShowMessage(@"请输入密码");
    }
    
    NSDictionary *dict = @{@"loginName":userN.text,@"loginPwd":passwordF.text,@"deviceCode":@"",@"deviceType":@"0"};
    [Remote post:URL_login parms:dict doAction:1 delegate:self insType:@"userLogin"];
}
- (void)remoteResponsSuccess:(int)actionTag withResponsData:(id)responsData{
    NSLog(@"%@",responsData);
    if ([responsData[@"password"] isEqualToString:@"888888"]) {
        
    }
}

@end
