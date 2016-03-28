//
//  ZHQUtil.h
//  本地的登录和注册
//
//  Created by wyzc on 15/10/29.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZHQUtil : NSObject

+ (void)alertWithMessage:(NSString *)msg andWithVC:(UIViewController *)vc;
+ (NSString *)trim:(NSString *)str;
+ (void)alertWithTwoMessage:(NSString *)msg andWithVC:(UIViewController *)vc;
+ (NSString *)chinaToPhoneticize:(NSString *)str;

@end
