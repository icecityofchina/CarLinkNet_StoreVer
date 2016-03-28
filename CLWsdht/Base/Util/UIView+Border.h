//
//  UIButton+Border.h
//  ZHJYZ
//
//  Created by 孙慧 on 15/11/17.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

- (void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

@end
