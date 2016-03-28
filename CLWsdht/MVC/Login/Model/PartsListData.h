//
//  PartsListData.h
//  CLWsdht
//
//  Created by OYJ on 16/2/29.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PartsData.h"

@interface PartsListData : NSObject
@property (copy, nonatomic) NSString *Success;
@property (copy, nonatomic) NSString *Message;
@property (assign, nonatomic) PartsData *Data;

@end
