//
//  UsrStoreTableViewCell.h
//  CLWsdht
//
//  Created by koroysta1 on 16/3/19.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserStoreModel.h"

@interface UsrStoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, strong) UserStoreModel *userStoreModel;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *partsSrcName;
@property (weak, nonatomic) IBOutlet UILabel *purityName;
- (void)setDataWithModel:(UserStoreModel *)model;


@end
