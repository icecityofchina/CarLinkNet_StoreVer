//
//  BaseViewController.m
//  zhjyz
//
//  Created by typc on 15/10/17.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //设置HUD的样式
    [self setHUDStyle];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
}


#pragma mark - 私有方法

-(void)setHUDStyle
{
    [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:22/255.0 green:22/255.0 blue:22/255.0 alpha:0.7]];
    [SVProgressHUD setRingThickness:1.5];
}


#pragma mark - 公共方法
/**
 *  返回上一页
 */
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  返回跟视图
 */
-(void)backRootVCAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}





@end
