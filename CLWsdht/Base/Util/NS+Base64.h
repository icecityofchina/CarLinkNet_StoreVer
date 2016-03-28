//
//  Common.h
//  iMessageSenderConsole
//
//  Created by AnYanbo on 14-3-25.
//  Copyright (c) 2014年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonCrypto.h>

@interface NSData (NSDataAddtion)

// Base64 return NSString
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

// Base64 return NSData
+ (NSData*)_encodeBase64Data:(NSData *)data;
+ (NSData*)_decodeBase64Data:(NSData *)data;

@end

@interface NSString (NSStringAddtion)

// Base64 return NSString
+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;

// Base64 return NSData
+ (NSData*)_encodeBase64Data:(NSString *)input;
+ (NSData*)_decodeBase64Data:(NSString *)input;

@end