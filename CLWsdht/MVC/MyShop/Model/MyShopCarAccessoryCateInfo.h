//
//  MyShopCarAccessoryCateInfo.h
//  CLWsdht
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyShopCarAccessoryNameInfo;

@interface MyShopCarAccessoryCateInfo : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *SIG;
@property (nonatomic, copy) NSString *Sort;

@property (nonatomic, copy) NSMutableArray *T_DicPartsType;

- (instancetype)initWithDic:(NSDictionary *)dic;



@end
