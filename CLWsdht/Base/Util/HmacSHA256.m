//
//  HmacSHA256.m
//  CLWsdht
//
//  Created by koroysta1 on 16/3/19.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "HmacSHA256.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>


@interface HmacSHA256 ()

@end

@implementation HmacSHA256

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"test hmac = %@", hmacForKeyAndData(@"18686863604", @"18686863604aaa2016021814"));
}

NSString* hmacForKeyAndData(NSString *key, NSString *data)

{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSMutableString *hexStr=[[NSMutableString alloc] initWithCapacity:2*sizeof(cHMAC)];
    
    for(int i=0;i<sizeof(cHMAC);i++) {
        [hexStr appendFormat:@"%02x", cHMAC[i]&0xff];
    }
    return [NSString stringWithString:hexStr];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
