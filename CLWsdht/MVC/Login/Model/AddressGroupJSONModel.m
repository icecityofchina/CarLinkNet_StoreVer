//
//  AddressGroupJSONModel.m
//  CLW
//
//  Created by majinyu on 16/1/10.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import "AddressGroupJSONModel.h"
#import "AddressJSONModel.h"

@implementation AddressGroupJSONModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (!self) {
        self = [[AddressGroupJSONModel alloc] init];
    }
    
    self.AZ = dic[@"AZ"];
    NSArray *arrCitys = dic[@"cities"];
    NSMutableArray *ma = [NSMutableArray array];
    for (NSDictionary *dic in arrCitys) {
        AddressJSONModel *address = [[AddressJSONModel alloc] initWithDic:dic];
        address.city_AZ = self.AZ;
        [ma addObject:address];
    }
    self.cities = ma;
    
    return self;
    
}

@end
