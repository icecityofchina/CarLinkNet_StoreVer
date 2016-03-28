//
//  Common.m
//  iMessageSenderConsole
//
//  Created by AnYanbo on 14-3-25.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import "NS+Base64.h"
#import "GTMBase64.h"

@implementation NSData (NSDataAddtion)

+ (NSString*)encodeBase64Data:(NSData *)data
{
//    data = [GTMBase64 encodeData:data];
    data = [self _encodeBase64Data:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data
{
//    data = [GTMBase64 decodeData:data];
    data = [self _decodeBase64Data:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSData*)_encodeBase64Data:(NSData *)data
{
    NSData* ret = [GTMBase64 encodeData:data];
    return ret;
}

+ (NSData*)_decodeBase64Data:(NSData *)data
{
    NSData* ret = [GTMBase64 decodeData:data];
    return ret;
}

@end

@implementation NSString (NSStringAddtion)

+ (NSString*)encodeBase64String:(NSString * )input
{
//    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 encodeData:data];
    NSData *data = [self _encodeBase64Data:input];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input
{
//    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//    data = [GTMBase64 decodeData:data];
    NSData *data = [self _decodeBase64Data:input];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSData*)_encodeBase64Data:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    return data;
}

+ (NSData*)_decodeBase64Data:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    return data;
}

@end
