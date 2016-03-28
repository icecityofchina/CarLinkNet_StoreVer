//
//  UserStoreModel.h
//  CLWsdht
//
//  Created by koroysta1 on 16/3/19.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStoreModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *storeName;//店铺名称
@property (nonatomic, copy) NSString *partsSrcName;//来源
@property (nonatomic, copy) NSString *purityName;//几成新
//- (NSArray *)asignModelWithDict: (NSDictionary *) dataDict;
@end
