//
//  ScrollViewTestViewController.h
//  abcd
//
//  Created by leonshi on 6/20/14.
//  Copyright (c) 2014 leonshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DockMenuView.h"
#import "DockMenuSubView.h"

@interface ScrollViewTestViewController : UIViewController<UIScrollViewDelegate,DockMenuItemDelegate,UISearchBarDelegate>
{
    float mScrollViewOffsetY;
}
@property (nonatomic,retain) UIScrollView *mScrollView;
@property (nonatomic,retain) DockMenuView *mDockMenuView;
@property (nonatomic,retain) DockMenuView *mScrollDockMenuView;

@property (nonatomic,retain) DockMenuSubView *mDockMenuBackView_ProductDisplay;//商品展示视图
@property (nonatomic,retain) DockMenuSubView *mDockMenuBackView_BrandPrice;//品牌价值
@property (nonatomic,retain) DockMenuSubView *mDockMenuBackView_InvestDetails;//投资详情
@end
