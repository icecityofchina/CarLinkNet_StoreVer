//
//  WebViewController.m
//  zhjyz
//
//  Created by typc on 15/10/17.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#define k_Nav_Height 64

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webview;

@end

@implementation BaseWebViewController



#pragma mark - Life Cycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    [self initUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Private Method
/**
 *  页面数据
 */
-(void)initData
{
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height -= k_Nav_Height;
    _webview = [[UIWebView alloc] initWithFrame:rect];
    _webview.delegate = self;
    [self.view addSubview:_webview];
    
    if (_isHtmlString) {
        [_webview loadHTMLString:_urlStr baseURL:[NSURL URLWithString:BASEURL]];
    } else {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
        if (request) {
            [_webview loadRequest:request];
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Unknown];
        }
    }
    
    
}
/**
 *  页面布局
 */
-(void)initUI
{
    
}

#pragma mark - WebView Delegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:k_Status_Load];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:k_Error_WebViewError];
}


@end
