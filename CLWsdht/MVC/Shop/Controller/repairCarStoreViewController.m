//
//  repairCarStoreViewController.m
//  CLWsdht
//
//  Created by tom on 16/1/29.
//  Copyright © 2016年 时代宏图. All rights reserved.
//
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#import "repairCarStoreViewController.h"

@interface repairCarStoreViewController ()

@end

@implementation repairCarStoreViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//白色
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//退出当前ViewController后变回黑色
}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor=[UIColor whiteColor];
    //控制器位置
    
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    backView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:backView];
    //返回按钮
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50 ,20,44,44)];
    back.backgroundColor=[UIColor clearColor];
    
    [back setTitle:@"取消" forState:UIControlStateNormal];
    
    back.titleLabel.font=[UIFont systemFontOfSize:20];
    [back setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
    
    [back addTarget:self action:@selector(backClickde) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:back];
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-50, 44)];
    
//    UIView *segment=[searchBar.subviews objectAtIndex:0];
//    [segment removeFromSuperview];
//    searchBar.backgroundColor=[UIColor blackColor];
//    searchBar.barStyle=UIBarStyleBlackTranslucent;
//    searchBar.keyboardType=UIKeyboardAppearanceDefault;
//    searchBar.placeholder=@"写点啥吧";
    [backView addSubview:searchBar];
    
 
}
#pragma mark--返回按钮
- (void)backClickde{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

@end
