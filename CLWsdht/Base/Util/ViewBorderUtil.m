//
//  ViewBorderUtil.m
//  ZHJYZ
//
//  Created by 孙慧 on 15/11/27.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import "ViewBorderUtil.h"
#import "UIView+Border.h"

@implementation ViewBorderUtil

+(void) addBorder:(UIView *)view
{
    [view addTopBorderWithColor:[UIColor lightGrayColor] andWidth:1.0f];
    [view addRightBorderWithColor:[UIColor lightGrayColor] andWidth:1.0f];
    [view addLeftBorderWithColor:[UIColor lightGrayColor] andWidth:1.0f];
    [view addBottomBorderWithColor:[UIColor lightGrayColor] andWidth:1.0f];
}
+(void) addBorderNoLeftWithColor:(UIView *)view color:(UIColor *) color
{
    [view addTopBorderWithColor:color andWidth:1.0f];
    [view addRightBorderWithColor:color andWidth:1.0f];
    [view addBottomBorderWithColor:color andWidth:1.0f];

}
+(void) addBorderWithColor:(UIView *)view color:(UIColor *) color
{
    [view addTopBorderWithColor:color andWidth:1.0f];
    [view addRightBorderWithColor:color andWidth:1.0f];
    [view addLeftBorderWithColor:color andWidth:1.0f];
    [view addBottomBorderWithColor:color andWidth:1.0f];
    
}
@end
