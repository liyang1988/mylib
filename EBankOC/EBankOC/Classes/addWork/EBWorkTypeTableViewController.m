//
//  EBWorkTypeTableViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/19.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBWorkTypeTableViewController.h"
#import "EBNewCustomerTableViewController.h"

@interface EBWorkTypeTableViewController ()
@property(nonatomic,strong)NSMutableArray *marry;
@end

@implementation EBWorkTypeTableViewController
- (NSMutableArray *)marry{
    if (nil == _marry) {
        _marry = [NSMutableArray arrayWithObjects:@"个人房屋贷款",@"证件类型", nil];
    }
    return _marry;
}
- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.tableView setValue:@"UITableViewStyleGrouped" forKey:@"style"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [Remote post:@"" parms:@{} doAction:100 delegate:self insType:@""];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.marry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    cell.textLabel.text = self.marry[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EBNewCustomerTableViewController *newCust = [[EBNewCustomerTableViewController alloc] init];
    
    [self.navigationController pushViewController:newCust animated:YES];
}
@end
