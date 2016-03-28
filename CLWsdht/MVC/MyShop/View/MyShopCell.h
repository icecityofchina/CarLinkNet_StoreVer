//
//  MyShopCell.h
//  CLW
//
//  Created by majinyu on 16/1/16.
//  Copyright © 2016年 cn.com.cucsi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyShopCellInfo;

@interface MyShopCell : UITableViewCell

@property (strong, nonatomic) MyShopCellInfo *cellInfo;

@property (weak, nonatomic) IBOutlet UIImageView *iv_main;//主图
@property (weak, nonatomic) IBOutlet UILabel     *lbl_title;//标题
@property (weak, nonatomic) IBOutlet UILabel     *lbl_brief;//简介
@property (weak, nonatomic) IBOutlet UIImageView *iv_is_shop;//是否是商家
@property (weak, nonatomic) IBOutlet UILabel     *lbl_has_verify;//是否验证
@property (weak, nonatomic) IBOutlet UILabel     *lbl_price;//单价
@property (weak, nonatomic) IBOutlet UILabel     *lbl_state1;//状态1
@property (weak, nonatomic) IBOutlet UILabel     *lbl_state2;//状态2
@property (weak, nonatomic) IBOutlet UIButton    *btn_up;//上架
@property (weak, nonatomic) IBOutlet UIButton    *btn_edit;//编辑
@property (weak, nonatomic) IBOutlet UIButton    *btn_down;//下架


/**
 *  设置cell的显示内容
 *
 *  @param cellInfo 模型数据
 */
- (void)setCellContentWithCellInfo:(MyShopCellInfo *) cellInfo;


@end
