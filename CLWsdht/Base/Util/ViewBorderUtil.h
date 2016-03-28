//
//  ViewBorderUtil.h
//  ZHJYZ
//
//  Created by 孙慧 on 15/11/27.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIView;

@class UIColor;

@interface ViewBorderUtil : NSObject



+(void) addBorder:(UIView *)view;
+(void) addBorderNoLeftWithColor:(UIView *)view color:(UIColor *) color;
+(void) addBorderWithColor:(UIView *)view color:(UIColor *) color;


@end
