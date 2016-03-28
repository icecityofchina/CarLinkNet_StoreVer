//
//  BaseTabBarController.m
//  ZHJYZ
//
//  Created by majinyu on 15/10/23.
//  Copyright © 2015年 tianyuanshihua. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()<
UITabBarControllerDelegate
>

@end

@implementation BaseTabBarController

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
    
    self.delegate = self;
    self.tabBar.tintColor = [UIColor orangeColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    [self setRootVCs];
    [self setTabBarItemStyle];
}
//页面
-(void)initUI
{
    
}

/**
 *  设置基本rootVC
 */
-(void)setRootVCs
{
    UIStoryboard *homeSB = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UINavigationController *homeNav = [homeSB instantiateViewControllerWithIdentifier:@"HomeNav"];
    
    UIStoryboard *shopSB = [UIStoryboard storyboardWithName:@"Shop" bundle:nil];
    UINavigationController *shopCarNav = [shopSB instantiateViewControllerWithIdentifier:@"ShopNav"];
    
    UIStoryboard *myShopSB = [UIStoryboard storyboardWithName:@"MyShop" bundle:nil];
    UINavigationController *orderNav = [myShopSB instantiateViewControllerWithIdentifier:@"MyShopNav"];
    
    UIStoryboard *userSB = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    UINavigationController *userNav = [userSB instantiateViewControllerWithIdentifier:@"UserNav"];
    
    self.viewControllers = @[
                             homeNav,
                             shopCarNav,
                             orderNav,
                             userNav
                             ];
    
}

/**
 *  设置item的样式
 */
-(void)setTabBarItemStyle
{
    UITabBarItem *item1 = self.tabBar.items[0];
    item1.tag = 0;
    item1.title = @"首页";
    item1.image = [UIImage imageNamed:@"tab_home"];
    
    UITabBarItem *item2 = self.tabBar.items[1];
    item2.tag = 1;
    item2.title = @"商城";
    item2.image = [UIImage imageNamed:@"tab_shop"];
    
    UITabBarItem *item3 = self.tabBar.items[2];
    item3.tag = 2;
    item3.title = @"购物车";
    item3.image = [UIImage imageNamed:@"tab_shop_car"];
    
    UITabBarItem *item4 = self.tabBar.items[3];
    item4.tag = 3;
    item4.title = @"我的信息";
    item4.image = [UIImage imageNamed:@"tab_my"];
    
}


#pragma mark - Delegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.selectedIndex == 0){
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)viewController;
            [nav popViewControllerAnimated:NO];
        }
        
    }
}




@end
