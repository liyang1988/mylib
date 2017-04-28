//
//  EBSelectTypeViewController.m
//  EBankOC
//
//  Created by 羊羊 on 17/1/19.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBSelectTypeViewController.h"

@interface EBSelectTypeViewController ()
@property(nonatomic,strong)GetTypeBlock valueBlock;
@end

@implementation EBSelectTypeViewController
- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arryType.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ident = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ident];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.arryType[indexPath.row];
    cell.textLabel.font = EBNormalFont;
    cell.detailTextLabel.font = EBSmallFont;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.valueBlock) {
        self.valueBlock(self.arryType[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getValue:(GetTypeBlock)block{
    self.valueBlock = block;
}
@end
