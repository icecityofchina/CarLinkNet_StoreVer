//
//  MyShopReleaseVC.m
//  CLWsdht
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "MyShopReleaseVC.h"
#import "FSDropDownMenu.h"//弹出菜单
#import "UIImageView+WebCache.h"
#import "ZLPhoto.h"
#import "UserInfo.h"

#import "MyShopChoosePhotoVC.h"//图片选择页面
#import "MyShopCarBrandCateInfo.h"//汽车品牌分类
#import "MyShopCarBrandNameInfo.h"//汽车品牌名称
#import "MyShopCarAccessoryCateInfo.h"//配件分类
#import "MyShopCarAccessoryNameInfo.h"//配件名称
#import "MyShopCarAccessoryColorInfo.h"//配件颜色
#import "MyShopCarAccessoryPurityInfo.h"//配件成色
#import "MyShopCarAccessorySourceInfo.h"//配件来源



@interface MyShopReleaseVC ()<
UITextViewDelegate,
UIActionSheetDelegate,
FSDropDownMenuDataSource,
FSDropDownMenuDelegate
>{
    UIActionSheet *action_accessory_color;//颜色
    UIActionSheet *action_accessory_purity;//成色
    UIActionSheet *action_accessory_source;//来源
    
    
    NSMutableArray *ma_brand_name;//汽车品牌
    NSMutableArray *ma_accessory_cate;//配件分类
    NSMutableArray *ma_accessory_color;//配件颜色
    NSMutableArray *ma_accessory_purity;//配件成色
    NSMutableArray *ma_accessory_source;//配件来源
    
    BOOL isSeletedCarBrand;//是否选择的是汽车品牌类型(默认为YES,当点击的时候切换)
    MyShopCarBrandCateInfo *currentCarBrandCate;//当前品牌分类
    MyShopCarBrandNameInfo *currentCarBrandName;//当前品牌名称
    MyShopCarAccessoryCateInfo *currentCarAccessoryCate;//当前配件分类
    MyShopCarAccessoryNameInfo *currentCarAccessoryName;//当前配件名称
    MyShopCarAccessoryColorInfo *currentCarAccessoryColor;//当前颜色名称
    MyShopCarAccessoryPurityInfo *currentCarAccessoryPurity;//当前成色名称
    MyShopCarAccessorySourceInfo *currentCarAccessorySource;//当前来源名称
    
    
    /**
     *  用户选择的图片数组
     */
    NSMutableArray *maPhotos;
    /**
     *  主图的索引
     */
    NSInteger index_main_image;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView       *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *iv_main;//主图
@property (weak, nonatomic) IBOutlet UILabel     *lbl_upload;//点击上传提醒label
@property (weak, nonatomic) IBOutlet UITextField *tf_accessory_name;//配件名称
@property (weak, nonatomic) IBOutlet UITextField *tf_price;//价格
@property (weak, nonatomic) IBOutlet UIButton    *btn_brand;//品牌
@property (weak, nonatomic) IBOutlet UITextField *tf_delivery;//排量
@property (weak, nonatomic) IBOutlet UIButton    *btn_accessory_cate;//配件分类
@property (weak, nonatomic) IBOutlet UIButton    *btn_accessory_color;//配件颜色
@property (weak, nonatomic) IBOutlet UIButton    *btn_accessory_source;//配件来源
@property (weak, nonatomic) IBOutlet UIButton    *btn_accessory_purity;//配件成色
@property (weak, nonatomic) IBOutlet UITextView  *tv_accessory_description;//配件描述
@property (weak, nonatomic) IBOutlet UILabel     *lbl_accessory_description;//配件描述
@property (weak, nonatomic) IBOutlet UILabel     *lbl_input_count;//输入字数
@property (weak, nonatomic) IBOutlet UIButton    *btnRelease;//发布

/**
 *  tap
 */
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tap_choose_image;//单击选择图片手势

/**
 *  cons
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consContentViewHeight;//内容高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consContentViewWidth;//内容宽度

@end

@implementation MyShopReleaseVC

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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:k_Notification_UpdateUserSeletedPhotos_MyShop
                                                  object:nil];
}

#pragma mark - Data & UI
//数据
-(void)initData
{
    self.hidesBottomBarWhenPushed = YES;
    
    ma_brand_name       = [NSMutableArray array];
    ma_accessory_cate   = [NSMutableArray array];
    ma_accessory_color  = [NSMutableArray array];
    ma_accessory_purity = [NSMutableArray array];
    ma_accessory_source = [NSMutableArray array];
    
    _tv_accessory_description.delegate = self;
    
    FSDropDownMenu *menu = [[FSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:SCREEN_HEIGHT-64];
    menu.tag = 1001;
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    
    action_accessory_color  = [[UIActionSheet alloc] initWithTitle:@"配件颜色" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    action_accessory_source = [[UIActionSheet alloc] initWithTitle:@"配件来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    action_accessory_purity = [[UIActionSheet alloc] initWithTitle:@"配件成色" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    /**
     *  加载数据
     */
    [self getBrandInfoFromNetwork];
    [self getAccessoryCateInfoFromNetwork];
    [self getAccessoryColorInfoFromNetwork];
    [self getAccessorySourceInfoFromNetwork];
    [self getAccessoryPurityInfoFromNetwork];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUserPhotos:)
                                                 name:k_Notification_UpdateUserSeletedPhotos_MyShop
                                               object:nil];
    
}
//页面
-(void)initUI
{
    _consContentViewWidth.constant = SCREEN_WIDTH;
    _consContentViewHeight.constant = CGRectGetMaxY(_btnRelease.frame) + 20;
}

#pragma mark - Notification Methods

- (void)updateUserPhotos:(NSNotification *) noti
{
    /**
     *  存储用户选择的图片
     */
    maPhotos = noti.object;
    
    if ([maPhotos isKindOfClass:[NSArray class]] && maPhotos.count > 0) {
        index_main_image = [noti.userInfo[@"index_main_image"] integerValue];
        ZLPhotoAssets *asset = maPhotos[index_main_image];
        UIImage *image_main;
        if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
            image_main = [asset aspectRatioImage];
        }else if([asset isKindOfClass:[UIImage class]]){
            image_main = (UIImage *)asset;
        }else if ([asset isKindOfClass:[ZLCamera class]]){
            image_main = [asset thumbImage];
        } else {
            image_main = nil;
        }
        _iv_main.image = image_main;
        _lbl_upload.alpha = 0;
    } else {
        index_main_image = 0 ; //这里其实已经变成没有了
        _iv_main.image = [UIImage imageNamed:@"shangchuanzhaopian_mg_zuoqian"];
        _lbl_upload.alpha = 1;
    }
    
}

#pragma mark - Target & Action
/**
 *  选择图片
 *
 *  @param sender 单击手势
 */
- (IBAction)tap_choose_image_action:(UITapGestureRecognizer *)sender
{
    MyShopChoosePhotoVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MyShopChoosePhotoVC class])];
    if (maPhotos.count > 0) {
        vc.maPhotos = maPhotos;
    } else {
        vc.maPhotos = nil;
    }
    vc.index_main_image = index_main_image;
    
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  品牌车型点击
 */
- (IBAction)brand_click
{
    isSeletedCarBrand = YES;
    if (ma_brand_name.count > 0) {
        FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
        [menu.firstTableView reloadData];
        [menu.secondTableView reloadData];
        [UIView animateWithDuration:0.2 animations:^{
        } completion:^(BOOL finished) {
            [menu menuTapped];
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"正在加载汽车品牌信息"];
        ma_brand_name = [NSMutableArray array];
        [self getBrandInfoFromNetwork];
    }
    
}

/**
 *  配件分类点击
 */
- (IBAction)accessory_cate_click
{
    isSeletedCarBrand = NO;
    if (ma_accessory_cate.count > 0) {
        FSDropDownMenu *menu = (FSDropDownMenu*)[self.view viewWithTag:1001];
        [menu.firstTableView reloadData];
        [menu.secondTableView reloadData];
        [UIView animateWithDuration:0.2 animations:^{
        } completion:^(BOOL finished) {
            [menu menuTapped];
        }];
    } else {
        [SVProgressHUD showErrorWithStatus:@"正在加载配件分类信息"];
        ma_accessory_cate = [NSMutableArray array];
        [self getAccessoryCateInfoFromNetwork];
    }
}

/**
 *  配件颜色点击
 */
- (IBAction)accessory_color_click
{
    if (ma_accessory_color.count > 0) {
        [action_accessory_color showInView:self.view];
    } else {
        [SVProgressHUD showErrorWithStatus:@"正在加载配件颜色信息"];
        ma_accessory_color = [NSMutableArray array];
        [self getAccessoryColorInfoFromNetwork];
    }
}

/**
 *  配件来源点击
 */
- (IBAction)accessory_source_click
{
    if (ma_accessory_source.count > 0) {
        [action_accessory_source showInView:self.view];
    } else {
        [SVProgressHUD showErrorWithStatus:@"正在加载配件来源信息"];
        ma_accessory_source = [NSMutableArray array];
        [self getAccessorySourceInfoFromNetwork];
    }
}

/**
 *  配件成色点击
 */
- (IBAction)accessory_purity_click
{
    if (ma_accessory_purity.count > 0) {
        [action_accessory_purity showInView:self.view];
    } else {
        [SVProgressHUD showErrorWithStatus:@"正在加载配件成色信息"];
        ma_accessory_purity = [NSMutableArray array];
        [self getAccessoryPurityInfoFromNetwork];
    }
}
/**
 *  发布按钮点击
 *
 *  @param sender 发布按钮
 */
- (IBAction)releaseAction:(UIButton *)sender
{
    if (!maPhotos || maPhotos.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"您还没有选择图片"];
        return;
    }
    if ([_tf_accessory_name.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入配件名称"];
        return;
    }
    if (!currentCarBrandName) {
        [SVProgressHUD showErrorWithStatus:@"请选择品牌车型"];
        return;
    }
    if ([_tf_delivery.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入适配车辆排量"];
        return;
    }
    if (!currentCarAccessoryName) {
        [SVProgressHUD showErrorWithStatus:@"请选择配件分类"];
        return;
    }
    if (!currentCarAccessoryColor) {
        [SVProgressHUD showErrorWithStatus:@"请选择配件颜色"];
        return;
    }
    if (!currentCarAccessoryPurity) {
        [SVProgressHUD showErrorWithStatus:@"请选择配件成色"];
        return;
    }
    if (!currentCarAccessorySource) {
        [SVProgressHUD showErrorWithStatus:@"请选择配件来源"];
        return;
    }
    if ([_tv_accessory_description.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入配件描述"];
        return;
    }
    /**
     *  发送上传请求信息
     */
    [self postAccessoryInfosToNetwork];
    
    
}

#pragma mark - Functions Custom

/**
 *  更新汽车品牌的选择
 */
- (void)updateCarBrandInfo
{
    NSString *carBrandName = [NSString stringWithFormat:@"%@ %@",currentCarBrandCate.Name,currentCarBrandName.Name];
    [_btn_brand setTitle:carBrandName forState:UIControlStateNormal];
}

/**
 *  更新配件分类的选择
 */
- (void)updateCarAccessoryInfo
{
    NSString *accessoryCateName = [NSString stringWithFormat:@"%@ %@",currentCarAccessoryCate.Name,currentCarAccessoryName.Name];
    [_btn_accessory_cate setTitle:accessoryCateName forState:UIControlStateNormal];
}

#pragma mark - TextView Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        _lbl_accessory_description.alpha = 0;
    } else {
        _lbl_accessory_description.alpha = 1;
    }
    
    if (textView.text.length > 500) {
        textView.text = [textView.text substringToIndex:500];
    }
    _lbl_input_count.text = [NSString stringWithFormat:@"%lu/500",(unsigned long)textView.text.length];
}

#pragma mark - ActionSheet Delegate

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /**
     *  取消按钮点击
     */
    if (buttonIndex == 0) {
        return;
    }
    
    if (action_accessory_color == actionSheet) {
        currentCarAccessoryColor = ma_accessory_color[buttonIndex - 1];
        [_btn_accessory_color setTitle:currentCarAccessoryColor.Name forState:UIControlStateNormal];
    } else if (action_accessory_source == actionSheet) {
        currentCarAccessorySource = ma_accessory_source[buttonIndex - 1];
        [_btn_accessory_source setTitle:currentCarAccessorySource.Name forState:UIControlStateNormal];
    } else {
        currentCarAccessoryPurity = ma_accessory_purity[buttonIndex - 1];
        [_btn_accessory_purity setTitle:currentCarAccessoryPurity.Name forState:UIControlStateNormal];
    }
    
}

#pragma mark - FSDropDown datasource & delegate

- (NSInteger)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == menu.firstTableView) {
        if (isSeletedCarBrand ) {
            return ma_brand_name.count;
        } else {
            return ma_accessory_cate.count;
        }
    } else {
        if (isSeletedCarBrand) {
            if (currentCarBrandCate) {
                return currentCarBrandCate.T_DicCarModel.count;
            } else {
                return 0;
            }
        } else {
            if (currentCarAccessoryCate) {
                return currentCarAccessoryCate.T_DicPartsType.count;
            } else {
                return 0;
            }
        }
    }
}
- (NSString *)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == menu.firstTableView) {
        if (isSeletedCarBrand) {
            MyShopCarBrandCateInfo *cateInfo = ma_brand_name[indexPath.row];
            return cateInfo.Name;
        } else {
            MyShopCarAccessoryCateInfo *cateInfo = ma_accessory_cate[indexPath.row];
            return cateInfo.Name;
        }
    } else {
        
        if (isSeletedCarBrand) {
            if (currentCarBrandCate) {
                MyShopCarBrandNameInfo *nameInfo = currentCarBrandCate.T_DicCarModel[indexPath.row];
                return nameInfo.Name;
            } else {
                return nil;
            }
        } else {
            if (currentCarAccessoryCate) {
                MyShopCarAccessoryNameInfo *nameInfo = currentCarAccessoryCate.T_DicPartsType[indexPath.row];
                return nameInfo.Name;
            } else {
                return nil;
            }
        }
    }
}

- (void)menu:(FSDropDownMenu *)menu tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == menu.firstTableView){
        if (isSeletedCarBrand) {
            MyShopCarBrandCateInfo *cateInfo = ma_brand_name[indexPath.row];
            currentCarBrandCate = cateInfo;
        } else {
            MyShopCarAccessoryCateInfo *cateInfo = ma_accessory_cate[indexPath.row];
            currentCarAccessoryCate = cateInfo;
        }
        [menu.secondTableView reloadData];
    } else {
        if (isSeletedCarBrand) {
            
            MyShopCarBrandNameInfo *nameInfo = currentCarBrandCate.T_DicCarModel[indexPath.row];
            currentCarBrandName = nameInfo;
            /**
             *  更新汽车品牌的显示
             */
            [self updateCarBrandInfo];
        } else {
            MyShopCarAccessoryNameInfo *nameInfo = currentCarAccessoryCate.T_DicPartsType[indexPath.row];
            currentCarAccessoryName = nameInfo;
            /**
             *  更新配件分类的选择
             */
            [self updateCarAccessoryInfo];
        }
    }
}

#pragma mark - Networking

/**
 *  获取品牌
 */
- (void) getBrandInfoFromNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_Dic_GetCarBrand];
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD dismiss];
                NSArray *arr  = jsonDic[@"Data"];
                if (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                    for (NSDictionary *dic in arr) {
                        MyShopCarBrandCateInfo *info = [[MyShopCarBrandCateInfo alloc] initWithDic:dic];
                        [ma_brand_name addObject:info];
                    }
                } else {
                    [SVProgressHUD showErrorWithStatus:@"获取失败"];
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"Message"]];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求异常
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
    
}

/**
 *  获取配件分类
 */
- (void) getAccessoryCateInfoFromNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_Dic_GetPartsUseFor];
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD dismiss];
                NSArray *arr  = jsonDic[@"Data"];
                if (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                    for (NSDictionary *dic in arr) {
                        MyShopCarAccessoryCateInfo *info = [[MyShopCarAccessoryCateInfo alloc] initWithDic:dic];
                        [ma_accessory_cate addObject:info];
                    }
                } else {
                    [SVProgressHUD showErrorWithStatus:@"获取失败"];
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"Message"]];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求异常
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
    
}

/**
 *  获取颜色
 */
- (void) getAccessoryColorInfoFromNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_Dic_GetColour];
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD dismiss];
                NSArray *arr  = jsonDic[@"Data"];
                if (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                    for (NSDictionary *dic in arr) {
                        MyShopCarAccessoryColorInfo *info = [[MyShopCarAccessoryColorInfo alloc] initWithDic:dic];
                        [ma_accessory_color addObject:info];
                        /**
                         *  给actionSheet添加按钮
                         */
                        [action_accessory_color addButtonWithTitle:info.Name];
                    }
                } else {
                    [SVProgressHUD showErrorWithStatus:@"获取失败"];
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"Message"]];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求异常
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
}

/**
 *  获取成色
 */
- (void) getAccessoryPurityInfoFromNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_Dic_GetPurity];
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD dismiss];
                NSArray *arr  = jsonDic[@"Data"];
                if (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                    for (NSDictionary *dic in arr) {
                        MyShopCarAccessoryPurityInfo *info = [[MyShopCarAccessoryPurityInfo alloc] initWithDic:dic];
                        [ma_accessory_purity addObject:info];
                        /**
                         *  给actionSheet添加按钮
                         */
                        [action_accessory_purity addButtonWithTitle:info.Name];
                    }
                } else {
                    [SVProgressHUD showErrorWithStatus:@"获取失败"];
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"Message"]];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求异常
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
}

/**
 *  获取配件来源
 */
- (void) getAccessorySourceInfoFromNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_Dic_GetPartsSrc];
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD dismiss];
                NSArray *arr  = jsonDic[@"Data"];
                if (arr && [arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                    for (NSDictionary *dic in arr) {
                        MyShopCarAccessorySourceInfo *info = [[MyShopCarAccessorySourceInfo alloc] initWithDic:dic];
                        [ma_accessory_source addObject:info];
                        /**
                         *  给actionSheet添加按钮
                         */
                        [action_accessory_source addButtonWithTitle:info.Name];
                    }
                } else {
                    [SVProgressHUD showErrorWithStatus:@"获取失败"];
                }
                
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"Message"]];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求异常
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
    
}


/**
 *  上传配件信息
 */
- (void) postAccessoryInfosToNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_AddParts];
    NSString *uuid = [MJYUtils mjy_uuid];
    NSString *user_id = ApplicationDelegate.userInfo.user_Id;
    NSDictionary *paramDic1 = @{
                                @"Id":uuid,
                                @"UsrStoreId":user_id,
                                @"PartsUseForId":currentCarAccessoryCate.Id,
                                @"PartsTypeId":currentCarAccessoryName.Id,
                                @"Name":_tf_accessory_name.text,
                                @"Spec":@"",
                                @"Description":_tv_accessory_description.text,
                                @"Price":_tf_price.text,
                                @"PurityId":currentCarAccessoryPurity.Id,
                                @"PartsSrcId":currentCarAccessorySource.Id
                                };
    
    NSDictionary *paramDic2 = @{
                                @"Id":[MJYUtils mjy_uuid],
                                @"PartsId":uuid,
                                @"CarBrandId":currentCarBrandCate.Id,
                                @"CarModelId":currentCarBrandName.Id,
                                @"SIG":currentCarBrandCate.SIG
                                };
    NSDictionary *jsonParam = @{
                                @"partJson":[JYJSON JSONStringWithDictionaryOrArray:paramDic1],
                                @"carModelJson":[JYJSON JSONStringWithDictionaryOrArray:paramDic2]
                                };
    [ApplicationDelegate.httpManager POST:urlStr parameters:jsonParam progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD dismiss];
                /**
                 *  上传图片
                 */
                [self postAccessoryImagesToNetwork];
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"Message"]];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:k_Error_Network];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求异常
        [SVProgressHUD showErrorWithStatus:k_Error_Network];
    }];
    
}



/**
 *  上传配件图片
 */
- (void) postAccessoryImagesToNetwork
{
    [SVProgressHUD showWithStatus:k_Status_UpLoad maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_AddImg];
    
    NSDictionary *paramDict = @{
                                @"Id":[MJYUtils mjy_uuid],//这个字段需要每次不同
                                @"dataId":ApplicationDelegate.userInfo.user_Id,//必须是用户的id
                                @"isSingle":@"true",
                                @"isFirst":@"true"
                                };
    
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:paramDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //        NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
        //        [formData appendPartWithFileData:imageData name:ApplicationDelegate.userInfo.user_Id fileName:ApplicationDelegate.userInfo.user_Id mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD showSuccessWithStatus:@"图像上传成功"];
                
            } else {
                [SVProgressHUD showErrorWithStatus:jsonDic[@"Message"]];
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
