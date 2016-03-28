//
//  ChosePlaceViewController.m
//  CLWsdht
//
//  Created by tom on 16/1/29.
//  Copyright © 2016年 时代宏图. All rights reserved.
//
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#import "ChosePlaceViewController.h"

@interface ChosePlaceViewController ()

@end

@implementation ChosePlaceViewController
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//白色
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//退出当前ViewController后变回黑色
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //返回按钮
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(20 ,20,44,44)];
    back.backgroundColor=[UIColor clearColor];
    
    [back setTitle:@"<" forState:UIControlStateNormal];
    
    back.titleLabel.font=[UIFont systemFontOfSize:30];
    [back setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
    
    [back addTarget:self action:@selector(backClickde) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:back];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, 20, 100, 44)];
    
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor grayColor];
    lable.text=@"添加地址";
    lable.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:lable];
   
  
}
#pragma mark--返回按钮
- (void)backClickde{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}


@end
