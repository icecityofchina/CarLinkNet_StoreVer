//
//  ZHQUtil.m
//  本地的登录和注册
//
//  Created by wyzc on 15/10/29.
//  Copyright © 2015年 wyzc. All rights reserved.
//

#import "ZHQUtil.h"

@implementation ZHQUtil

+(void)alertWithMessage:(NSString *)msg andWithVC:(UIViewController *)vc
{
    UIAlertController * ac=[UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:action];
    [vc presentViewController:ac animated:YES completion:nil];
}


+(void)alertWithTwoMessage:(NSString *)msg andWithVC:(UIViewController *)vc
{
    UIAlertController * ac=[UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     UIAlertAction * aaction=[UIAlertAction actionWithTitle:@"马上设置" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:aaction];
    [ac addAction:action];
    [vc presentViewController:ac animated:YES completion:nil];
}

+(NSString *)trim:(NSString *)str
{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(NSString *)chinaToPhoneticize:(NSString *)str
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
    }
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
    }
    return ms;
}

@end
