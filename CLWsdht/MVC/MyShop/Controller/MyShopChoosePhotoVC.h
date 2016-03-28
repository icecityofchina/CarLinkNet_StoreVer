//
//  MyShopChoosePhotoVC.h
//  CLWsdht
//
//  Created by majinyu on 16/1/17.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "BaseViewController.h"

@interface MyShopChoosePhotoVC : BaseViewController

/**
 *  用户选择的图片数组 (如果第一次进来可能为nil)
 */
@property (nonatomic, strong) NSMutableArray *maPhotos;

/**
 *  默认是第一个(主图)
 */
@property (nonatomic, assign) NSInteger index_main_image;

@end
