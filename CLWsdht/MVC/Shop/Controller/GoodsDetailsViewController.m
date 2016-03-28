//
//  GoodsDetailsViewController.m
//  CLWsdht
//
//  Created by tom on 16/1/25.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "GoodsDetailsViewController.h"

@interface GoodsDetailsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    UIScrollView *scrollView;
    UITableView *tableView;
}

@end

@implementation GoodsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationItem setTitle:@"商品详情"];
//    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -35, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
//    [tableView setBackgroundColor:[UIColor blackColor]];
//    //设置数据源
//    [tableView setDataSource:self];
//    //设置代理
//    [tableView setDelegate:self];
//    
//    [self.view addSubview:tableView];
//    //创建scrollView对象
//    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width,  self.view.bounds.size.height)];
//    scrollView.backgroundColor=[UIColor grayColor];
//    UILabel *aaa=[[UILabel alloc]initWithFrame:CGRectMake(10, 1000, 10, 10)];
//    aaa.backgroundColor=[UIColor redColor];
//    [scrollView addSubview:aaa];
//    //设置滚动范围
//    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 2*self.view.frame.size.height)];
//    //打开分页属性
//    [scrollView setPagingEnabled:YES];
//    //设置代理
//    [scrollView setDelegate:self];
//  
//    
//    [self.view addSubview:scrollView];

}



@end
