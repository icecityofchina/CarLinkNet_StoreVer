//
//  MyShopCarBrandInfo.m
//  CLWsdht
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "MyShopCarBrandCateInfo.h"
#import "MyShopCarBrandNameInfo.h"
#import "MJYUtils.h"

@implementation MyShopCarBrandCateInfo

- (instancetype)initWithDic:(NSDictionary *)dic
{
    
    if (!self) {
        self = [[MyShopCarBrandCateInfo alloc] init];
    }
    
    self.Id     = [MJYUtils mjy_fuckNULL:dic[@"Id"]];
    self.Letter = [MJYUtils mjy_fuckNULL:dic[@"Letter"]];
    self.Name   = [MJYUtils mjy_fuckNULL:dic[@"Name"]];
    self.SIG    = [MJYUtils mjy_fuckNULL:dic[@"SIG"]];
    self.Sort   = [MJYUtils mjy_fuckNULL:dic[@"Sort"]];
    
    
    NSMutableArray *ma = [NSMutableArray array];
    NSArray *arr = dic[@"T_DicCarModel"];
    if (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
        for (NSDictionary *mDic in arr) {
            MyShopCarBrandNameInfo *info = [[MyShopCarBrandNameInfo alloc] initWithDic:mDic];
            [ma addObject:info];
        }
        self.T_DicCarModel = ma;
    } else {
        self.T_DicCarModel = nil;
    }
    
    
    return self;
}

@end
