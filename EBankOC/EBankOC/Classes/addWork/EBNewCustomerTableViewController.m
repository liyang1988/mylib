//
//  EBNewCustomerTableViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/19.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBNewCustomerTableViewController.h"
#import "EBTitleTableViewCell.h"
#import "EBSelectTypeViewController.h"
#import "EBAddOptionsViewController.h"
@interface EBNewCustomerTableViewController ()
{
    NSString *certificateStr;
    NSString *loanStr;
}
@property(nonatomic,strong)NSArray *arryType;
@end

@implementation EBNewCustomerTableViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightItem:)];
    
    certificateStr = @"请选择证件类型";
    loanStr = @"请选择贷款类型";
//    [Remote post:@"" parms:@{} doAction:100 delegate:self insType:@""];
    self.arryType = @[@"身份证",@"驾驶证",@"护照"];
}
- (void)rightItem:(UIBarButtonItem*)sender{
    EBAddOptionsViewController *addOp = [[EBAddOptionsViewController alloc] init];
    [self.navigationController pushViewController:addOp animated:YES];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.row == 2 || indexPath.row == 4 ) {
        static NSString *ident = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (nil == cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"证件类型";
            cell.detailTextLabel.text = certificateStr;
        }else{
            cell.textLabel.text = @"贷款类型";
            cell.detailTextLabel.text = loanStr;
        }
        cell.textLabel.font = EBNormalFont;
        cell.detailTextLabel.font = EBSmallFont;
        return cell;
    }else{
        EBTitleTableViewCell *cell = [EBTitleTableViewCell cellWithTableView:tableView];
        if (indexPath.row == 0) {
            cell.title = @"姓名";
            cell.placeHodle = @"请输入姓名";
        }else if (indexPath.row == 1){
            cell.title = @"证件号码";
            cell.placeHodle = @"请输入证件号码";
        }else{
            cell.title = @"贷款金额";
            cell.placeHodle = @"请输入贷款金额";
        }
        cell.tag = indexPath.row;
        [cell setTextFieldFont:EBSmallFont];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EBSelectTypeViewController *typeSel = [[EBSelectTypeViewController alloc] init];
    typeSel.arryType = self.arryType;
    __weak typeof(self) vc = self;
    [typeSel getValue:^(NSString *value) {
        certificateStr = value;
        [vc.tableView reloadData];
    }];
    [self.navigationController pushViewController:typeSel animated:YES];
}


@end
