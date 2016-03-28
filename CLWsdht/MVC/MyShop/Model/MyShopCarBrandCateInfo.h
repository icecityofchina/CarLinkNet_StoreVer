//
//  MyShopCarBrandInfo.h
//  CLWsdht
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyShopCarBrandNameInfo;

@interface MyShopCarBrandCateInfo : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *Letter;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *SIG;
@property (nonatomic, copy) NSString *Sort;

@property (nonatomic, copy) NSMutableArray *T_DicCarModel;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
