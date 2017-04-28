//
//  TPRemoteResponse.h
//  Pension
//
//  Created by 崔玉国 on 14-4-23.
//  Copyright (c) 2014年 CNTaiping. All rights reserved.
//


#import "Remote.h"

@interface Remote(Response)
- (void)ActionFinish:(NSDictionary *)response userInfo:(NSDictionary*)userInfo;

@end

