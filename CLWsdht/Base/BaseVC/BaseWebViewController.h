//
//  WebViewController.h
//  zhjyz
//
//  Created by typc on 15/10/17.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController

@property(copy ,nonatomic) NSString *urlStr;

@property(assign,nonatomic) BOOL isHtmlString;

@end
