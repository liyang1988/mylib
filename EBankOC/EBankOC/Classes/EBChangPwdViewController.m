//
//  EBChangPwdViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/11.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBChangPwdViewController.h"
#import "EBTitleTableViewCell.h"
@interface EBChangPwdViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *oldPwd;
    NSString *newPwd;
    NSString *confimPwd;
}
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation EBChangPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 90, self.view.width, self.view.height) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EBTitleTableViewCell *cell = [EBTitleTableViewCell cellWithTableView:tableView];
    if (0 == indexPath.row) {
        cell.title = @"原密码";
        cell.placeHodle = @"请输入原密码";
        
    }else if (1 == indexPath.row){
        cell.title = @"新密码";
        cell.placeHodle = @"请输入新密码";
    }else{
        cell.title = @"确认密码";
        cell.placeHodle = @"请输入确认密码";
    }
    cell.tag = indexPath.row;
    [cell getTextValue:^(NSString *newText, NSUInteger index) {
        if (0 == index) {
            NSLog(@"%@",newText);
            oldPwd = newText;
        }else if (1 == index){
            NSLog(@"%@",newText);
            newPwd = newText;
        }else{
            NSLog(@"%@",newText);
            confimPwd = newText;
        }
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.backgroundColor = [UIColor blueColor];
    [footBtn setTitle:@"确认" forState:UIControlStateNormal];
    UIView *view = [[UIView alloc] init];
 
    view.frame = CGRectMake(0, 0, tableView.width, 100);
    [view addSubview:footBtn];
//    footBtn. = tableView.width/2.0;
////    footBtn.centerY = view.centerY;
    footBtn.frame = CGRectMake(tableView.width/2.0-75, 50, 150, 45);
    footBtn.layer.cornerRadius = 20;
    footBtn.layer.masksToBounds = YES;

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
- (void)netRequest{
//    [Remote post:<#(NSString *)#> parms:<#(NSDictionary *)#> doAction:<#(int)#> delegate:<#(id<RemoteDelegate>)#> insType:<#(NSString *)#>]
}
@end
