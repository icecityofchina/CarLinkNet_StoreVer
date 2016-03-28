//
//  MyShopChoosePhotoVC.m
//  CLWsdht
//
//  Created by majinyu on 16/1/17.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#define k_max_count  10

#import "MyShopChoosePhotoVC.h"
#import "MyShopPhotoCell.h"
#import "UIImageView+WebCache.h"
#import "ZLPhoto.h"


@interface MyShopChoosePhotoVC ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UIActionSheetDelegate,
ZLPhotoPickerBrowserViewControllerDataSource,
ZLPhotoPickerBrowserViewControllerDelegate
>{
    
    
    /**
     *  1:图片选择类型
     *  2:设置主图还是打开图片浏览器
     */
    NSInteger actionSheetType;
    
    /**
     *  用户选点击的indexPath
     */
    NSIndexPath *currentIndexPath;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem  *photoSelecte;//选择图片按钮
@property (weak, nonatomic) IBOutlet UIButton         *btnSave;//保存按钮
@property (strong, nonatomic) ZLCameraViewController  *cameraVc;//自定义相机
@property (strong, nonatomic) NSMutableArray          *assets;//用户选择的图片


@end

@implementation MyShopChoosePhotoVC

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
    
}
//页面
-(void)initUI
{
    
}

- (NSMutableArray *)assets
{
    if ( !_assets) {
        NSMutableArray *ma = _maPhotos == nil ? [NSMutableArray array] :_maPhotos;
        _assets = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithArray:ma], nil];
    }
    return _assets;
}

#pragma mark - Target & Action
/**
 *  选择照片
 *
 *  @param sender
 */
- (IBAction)photoSeleteAction:(UIBarButtonItem *)sender
{
    
    actionSheetType = 1;
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:@"选择照片"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"打开照相机",@"从手机相册获取",nil];
    [myActionSheet showInView:self.view];
}

/**
 *  图片保存Action
 *
 *  @param sender 保存按钮
 */
- (IBAction)photoSaveAction:(UIButton *)sender
{
    if ([[self.assets firstObject] count] > 0) {
        
        NSDictionary *userDic = @{@"index_main_image":[NSString stringWithFormat:@"%d",_index_main_image]};
        [[NSNotificationCenter defaultCenter] postNotificationName:k_Notification_UpdateUserSeletedPhotos_MyShop
                                                            object:[self.assets firstObject]
                                                          userInfo:userDic];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [SVProgressHUD showErrorWithStatus:@"您还没有选择图片"];
    }
    
    
}


#pragma mark - Functions Custom

/**
 *  相机
 */
- (void)openCamera
{
    ZLCameraViewController *cameraVc = [[ZLCameraViewController alloc] init];
    // 拍照最多个数
    cameraVc.maxCount = k_max_count;
    __weak typeof(self) weakSelf = self;
    cameraVc.callback = ^(NSArray *cameras){
        [[weakSelf.assets firstObject] addObjectsFromArray:cameras];
        [weakSelf.collectionView reloadData];
    };
    [cameraVc showPickerVc:self];
}

/**
 *  相册
 */
- (void)openLocalPhoto
{
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    // 最多能选9张图片
    if (self.assets.count > k_max_count) {
        pickerVc.maxCount = 0;
    } else {
        pickerVc.maxCount = k_max_count - self.assets.count;
    }
    pickerVc.status = PickerViewShowStatusCameraRoll;
    [pickerVc showPickerVc:self];
    
    __weak typeof(self) weakSelf = self;
    pickerVc.callBack = ^(NSArray *assets) {
        [[weakSelf.assets firstObject] addObjectsFromArray:assets];
        [weakSelf.collectionView reloadData];
    };
}


/**
 *  更新主图
 */
- (void) updateMainImage
{
    _index_main_image = currentIndexPath.item;
    [_collectionView reloadData];
}


/**
 *  打开图片浏览器
 */
- (void)openPhotoBrowser
{
    // 图片游览器
    ZLPhotoPickerBrowserViewController *pickerBrowser = [[ZLPhotoPickerBrowserViewController alloc] init];
    
    // 数据源/delegate
    // 动画方式
    /*
     *
     UIViewAnimationAnimationStatusZoom = 0, // 放大缩小
     UIViewAnimationAnimationStatusFade , // 淡入淡出
     UIViewAnimationAnimationStatusRotate // 旋转
     pickerBrowser.status = UIViewAnimationAnimationStatusFade;
     */
    pickerBrowser.delegate = self;
    pickerBrowser.dataSource = self;
    // 是否可以删除照片
    pickerBrowser.editing = YES;
    // 当前分页的值
    // pickerBrowser.currentPage = indexPath.row;
    // 传入组
    pickerBrowser.currentIndexPath = currentIndexPath;
    // 展示控制器
    [pickerBrowser showPickerVc:self];
}


#pragma mark - CollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.assets.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assets[section] count];
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(-10+SCREEN_WIDTH/2, -10+SCREEN_WIDTH/2);
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MyShopPhotoCell";
    MyShopPhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    // 判断类型来获取Image
    ZLPhotoAssets *asset = self.assets[indexPath.section][indexPath.item];
    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
        cell.imageView.image = [asset aspectRatioImage];
    }else if ([asset isKindOfClass:[NSString class]]){
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"pc_circle_placeholder"]];
    }else if([asset isKindOfClass:[UIImage class]]){
        cell.imageView.image = (UIImage *)asset;
    }else if ([asset isKindOfClass:[ZLCamera class]]){
        cell.imageView.image = [asset thumbImage];
    }
    
    if (indexPath.item == _index_main_image) {
        cell.imageview_main.hidden = NO;
    } else {
        cell.imageview_main.hidden = YES ;
    }
    
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    currentIndexPath = indexPath;
    
    actionSheetType = 2 ;
    
    UIActionSheet *myActionSheet = [[UIActionSheet alloc]initWithTitle:@"选择行为"
                                                              delegate:self
                                                     cancelButtonTitle:@"取消"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"设置该图片为主图",@"打开图片浏览器",nil];
    [myActionSheet showInView:self.view];
    
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDataSource>

- (NSInteger)numberOfSectionInPhotosInPickerBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser
{
    return self.assets.count;
}

- (NSInteger)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section
{
    return [self.assets[section] count];
}

- (ZLPhotoPickerBrowserPhoto *)photoBrowser:(ZLPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath
{
    id imageObj = [self.assets[indexPath.section] objectAtIndex:indexPath.item];
    ZLPhotoPickerBrowserPhoto *photo = [ZLPhotoPickerBrowserPhoto photoAnyImageObjWith:imageObj];
    // 包装下imageObj 成 ZLPhotoPickerBrowserPhoto 传给数据源
    MyShopPhotoCell *cell = (MyShopPhotoCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    // 缩略图
    if ([imageObj isKindOfClass:[ZLPhotoAssets class]]) {
        photo.asset = imageObj;
    }
    photo.toView = cell.imageView;
    photo.thumbImage = cell.imageView.image;
    return photo;
}

#pragma mark - <ZLPhotoPickerBrowserViewControllerDelegate>

- (ZLPhotoPickerCustomToolBarView *)photoBrowserShowToolBarViewWithphotoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser
{
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(10, 0, 200, 44);
    return (ZLPhotoPickerCustomToolBarView *)customBtn;
}

- (void)photoBrowser:(ZLPhotoPickerBrowserViewController *)photoBrowser removePhotoAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > [self.assets[indexPath.section] count]) return;
    [self.assets[indexPath.section] removeObjectAtIndex:indexPath.row];
    
    if ([self.assets[indexPath.section] count] > 0) {
        /**
         *  主图可能被删除
         */
        if (_index_main_image == indexPath.row) {
            _index_main_image = 0;
        } else if (_index_main_image > indexPath.row) {
            -- _index_main_image;
        } else {
            
        }
    } else {
        _index_main_image = 0;
    }
    
    [self.collectionView reloadData];
}

#pragma mark - ActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheetType == 1) {
        switch (buttonIndex) {
            case 0:  //打开照相机拍照
                [self openCamera];
                break;
            case 1:  //打开本地相册
                [self openLocalPhoto];
                break;
            default:
                break;
        }
    } else if (actionSheetType == 2) {
        
        switch (buttonIndex) {
            case 0://设置主图
                [self updateMainImage];
                break;
            case 1://打开图片浏览器
                [self openPhotoBrowser];
                break;
            default:
                break;
        }
    }
}


#pragma mark - Networking

@end
