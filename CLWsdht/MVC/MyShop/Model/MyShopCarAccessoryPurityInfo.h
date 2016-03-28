//
//  MyShopCarAccessoryPurityInfo.h
//  CLWsdht
//
//  Created by majinyu on 16/1/17.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyShopCarAccessoryPurityInfo : NSObject

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Sort;

- (instancetype) initWithDic:(NSDictionary *)dic;

@end
