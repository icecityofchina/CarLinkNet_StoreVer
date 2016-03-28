//
//  AddressJSONModel.m
//  CLW
//
//  Created by majinyu on 16/1/10.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import "AddressJSONModel.h"
#import "MJYUtils.h"

@implementation AddressJSONModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (!self) {
        self = [[AddressJSONModel alloc] init];
    }
    
    self.city_id   = [MJYUtils mjy_fuckNULL:dic[@"id"]];
    self.city_name = [MJYUtils mjy_fuckNULL:dic[@"name"]];
    self.city_code = [MJYUtils mjy_fuckNULL:dic[@"citycode"]];
    self.city_pyf  = [MJYUtils mjy_fuckNULL:dic[@"pyf"]];
    self.city_pys  = [MJYUtils mjy_fuckNULL:dic[@"pys"]];
    
    return self;
}

@end
