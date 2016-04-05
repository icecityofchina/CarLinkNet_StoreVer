//
//  ShopVC.m
//  CLW
//
//  Created by majinyu on 16/1/9.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import "ShopVC.h"
#import "CityListVC.h"//城市选择
#import "SearchBarViewController.h"
#import "AFNetworking.h"//主要用于网络请求方法
#import "UIKit+AFNetworking.h"//里面有异步加载图片的方法
#import "ChoseSparePartsViewController.h"
#import "GoodsDetailsViewController.h"
#import "ScrollViewTestViewController.h"
#import "MJExtension.h"
#import "PartsListData.h"
#import "PartsModal.h"
#import "UsrStoreTableViewCell.h"
#import "UserStoreModel.h"

#define  Cell_Height (self.view.frame.size.height-((25+( self.view.frame.size.width-70)/4)+(5+20+( self.view.frame.size.width-70)/4)+20+40))*2/5.0
@interface ShopVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSArray *imageArray;
    NSArray *lableArray;
    UITableView *userStoreTableView;
    NSString *userSeletedCity;//用户选择的城市(默认用户当前位置所在城市)
    NSString *userSeletedCityID;//用户选择的城市ID(默认用户当前位置所在城市
    NSArray *carSparePartsArray;//汽车配件
    
    
}

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation ShopVC

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
    userSeletedCity = ApplicationDelegate.currentCity;
    userSeletedCityID = ApplicationDelegate.currentCityID;
    [self initRightButtonItemWithCityName:userSeletedCity];
}


#pragma mark - Data & UI
/**
 *   初始化左右按钮
 */
- (void)initRightButtonItemWithCityName:(NSString *)cityName
{
    
    // Do any additional setup after loading the view.

    UIBarButtonItem * leftBarButtonItem= [[UIBarButtonItem alloc] initWithTitle:@"车自联" style:UIBarButtonItemStylePlain target:self action:nil];
    //设置
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 44)];
   // btn.backgroundColor=[UIColor redColor];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setTitle:cityName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(seleteCityAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  选择城市的方法
 */
- (void) seleteCityAction
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    CityListVC *vc = [sb instantiateViewControllerWithIdentifier:@"CityListVC"];
    vc.vcType = 2;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:^{}];
    
}

//数据
-(void)initData
{
    imageArray=[[NSArray alloc]initWithObjects:@"index_gz_iconbj.png",@"index_zmdq_iconbj.png",@"index_dp_iconbj.png",@"index_bj_iconbj.png",@"index_bsx_iconbj.png",@"index_ns_iconbj.png",@"index_gz_iconbj.png",@"index_more_iconbj.png", nil];
    lableArray=[[NSArray alloc]initWithObjects:@"发动机",@"照明电器",@"底盘",@"钣金",@"变速箱",@"内饰",@"改装",@"更多", nil];
    _modelArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self getMoreGoodsInfoFromNetwork];
}

//
#pragma mark--searchBar响应事件
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    SearchBarViewController *searchBarVC=[[SearchBarViewController alloc]init];
    [self presentViewController:searchBarVC animated:YES completion:^{} ];
   }
-(void)clickedBtn:(UIButton *)btn{
    [self setHidesBottomBarWhenPushed:YES];
    ChoseSparePartsViewController *aaaa=[[ChoseSparePartsViewController alloc]init];

    switch (btn.tag) {
        case 100:
            NSLog(@"100");
            break;
        case 101:
            NSLog(@"101");
            break;
        case 102:
            NSLog(@"102");
            break;
        case 103:
            NSLog(@"103");
            break;
        case 104:
            NSLog(@"104");
            break;
        case 105:
            NSLog(@"105");
            break;
        case 106:
            NSLog(@"106");
            break;
        case 107:
            NSLog(@"107");
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:aaaa animated:YES];

    [self setHidesBottomBarWhenPushed:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
//返回某个section中rows的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}


#pragma mark - Target & Action

#pragma mark - Functions Custom

#pragma mark - Networking
/**
 *  @author oyj, 16-02-29
 *
 *  获取商品列表
 */

-(void)getMoreGoodsInfoFromNetwork
{
    
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,@"UsrStore.asmx/GetPartsList"];
    
    NSDictionary *paramDict = @{
                                @"partsJson":@"",
                                @"sortJson":@"",
                                @"start":[NSString stringWithFormat:@"%d",0],
                                @"limit":[NSString stringWithFormat:@"%d",30]
                                };
    
    [ApplicationDelegate.httpManager POST:urlStr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          PartsListData *data=[PartsListData mj_objectWithKeyValues:jsonDic];
                                          if (data.Success) {
                                              for(PartsModal *modal in data.Data.Data)
                                              {
                                                  UserStoreModel *zm = [[UserStoreModel alloc] init];
                                                  zm.title = modal.Name;
                                                  
                                                  zm.price =  [NSString stringWithFormat:@"%f",modal.Price ];
                                                  zm.imageUrl = modal.Url;
                                                  zm.storeName = modal.StoreName;
                                                  zm.partsSrcName = modal.PartsSrcName;
                                                  zm.purityName = modal.PurityName;
                                                  [_modelArray addObject:zm];
                                              }
                                              [SVProgressHUD dismiss];
                                              [userStoreTableView reloadData];

                                          } else {
                                              [SVProgressHUD showErrorWithStatus:k_Error_WebViewError];
                                              
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      NSLog(@"dfgdfg");
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                  }];
    
}


//页面
-(void)initUI
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, 0,( SCREEN_WIDTH-40)/2, 35)];//allocate titleView
    // UIColor *color =  self.navigationController.navigationBar.tintColor;
    [titleView setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:205/255.0 alpha:1]];
    //搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, (SCREEN_WIDTH-40)/2, 35);
    searchBar.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    searchBar.placeholder=@"搜索：配件/商店";
    [titleView addSubview:searchBar];
    
    //Set to titleView
    self.navigationItem.titleView = titleView;
    
    for (NSInteger i=0; i<8; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(5+((SCREEN_WIDTH-70)/4+20)*(i%4),10+(25+(SCREEN_WIDTH-70)/4)*(i/4), (SCREEN_WIDTH-70)/4, (SCREEN_WIDTH-70)/4)];
        imageView.backgroundColor=[UIColor whiteColor];
        imageView.image=[UIImage imageNamed:imageArray[i]];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(5+((SCREEN_WIDTH-70)/4+20)*(i%4),10+(25+(SCREEN_WIDTH-70)/4)*(i/4), (SCREEN_WIDTH-70)/4, (SCREEN_WIDTH-70)/4)];
        button.tag=100+i;
        [button addTarget:self action:@selector(clickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(5+((SCREEN_WIDTH-70)/4+20)*(i%4), (15+(SCREEN_WIDTH-70)/4)+(5+20+(SCREEN_WIDTH-70)/4)*(i/4), (SCREEN_WIDTH-70)/4, 20)];
        label.backgroundColor=[UIColor whiteColor];
        label.text=lableArray[i];
        label.textColor=[UIColor lightGrayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:13];
        [self.view addSubview:imageView];
        [self.view addSubview:label];
        UILabel *hotLable=[[UILabel alloc]initWithFrame:CGRectMake(0, (25+(SCREEN_WIDTH-70)/4)+(5+20+(SCREEN_WIDTH-70)/4)+20,  SCREEN_WIDTH, 40)];
        hotLable.backgroundColor=[UIColor colorWithRed:246/255.0 green:247/255.0 blue:242/255.0 alpha:1];
        hotLable.text=@"  热门推荐";
        [self.view addSubview:hotLable];
        userStoreTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, (25+(SCREEN_WIDTH-70)/4)+(5+20+(SCREEN_WIDTH-70)/4)+20+40, SCREEN_WIDTH, SCREEN_HEIGHT-((25+(SCREEN_WIDTH-70)/4)+(5+20+(SCREEN_WIDTH -70)/4)+20+40))];
        userStoreTableView.delegate=self;
        userStoreTableView.dataSource=self;
        [userStoreTableView registerNib:[UINib nibWithNibName:@"UsrStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"userStoreCellIdentifer"];
        [self.view addSubview:userStoreTableView];
    }
}


//这个方法是用来创建cell对象，并且给cell设置相关属性的
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //设置标识符
    static NSString *userStoreCellIdentifer = @"userStoreCellIdentifer";
    UsrStoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userStoreCellIdentifer"];
    if (cell == nil) {
        cell = [[UsrStoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userStoreCellIdentifer];
    }
    [cell setDataWithModel:_modelArray[indexPath.row]];
    
    return cell;
}

//返回section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark -- UITableViewDelegate
//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      return 100 ;
}
//选中cell时调起的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选中cell要做的操作
    [self setHidesBottomBarWhenPushed:YES];
   // GoodsDetailsViewController *GoodsDetailsVC=[[GoodsDetailsViewController alloc]init];
    ScrollViewTestViewController *ScrollViewTestVC=[[ScrollViewTestViewController alloc]init];
    [self.navigationController pushViewController:ScrollViewTestVC animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    
}




/**
 *  @author oyj, 16-02-29
 *  返回数据
 *  添加订单
 */
-(void)AddOrderByNetwork
{
    
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,@"Usr.asmx/AddOrders"];
    
    NSDictionary *garageOrdersJson =@{
                                     @"Evaluate":@"",
                                     @"Id":@"0920de8a-405f-4190-ab5b-6c8825d775c4",
                                     @"Mobile":@"13351784891",
                                     @"Price":@"0",
                                     @"Reason":@"",
                                     @"Serial":@"",
                                     @"UsrGarageId":@"ea5b52e3-61a1-45c9-8dc6-f9b288079707",
                                     @"UsrId":@"69ba1168-274c-4c05-9baf-96c6c4427db6",
                                    };
    
    NSError *error;
    NSData *garageOrdersJsonData = [NSJSONSerialization dataWithJSONObject:garageOrdersJson options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
    NSString *garageOrdersJsonDataJsonString = [[NSString alloc] initWithData:garageOrdersJsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *partsOrdersJson =@{
                                     @"Addr":@"红旗大街100",
                                     @"CityId":@"50b06cb7-e881-4206-aebf-0a83062d1810",
                                     @"Consignee":@"马骥的修理厂",
                                     @"GarageOrdersId":@"0920de8a-405f-4190-ab5b-6c8825d775c4",
                                     @"Id":@"c7a57ac5-94df-4620-9785-73d02448601f",
                                     @"Mobile":@"13351784891",
                                     @"Msg":@"",
                                     @"Price":@"0.01",
                                     @"StoreId":@"7bc156c6-7ef9-4c6c-a9d4-2e31a81266a4",
                                     @"UsrId":@"69ba1168-274c-4c05-9baf-96c6c4427db6",
                                     @"UsrType":@"0",
                                     };
    NSArray *partsOrdersJsonArray=@[partsOrdersJson];
    
    NSData *partsOrdersJsonArrayData = [NSJSONSerialization dataWithJSONObject:partsOrdersJsonArray options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
    NSString *partsOrdersJsonArrayDataJsonString = [[NSString alloc] initWithData:partsOrdersJsonArrayData encoding:NSUTF8StringEncoding];
    
    
    NSDictionary *partsLstJson =@{
                                     @"Cnt":@"1",
                                     @"Id":@"456fec3e-7729-47d2-96ff-e542e905ff7f",
                                     @"OrdersId":@"c7a57ac5-94df-4620-9785-73d02448601f",
                                     @"PartsId":@"09e63318-7b8b-44db-a492-dd62e99021c8",
                                     @"Price":@"0.01",
                                     };
     NSArray *partsLstJsonArray=@[partsLstJson];
    
    NSData *partsLstJsonArrayData = [NSJSONSerialization dataWithJSONObject:partsLstJsonArray options:NSJSONWritingPrettyPrinted error:&error];//此处data参数是我上面提到的key为"data"的数组
    NSString *partsLstJsonArrayDataJsonString = [[NSString alloc] initWithData:partsLstJsonArrayData encoding:NSUTF8StringEncoding];
    
    
    
    
    NSDictionary *paramDict = @{
                                @"garageOrdersJson":garageOrdersJsonDataJsonString,
                                @"partsOrdersJson":partsOrdersJsonArrayDataJsonString,
                                @"partsLstJson":partsLstJsonArrayDataJsonString,
                                };
    
    [ApplicationDelegate.httpManager POST:urlStr
                               parameters:paramDict
                                 progress:^(NSProgress * _Nonnull uploadProgress) {}
                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                      //http请求状态
                                      if (task.state == NSURLSessionTaskStateCompleted) {
                                          //            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
                                          NSError* error;
                                          NSDictionary* jsonDic = [NSJSONSerialization
                                                                   JSONObjectWithData:responseObject
                                                                   options:kNilOptions
                                                                   error:&error];
                                          if (jsonDic[@"Success"]) {
                                              //成功
                                        } else {
                                              //失败
                                          }
                                          
                                      } else {
                                          [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                      }
                                      
                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                      //请求异常
                                      [SVProgressHUD showErrorWithStatus:k_Error_Network];
                                  }];
    
}
@end
