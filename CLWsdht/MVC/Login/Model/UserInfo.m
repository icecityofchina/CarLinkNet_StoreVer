//
//  UserInfo.m
//  CLW
//
//  Created by majinyu on 16/1/10.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import "UserInfo.h"
#import "MJYUtils.h"

@implementation UserInfo

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (!self) {
        self = [[UserInfo alloc] init];
    }
    
    self.AddDate        = [MJYUtils mjy_fuckNULL:dic[@"AddDate"]];
    self.Address        = [MJYUtils mjy_fuckNULL:dic[@"Address"]];
    self.CityId         = [MJYUtils mjy_fuckNULL:dic[@"CityId"]];
    self.CityName       = [MJYUtils mjy_fuckNULL:dic[@"CityName"]];
    self.DistrictId     = [MJYUtils mjy_fuckNULL:dic[@"DistrictId"]];

    self.user_Id        = [MJYUtils mjy_fuckNULL:dic[@"Id"]];
    self.IdNumber       = [MJYUtils mjy_fuckNULL:dic[@"IdNumber"]];
    self.Img            = [MJYUtils mjy_fuckNULL:dic[@"Img"]];
    self.Mobile         = [MJYUtils mjy_fuckNULL:dic[@"Mobile"]];
    self.Name           = [MJYUtils mjy_fuckNULL:dic[@"Name"]];

    self.ProvincialId   = [MJYUtils mjy_fuckNULL:dic[@"ProvincialId"]];
    self.ProvincialName = [MJYUtils mjy_fuckNULL:dic[@"ProvincialName"]];
    self.Pwd            = [MJYUtils mjy_fuckNULL:dic[@"Pwd"]];
    self.Url            = [MJYUtils mjy_fuckNULL:dic[@"Url"]];
    
    return self;
}

@end
