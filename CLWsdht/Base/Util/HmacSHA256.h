//
//  HmacSHA256.h
//  CLWsdht
//
//  Created by koroysta1 on 16/3/19.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HmacSHA256 : UIViewController

- (NSString*) hexStringFromBytes:(char*)bytes length:(NSUInteger)length;

@end
