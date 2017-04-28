//
//  EBSelectTypeViewController.h
//  EBankOC
//
//  Created by 羊羊 on 17/1/19.
//  Copyright © 2017年 Bruce. All rights reserved.
//

#import "EBBaseTableViewController.h"

typedef void (^GetTypeBlock)(NSString *value);

@interface EBSelectTypeViewController : EBBaseTableViewController
@property(nonatomic,strong)NSArray *arryType;
- (void)getValue:(GetTypeBlock)block;
@end
