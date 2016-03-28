//
//  ScrollViewTestViewController.m
//  abcd
//
//  Created by leonshi on 6/20/14.
//  Copyright (c) 2014 leonshi. All rights reserved.
//

#import "ScrollViewTestViewController.h"
#import "DockMenuView.h"
#import "SubmitOrderViewController.h"
#define DEVICE_3_5_INCH ([[UIScreen mainScreen] bounds].size.height == 480)
#define DEVICE_4_0_INCH ([[UIScreen mainScreen] bounds].size.height == 568)
#define DEVICE_4_7_INCH ([[UIScreen mainScreen] bounds].size.height == 667)
#define DEVICE_5_5_INCH ([[UIScreen mainScreen] bounds].size.height == 736)


@interface ScrollViewTestViewController ()<UIScrollViewDelegate>{
    UIScrollView *scrollView;//商品图片循环展示
    UIPageControl *pageControl;//小点点
    UIImageView *collectImageView;//收藏按钮图片
    NSInteger a;//收藏按钮点击次数
    NSArray *array; //快递，销量，地点
    NSArray *array1;//配件分类
}

@end

@implementation ScrollViewTestViewController
@synthesize mScrollView;
@synthesize mDockMenuView;
@synthesize mScrollDockMenuView;
@synthesize mDockMenuBackView_ProductDisplay;
@synthesize mDockMenuBackView_BrandPrice;
@synthesize mDockMenuBackView_InvestDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (DEVICE_3_5_INCH) {
        [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    }
    if(DEVICE_4_0_INCH)
    {
        [self.view setFrame:CGRectMake(0, 0, 320, 568)];
    }
    if(DEVICE_4_7_INCH)
    {
        [self.view setFrame:CGRectMake(0, 0, 375, 667)];
    }
    if (DEVICE_5_5_INCH)
   {
        [self.view setFrame:CGRectMake(0, 0, 414, 736)];
    }

    a=0;
    
    // Do any additional setup after loading the view from its nib.
    [self addBackgroundScrollView];
    [self addBackgroundScrollViewSubViews];
    [self addMenuViews];
}

//添加ScrollView用来显示所有的内容
-(void) addBackgroundScrollView
{
    mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20,self.view.frame.size.width , self.view.frame.size.height-20-50)];
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2)];
    [mScrollView setBackgroundColor:[UIColor whiteColor]];
    [mScrollView setDelegate:self];
    [self.view addSubview:mScrollView];
//商品照片视图
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width , self.view.frame.size.height*3/10)];
    [scrollView setContentSize:CGSizeMake(3*self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    [scrollView setBounces:NO];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [mScrollView addSubview:scrollView];
//创建3个imageview添加到到scrollView上面
    for (NSInteger i=0; i<3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"8821914_104949466000_2.jpg"];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width,self.view.frame.size.height*3/10)];
        [imageView setImage:image];
       [scrollView addSubview:imageView];
    }
//创建pageControl 小点点
    pageControl = [[UIPageControl alloc] init];
    [pageControl setNumberOfPages:3];
    CGSize controlSize = [pageControl sizeForNumberOfPages:3];
    [pageControl setFrame:CGRectMake(self.view.frame.size.width-controlSize.width, self.view.frame.size.height*3/10-controlSize.height, controlSize.width, controlSize.height)];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    [pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    [mScrollView addSubview:pageControl];
//商品名称
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(10,  self.view.frame.size.height*3/10,100 , self.view.frame.size.height*1/10)];
    name.backgroundColor=[UIColor whiteColor];
    name.text=@"白沙";
    name.font=[UIFont systemFontOfSize:15];
    [mScrollView addSubview:name];
//收藏按钮图片
    collectImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50,  self.view.frame.size.height*3/10+10,40 , 40)];
    collectImageView.image=[UIImage imageNamed:@"收藏.png"];

    [mScrollView addSubview:collectImageView];
//收藏按钮
    UIButton *collectButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50,  self.view.frame.size.height*3/10+10,40 , 40)];
    collectButton.backgroundColor=[UIColor clearColor];
    [collectButton addTarget:self action:@selector(buttonClickde) forControlEvents:(UIControlEventTouchUpInside)];
    [mScrollView addSubview:collectButton];
//商品标价
    UILabel *price=[[UILabel alloc]initWithFrame:CGRectMake(10,  self.view.frame.size.height*4/10,100 , self.view.frame.size.height*1/30)];
    price.text=@"¥11.00";
    price.font=[UIFont systemFontOfSize:20];
    price.textColor=[UIColor redColor];
    [mScrollView addSubview:price];
//快递 销量 位置
    array=@[@"快递：卖家包邮",@"月销量88件",@"黑龙江哈尔滨"];
    for (NSInteger i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width/3,  self.view.frame.size.height*13/30,self.view.frame.size.width/3 , self.view.frame.size.height*1/30)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
        label.textAlignment=NSTextAlignmentCenter;
        [mScrollView addSubview:label];
    }
//隔离带
    for (NSInteger i=0; i<2; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*14/30+i*self.view.frame.size.height/15,self.view.frame.size.width , self.view.frame.size.height/60)];
        
        label.backgroundColor=[UIColor colorWithRed:249/255.0 green:249/255.0 blue:255/255.0 alpha:1];
        [mScrollView addSubview:label];
    }
//配件类别，配件分类
      array=@[@"配件类别",@"车身配件",@"配件分类",@"车门"];
    for (NSInteger i=0;i<4;i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width/4,  self.view.frame.size.height*28.5/60,self.view.frame.size.width/3 , self.view.frame.size.height*1/15)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor grayColor];
        label.textAlignment=NSTextAlignmentCenter;
        [mScrollView addSubview:label];

    }
//商店头像
    UIImageView *headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, self.view.frame.size.height*33/60+10,self.view.frame.size.height/10-20 , self.view.frame.size.height/10-20)];
    headImageView.image=[UIImage imageNamed:@"头像.png"];
     [mScrollView addSubview:headImageView];
//商店名字
    UILabel *storelabel=[[UILabel alloc]initWithFrame:CGRectMake(15+self.view.frame.size.height/10-20+5,self.view.frame.size.height*33/60+10,100 , self.view.frame.size.height/20-10)];
    storelabel.text=@"过桥麻辣烫店";
    storelabel.font=[UIFont systemFontOfSize:15];
    storelabel.textColor=[UIColor blackColor];
    [mScrollView addSubview:storelabel];
//商店等级
    UIImageView *rankImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15+self.view.frame.size.height/10-20+5,self.view.frame.size.height*33/60+10+self.view.frame.size.height/20-10, self.view.frame.size.height/20-10, self.view.frame.size.height/20-10)];
    rankImageView.image=[UIImage imageNamed:@"等级砖石.png"];
    [mScrollView addSubview:rankImageView];
//全部宝贝 数量
    for (NSInteger i=0;i<2;i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0,  self.view.frame.size.height*2/3+i*self.view.frame.size.height*1/30,self.view.frame.size.width/3 , self.view.frame.size.height*1/30)];
        if (i==0) {
            label.text=@"250";
        }
        else{
        label.text=@"全部宝贝";
        }
        label.font=[UIFont systemFontOfSize:15];
        label.textColor=[UIColor blackColor];
        label.textAlignment=NSTextAlignmentCenter;
        [mScrollView addSubview:label];
    }
//关注人数 数量
    for (NSInteger i=0;i<2;i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3,  self.view.frame.size.height*2/3+i*self.view.frame.size.height*1/30,self.view.frame.size.width/3 , self.view.frame.size.height*1/30)];
        if (i==0) {
            label.text=@"2500";
        }
        else{
            label.text=@"关注人数";
        }
        label.font=[UIFont systemFontOfSize:15];
        label.textColor=[UIColor blackColor];
        label.textAlignment=NSTextAlignmentCenter;
        [mScrollView addSubview:label];
    }
//宝贝描述 卖家服务 物流服务
    for (NSInteger i=0;i<3;i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(2*self.view.frame.size.width/3-30,  self.view.frame.size.height*19.5/30+i*self.view.frame.size.height*1/30,80 , self.view.frame.size.height*1/30)];
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(2*self.view.frame.size.width/3-30+80,  self.view.frame.size.height*19.5/30+i*self.view.frame.size.height*1/30,30 , self.view.frame.size.height*1/30)];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(2*self.view.frame.size.width/3-30+80+35,  self.view.frame.size.height*19.5/30+i*self.view.frame.size.height*1/30,20 , self.view.frame.size.height*1/30)];
        if (i==0) {
            label.text=@"宝贝描述";
            label1.text=@"4.9";
            label2.text=@"高";

        }
        else if (i==1) {
            label.text=@"卖家服务";
            label1.text=@"4.9";
            label2.text=@"高";
        }
        else{
            label.text=@"物流服务";
            label1.text=@"4.9";
            label2.text=@"高";
        }
        label.font=[UIFont systemFontOfSize:15];
        label.textColor=[UIColor lightGrayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label1.font=[UIFont systemFontOfSize:15];
        label1.textColor=[UIColor redColor];
        label1.textAlignment=NSTextAlignmentCenter;
        label2.font=[UIFont systemFontOfSize:15];
        label2.textColor=[UIColor whiteColor];
        label2.textAlignment=NSTextAlignmentCenter;
        label2.backgroundColor=[UIColor redColor];
        [mScrollView addSubview:label];
        [mScrollView addSubview:label2];
        [mScrollView addSubview:label1];
    }

//查看分类 进店逛逛
    for (NSInteger i=0;i<2;i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/15+i*(self.view.frame.size.width*2/5), self.view.frame.size.height*4/5,self.view.frame.size.width/3 , 40)];
        button.backgroundColor=[UIColor lightGrayColor];
        if (i==0) {
            [button setTitle:@"查看分类" forState:UIControlStateNormal];
        }
        else{
            
            [button setTitle:@"进店逛逛" forState:UIControlStateNormal];
        }
        button.tag=1000+i;
        //设置圆角
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
        button.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        [button addTarget:self action:@selector(lookClickde:) forControlEvents:(UIControlEventTouchUpInside)];
        [mScrollView addSubview:button];
    }
    UIButton *backButton=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
     [backButton setTitle:@"<" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
    backButton.backgroundColor=[UIColor clearColor];
    [backButton addTarget:self action:@selector(backButton) forControlEvents:(UIControlEventTouchUpInside)];
    [mScrollView addSubview:backButton];

}
#pragma mark --返回按钮
-(void)backButton{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}


#pragma mark --加入购物车
- (IBAction)btn1:(UIButton *)sender {
    
}
#pragma mark --立即购买
- (IBAction)btn2:(UIButton *)sender {
    SubmitOrderViewController *submitOrderVC=[[SubmitOrderViewController alloc]init];
    [self presentViewController:submitOrderVC animated:YES completion:^{
        
    }];
}
#pragma mark -- 查看分类 进店逛逛 按钮点击事件
-(void)lookClickde:(UIButton*)btn{
    switch (btn.tag) {
        case 1000:
            
            break;
        case 1001:
            
            break;

        default:
            break;
    }
}

#pragma mark -- 收藏按钮点击事件
-(void)buttonClickde{
    a++;
    if (a%2==1) {
        collectImageView.image=[UIImage imageNamed:@"已收藏.png"];
    }
    if (a%2==0) {
        collectImageView.image=[UIImage imageNamed:@"收藏.png"];
    }
    
      //  collectImageView.image=[UIImage imageNamed:@""];

}
#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView{
    //获取当前拖动结束时scrollView的偏移位置
    CGFloat x = ascrollView.contentOffset.x;
    //通过偏移量获取当前页面为第几页
    NSInteger page = x/self.view.frame.size.width;
    //给pageControl设置当前页
    pageControl.currentPage = page;
}

#pragma mark -- pageControl的响应事件
- (void)pageChanged:(UIPageControl *)pageContrl{
    //根据page的改变设置scrollView的偏移量
    [scrollView setContentOffset:CGPointMake(self.view.frame.size.width*pageContrl.currentPage, 0) animated:YES];
}

//给scrollView添加内容
-(void) addBackgroundScrollViewSubViews
{
    
    
    for (NSInteger i=0; i<2; i++) {
        
//        UIButton *button=[UIButton alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    }
    mScrollDockMenuView  = [[DockMenuView alloc]initWithFrame:CGRectMake(0, mScrollView.frame.size.height-40, self.view.frame.size.width, 40)];
    mScrollDockMenuView.mDockMenuItemDelegate = self;

    [mScrollDockMenuView changeMenuItemState:K_MENUITEM_DEFAULT];
    [mScrollView addSubview:mScrollDockMenuView];
    [self addDockMenuSubViews_ProductDisplay];
    [self addDockMenuSubViews_BrandPrice];
    [self addDockMenuSubViews_InvestDetails];

}

//给窗口添加和scrollView中的菜单一样的试图，用于覆盖scrollView中的菜单，来达到菜单停靠的效果
-(void) addMenuViews
{
//    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-70, self.view.frame.size.width, 50)];
//    backView.backgroundColor=[UIColor blackColor];
//    [mScrollView addSubview:backView];
    mDockMenuView  = [[DockMenuView alloc]initWithFrame:CGRectMake(0, 20, mScrollDockMenuView.frame.size.width, mScrollDockMenuView.frame.size.height)];
    [mDockMenuView setHidden:YES];
    mDockMenuView.mDockMenuItemDelegate = self;
//    
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"图文详情",@"产品参数",@"商品评价", nil];
    [mDockMenuView setMenuItemData:array];
    [mDockMenuView changeMenuItemState:K_MENUITEM_DEFAULT];
    [self.view addSubview:mDockMenuView];
    
}

//根据scrollView滚动de偏移量来控制窗口菜单的显示与否
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    mScrollViewOffsetY = scrollView.contentOffset.y;
    if (mScrollViewOffsetY < mScrollDockMenuView.frame.origin.y) {
        [mDockMenuView setHidden:YES];
    }
    else
    {
        [mDockMenuView setHidden:NO];
    }
    NSLog(@"scrollview offset is :%f",scrollView.contentOffset.y);
}

//当用户点击菜单的时候，设置scrollView从指定的偏移位置开始显示
-(void) onDockMenuItemClick:(id)sender
{
    int tag = ((UIButton*) sender).tag;
    [self ChangeDockMenuSubViews:tag-K_MENUITEM_DEFAULT];
    
    if (mScrollViewOffsetY < mScrollDockMenuView.frame.origin.y) {
        [mDockMenuView changeMenuItemState:tag];
    }
    else
    {
        [mScrollDockMenuView changeMenuItemState:tag];
        [mScrollView setContentOffset:CGPointMake(0, mScrollDockMenuView.frame.origin.y-20) animated:YES];
    }
}

//商品展示子视图
-(void) addDockMenuSubViews_ProductDisplay
{
    mDockMenuBackView_ProductDisplay = [[DockMenuSubView alloc]initWithFrame:CGRectMake(0, mScrollDockMenuView.frame.origin.y + mScrollDockMenuView.frame.size.height +10, mScrollDockMenuView.frame.size.width, 40)];
    [mScrollView addSubview:mDockMenuBackView_ProductDisplay];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, mScrollDockMenuView.frame.size.width, self.view.frame.size.height+50)];
    [label setBackgroundColor:[UIColor redColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"menu1"];
    
    CGRect rect= mDockMenuBackView_ProductDisplay.frame;
    rect.size.height = label.frame.origin.y+label.frame.size.height+10;
    [mDockMenuBackView_ProductDisplay setFrame:rect];
    [mDockMenuBackView_ProductDisplay addSubview:label];
//    [mScrollView setContentSize:CGSizeMake(320, mDockMenuBackView_ProductDisplay.frame.origin.y+mDockMenuBackView_ProductDisplay.frame.size.height)];
    
}
//添加品牌价值子视图
-(void) addDockMenuSubViews_BrandPrice
{
    mDockMenuBackView_BrandPrice = [[DockMenuSubView alloc]initWithFrame:CGRectMake(0, mScrollDockMenuView.frame.origin.y + mScrollDockMenuView.frame.size.height +10, mScrollDockMenuView.frame.size.width, 40)];
    [mScrollView addSubview:mDockMenuBackView_BrandPrice];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, mScrollDockMenuView.frame.size.width, self.view.frame.size.height)];
    [label setBackgroundColor:[UIColor blueColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"menu2"];
    
    CGRect rect= mDockMenuBackView_BrandPrice.frame;
    rect.size.height = label.frame.origin.y+label.frame.size.height+10;
    [mDockMenuBackView_BrandPrice setFrame:rect];
    [mDockMenuBackView_BrandPrice addSubview:label];
    [mDockMenuBackView_BrandPrice setHidden:YES];
    
    
}

//添加投资详情子视图
-(void) addDockMenuSubViews_InvestDetails
{
    mDockMenuBackView_InvestDetails = [[DockMenuSubView alloc]initWithFrame:CGRectMake(10, mScrollDockMenuView.frame.origin.y + mScrollDockMenuView.frame.size.height +10, mScrollDockMenuView.frame.size.width-20, 40)];
    [mScrollView addSubview:mDockMenuBackView_InvestDetails];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, mScrollDockMenuView.frame.size.width-20, 40)];
    [label setBackgroundColor:[UIColor orangeColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"menu3"];
    
    CGRect rect= mDockMenuBackView_InvestDetails.frame;
    rect.size.height = label.frame.origin.y+label.frame.size.height+10;
    [mDockMenuBackView_InvestDetails setFrame:rect];
    [mDockMenuBackView_InvestDetails addSubview:label];
    [mDockMenuBackView_InvestDetails setHidden:YES];
    
}

//点击dockMenuItem后切换视图
-(void) ChangeDockMenuSubViews:(int) currentIndex
{
    switch (currentIndex) {
        case 0:
        {
            if (mDockMenuBackView_BrandPrice != nil && ![mDockMenuBackView_BrandPrice isHidden]) {
                [mDockMenuBackView_BrandPrice setHidden:YES withDirection:NO];
            }
            if (mDockMenuBackView_InvestDetails != nil && ![mDockMenuBackView_InvestDetails isHidden]) {
                [mDockMenuBackView_InvestDetails setHidden:YES withDirection:NO];
            }
            if (mDockMenuBackView_ProductDisplay != nil && [mDockMenuBackView_ProductDisplay isHidden]) {
                [mDockMenuBackView_ProductDisplay setHidden:NO withDirection:NO];
//                [mScrollView setContentSize:CGSizeMake(320, mDockMenuBackView_ProductDisplay.frame.origin.y+mDockMenuBackView_ProductDisplay.frame.size.height)];
            }
        }
            break;
        case 1:
        {
            if (mDockMenuBackView_ProductDisplay != nil && ![mDockMenuBackView_ProductDisplay isHidden]) {
                [mDockMenuBackView_ProductDisplay setHidden:YES withDirection:YES];
                
                if (mDockMenuBackView_BrandPrice != nil) {
                    [mDockMenuBackView_BrandPrice setHidden:NO withDirection:YES];
//                    [mScrollView setContentSize:CGSizeMake(320, mDockMenuBackView_BrandPrice.frame.origin.y+mDockMenuBackView_BrandPrice.frame.size.height)];
                }
            }
            if (mDockMenuBackView_InvestDetails != nil && ![mDockMenuBackView_InvestDetails isHidden]) {
                [mDockMenuBackView_InvestDetails setHidden:YES withDirection:NO];
                
                if (mDockMenuBackView_BrandPrice != nil) {
                    [mDockMenuBackView_BrandPrice setHidden:NO withDirection:NO];
//                    [mScrollView setContentSize:CGSizeMake(320, mDockMenuBackView_BrandPrice.frame.origin.y+mDockMenuBackView_BrandPrice.frame.size.height)];
                }
            }
            
        }
            break;
        case 2:
        {
            if (mDockMenuBackView_ProductDisplay != nil && ![mDockMenuBackView_ProductDisplay isHidden]) {
                [mDockMenuBackView_ProductDisplay setHidden:YES withDirection:YES];
            }
            if (mDockMenuBackView_BrandPrice != nil && ![mDockMenuBackView_BrandPrice isHidden]) {
                [mDockMenuBackView_BrandPrice setHidden:YES withDirection:YES];
            }
            if (mDockMenuBackView_InvestDetails != nil && [mDockMenuBackView_InvestDetails isHidden]) {
                [mDockMenuBackView_InvestDetails setHidden:NO withDirection:YES];
//                  [mScrollView setContentSize:CGSizeMake(320, mDockMenuBackView_InvestDetails.frame.origin.y+mDockMenuBackView_InvestDetails.frame.size.height)];
            }
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////搜索栏的回调函数
//
////点击键盘上的搜索按钮时的调用
//-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    NSString *searchtext = searchBar.text;
//    [searchBar resignFirstResponder];
//    //开始搜索
//}
////输入文本实时更新时的调用，
//-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    
//}
////cancel按钮点击时调用
//-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//}
////点击搜索框时调用
//-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    
//}
@end
