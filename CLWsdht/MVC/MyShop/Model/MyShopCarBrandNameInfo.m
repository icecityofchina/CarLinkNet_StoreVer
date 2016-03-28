//
//  MyShopCarBrandNameInfo.m
//  CLWsdht
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "MyShopCarBrandNameInfo.h"
#import "MJYUtils.h"

@implementation MyShopCarBrandNameInfo

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (!self) {
        self = [[MyShopCarBrandNameInfo alloc] init];
    }
    
    self.Id   = [MJYUtils mjy_fuckNULL:dic[@"Id"]];
    self.Name = [MJYUtils mjy_fuckNULL:dic[@"Name"]];
    self.SIG  = [MJYUtils mjy_fuckNULL:dic[@"SIG"]];
    self.Sort = [MJYUtils mjy_fuckNULL:dic[@"Sort"]];
    
    return self;
    
}

@end
