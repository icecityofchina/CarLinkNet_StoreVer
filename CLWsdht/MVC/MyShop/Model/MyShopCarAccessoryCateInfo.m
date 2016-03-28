//
//  MyShopCarAccessoryCateInfo.m
//  CLWsdht
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "MyShopCarAccessoryCateInfo.h"
#import "MyShopCarAccessoryNameInfo.h"
#import "MJYUtils.h"

@implementation MyShopCarAccessoryCateInfo

- (instancetype)initWithDic:(NSDictionary *)dic
{
    
    if (!self) {
        self = [[MyShopCarAccessoryCateInfo alloc] init];
    }
    
    self.Id     = [MJYUtils mjy_fuckNULL:dic[@"Id"]];
    self.Name   = [MJYUtils mjy_fuckNULL:dic[@"Name"]];
    self.SIG    = [MJYUtils mjy_fuckNULL:dic[@"SIG"]];
    self.Sort   = [MJYUtils mjy_fuckNULL:dic[@"Sort"]];
    
    
    NSMutableArray *ma = [NSMutableArray array];
    NSArray *arr = dic[@"T_DicPartsType"];
    if (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
        for (NSDictionary *mDic in arr) {
            MyShopCarAccessoryNameInfo *info = [[MyShopCarAccessoryNameInfo alloc] initWithDic:mDic];
            [ma addObject:info];
        }
        self.T_DicPartsType = ma;
    } else {
        self.T_DicPartsType = nil;
    }
    
    
    return self;
}

@end
