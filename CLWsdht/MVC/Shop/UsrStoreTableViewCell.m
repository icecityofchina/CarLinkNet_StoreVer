//
//  UsrStoreTableViewCell.m
//  CLWsdht
//
//  Created by koroysta1 on 16/3/19.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "UsrStoreTableViewCell.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@implementation UsrStoreTableViewCell

- (void)setDataWithModel:(UserStoreModel *)model{
    //[_image setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    
    [_title setText:[NSString stringWithFormat:@"￥%g", [model.price floatValue]]];
    _price.text = model.title;
    [_image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    _purityName.text = model.purityName;
    _partsSrcName.text = model.partsSrcName;
    _storeName.text = model.storeName;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
