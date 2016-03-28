//
//  UserVC.m
//  CLW
//
//  Created by majinyu on 16/1/9.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import "UserVC.h"
#import "LoginViewController.h"//登陆页面

@interface UserVC ()

@end

@implementation UserVC

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

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma mark - Data & UI
//数据
-(void)initData
{
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"退出"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(logoutAction)];
    self.navigationItem.rightBarButtonItem = logout;
}
//页面
-(void)initUI
{
    
}

#pragma mark - Target & Action

#pragma mark - Functions Custom

/**
 *  退出登录
 */
- (void)logoutAction
{
    ApplicationDelegate.isLogin = NO ;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"LoginViewController"];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - Networking

@end
