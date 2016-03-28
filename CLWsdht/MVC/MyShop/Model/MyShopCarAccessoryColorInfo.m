//
//  MyShopCarAccessoryColorInfo.m
//  CLWsdht
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "MyShopCarAccessoryColorInfo.h"
#import "MJYUtils.h"

@implementation MyShopCarAccessoryColorInfo

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (!self) {
        self = [[MyShopCarAccessoryColorInfo alloc] init];
    }
    
    self.Id   = [MJYUtils mjy_fuckNULL:dic[@"Id"]];
    self.Name = [MJYUtils mjy_fuckNULL:dic[@"Name"]];
    self.Sort = [MJYUtils mjy_fuckNULL:dic[@"Sort"]];
    
    return self;
    
}

@end
