//
//  UserInfo.h
//  CLW
//
//  Created by majinyu on 16/1/10.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic ,copy) NSString *AddDate;
@property (nonatomic ,copy) NSString *Address;
@property (nonatomic ,copy) NSString *CityId;
@property (nonatomic ,copy) NSString *CityName;
@property (nonatomic ,copy) NSString *DistrictId;

@property (nonatomic ,copy) NSString *user_Id;
@property (nonatomic ,copy) NSString *IdNumber;
@property (nonatomic ,copy) NSString *Img;
@property (nonatomic ,copy) NSString *Mobile;
@property (nonatomic ,copy) NSString *Name;

@property (nonatomic ,copy) NSString *ProvincialId;
@property (nonatomic ,copy) NSString *ProvincialName;
@property (nonatomic ,copy) NSString *Pwd;
@property (nonatomic ,copy) NSString *Url;



- (instancetype)initWithDic:(NSDictionary *)dic;

@end
