//
//  SubmitOrderViewController.m
//  CLWsdht
//
//  Created by tom on 16/1/28.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "SubmitOrderViewController.h"
#import "ChosePlaceViewController.h"
#import "repairCarStoreViewController.h"
@interface SubmitOrderViewController (){

    UILabel *number;//配件数量
    NSInteger a;//配件数量
}
@end

@implementation SubmitOrderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//白色
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//退出当前ViewController后变回黑色
}

- (void)viewDidLoad {
    [super viewDidLoad];
    a=1;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //控制器位置
    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    backView.backgroundColor=[UIColor blackColor];
    [self.view addSubview:backView];
    //返回按钮
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(20 ,20,44,44)];
    back.backgroundColor=[UIColor clearColor];
    
    [back setTitle:@"<" forState:UIControlStateNormal];
    
    back.titleLabel.font=[UIFont systemFontOfSize:30];
    [back setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [back setTitleColor:[UIColor whiteColor] forState: UIControlStateHighlighted];
    
    [back addTarget:self action:@selector(backClickde) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:back];
//11111111111收货地址部分
    UIView *placeView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,(self.view.frame.size.height-114)*1/6 )];
    placeView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:244/255.0];
    [self.view addSubview:placeView];
    //收货地址
    UILabel *placeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4 ,(self.view.frame.size.height-114)/24,self.view.frame.size.width/2,(self.view.frame.size.height-114)/12)];
    placeLabel.backgroundColor=[UIColor clearColor];
    placeLabel.text=@"暂无收获地址请点击添加";
    placeLabel.font=[UIFont systemFontOfSize:16];
    placeLabel.textColor=[UIColor lightGrayColor];
    [placeView addSubview:placeLabel];
    //收货地址textView
    UITextView *placeTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, 10, self.view.frame.size.width-40, (self.view.frame.size.height-114)*1/6-20)];
    placeTextView.backgroundColor=[UIColor clearColor];
    [placeTextView setEditable:NO];
    [placeView addSubview:placeTextView];
    //收货地址按钮
    UIButton *placeButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4 ,(self.view.frame.size.height-114)/24-10,self.view.frame.size.width/4-20,(self.view.frame.size.height-114)/12)];
    placeButton.backgroundColor=[UIColor clearColor];
    [placeButton setTitle:@">" forState:UIControlStateNormal];
    [placeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [placeButton setTitleColor:[UIColor redColor] forState: UIControlStateHighlighted];
    
    [placeButton addTarget:self action:@selector(placeClickde) forControlEvents:(UIControlEventTouchUpInside)];
    [placeTextView addSubview:placeButton];
//22222222222配件数量部分
    UIView *partsNumberView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+(self.view.frame.size.height-114)*1/6, self.view.frame.size.width,(self.view.frame.size.height-114)*1/12 )];
    partsNumberView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:partsNumberView];
    //配件数量label
    UILabel *partsNumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0,100,(self.view.frame.size.height-114)*1/12 )];
    partsNumberLabel.text=@"配件数量";
    partsNumberLabel.backgroundColor=[UIColor whiteColor];
    [partsNumberView addSubview:partsNumberLabel];
    //计数器背景
    UIView *backView1=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-165, 6, 140,(self.view.frame.size.height-114)*1/12-12 )];
    backView1.backgroundColor=[UIColor lightGrayColor];
    backView1.layer.masksToBounds = YES;
    backView1.layer.cornerRadius = 8;
    [partsNumberView addSubview:backView1];
    UIView *backView2=[[UIView alloc]initWithFrame:CGRectMake(1, 1, 138,(self.view.frame.size.height-114)*1/12-12-2)];
    backView2.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:244/255.0];
    backView2.layer.masksToBounds = YES;
    backView2.layer.cornerRadius = 8;
    [backView1 addSubview:backView2];
    UIView *backView3=[[UIView alloc]initWithFrame:CGRectMake(35, 1, 1,(self.view.frame.size.height-114)*1/12-12-2)];
    backView3.backgroundColor=[UIColor lightGrayColor];
    [backView1 addSubview:backView3];
    UIView *backView4=[[UIView alloc]initWithFrame:CGRectMake(105, 1, 1,(self.view.frame.size.height-114)*1/12-12-2)];
    backView4.backgroundColor=[UIColor lightGrayColor];
    [backView1 addSubview:backView4];
    //配件具体数量
   number=[[UILabel alloc]initWithFrame:CGRectMake(36, 1,68,(self.view.frame.size.height-114)*1/12-16 )];
    number.text=@"1";
    number.textAlignment=NSTextAlignmentCenter;
    number.backgroundColor=[UIColor clearColor];
    [backView2 addSubview:number];
    //减号按钮
    UIButton *subButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 1,35,(self.view.frame.size.height-114)*1/12-16 )];
    subButton.backgroundColor=[UIColor clearColor];
    [subButton setTitle:@"—" forState:UIControlStateNormal];
    [subButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [subButton setTitleColor:[UIColor redColor] forState: UIControlStateHighlighted];
    [subButton addTarget:self action:@selector(subClickde) forControlEvents:(UIControlEventTouchUpInside)];
    [backView2 addSubview:subButton];
    //加号按钮
    UIButton *addButton=[[UIButton alloc]initWithFrame:CGRectMake(105, 1,35,(self.view.frame.size.height-114)*1/12-16 )];
    addButton.backgroundColor=[UIColor clearColor];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor redColor] forState: UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(addClickde) forControlEvents:(UIControlEventTouchUpInside)];
    [backView2 addSubview:addButton];

//33333333333具体要求
    UIView *needView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+(self.view.frame.size.height-114)*3/12, self.view.frame.size.width,(self.view.frame.size.height-114)/3 )];
    needView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:needView];
    //具体要求label
    UILabel *needLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,(self.view.frame.size.height-114)/12)];
    needLabel.text=@"     具体要求";
    needLabel.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:244/255.0];
    [needView addSubview:needLabel];
    //具体要求提示
    UILabel *Label=[[UILabel alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height-114)/12, self.view.frame.size.width-20,(self.view.frame.size.height-114)/12)];
    Label.text=@"请你填写对商品的具体要求..";
    Label.backgroundColor=[UIColor clearColor];
    Label.textColor=[UIColor grayColor];
    Label.font=[UIFont systemFontOfSize:15];
    [needView addSubview:Label];
    
    //要求textfield
    UITextView *needTextView=[[UITextView alloc]initWithFrame:CGRectMake(0, 64+(self.view.frame.size.height-114)*4/12,self.view.frame.size.width,(self.view.frame.size.height-114)*3/12 )];
    needTextView.backgroundColor=[UIColor whiteColor];
    [needView addSubview:needTextView];
    
//4444444444提示部分
    UIView *promptView=[[UIView alloc]initWithFrame:CGRectMake(0, 64+(self.view.frame.size.height-114)*7/12, self.view.frame.size.width,(self.view.frame.size.height-114)*5/12)];
    promptView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:244/255.0];
    [self.view addSubview:promptView];
    NSArray *promptArray=@[@"提示",@"1.购买前请联系商家确定价格",@"2.提交订单后需要等待商家确定价格",@"3.商家确定价格后即可确定支付"];
    for (NSInteger i=0; i<4; i++) {
        UILabel *promptLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 20+20*i, self.view.frame.size.width-20,30)];
        promptLabel.text=promptArray[i];
        promptLabel.textColor=[UIColor grayColor];
        promptLabel.font=[UIFont systemFontOfSize:13];
        promptLabel.backgroundColor=[UIColor clearColor];
        [promptView addSubview:promptLabel];
    }
    //提示textView
    UITextView *prompTextView=[[UITextView alloc]initWithFrame:CGRectMake(20, (self.view.frame.size.height-114)*3/12, self.view.frame.size.width-40, (self.view.frame.size.height-114)*2/12)];
    prompTextView.backgroundColor=[UIColor clearColor];
    prompTextView.text=@"发布订单后，修理厂可以抢单，你可以在抢单的修理厂中挑选你认可的修理厂进行配件更换";
    prompTextView.textColor=[UIColor grayColor];

    [prompTextView setEditable:NO];
    [promptView addSubview:prompTextView];
//555555555选择修理厂，提交订单
    NSArray *array11=@[@"选择修理厂",@"提交订单"];
    for (NSInteger i=0; i<2; i++) {
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-250+(120)*i,self.view.frame.size.height-50+1,110,48 )];
        button.backgroundColor=[UIColor colorWithRed:253/255.0 green:182/255.0 blue:187/255.0 alpha:1];
        [button setTitle:array11[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState: UIControlStateHighlighted];
        [button addTarget:self action:@selector(btnClickde:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag=10000+i;
        [self.view addSubview:button];
    }
    
}
#pragma mark--选择修理厂 提交订单
- (void)btnClickde:(UIButton *)btn{
    if (btn.tag==10000) {
        repairCarStoreViewController *repairCarStoreVC=[[repairCarStoreViewController alloc]init];
        [self presentViewController:repairCarStoreVC animated:YES completion:^{
            
        }];
    }
    
    
}
#pragma mark--减号按钮
- (void)subClickde{
    
    
    if (a>1) {
        a--;
        number.text= [NSString stringWithFormat: @"%ld", (long)a];
    }
    else{
        number.text=@"1";
    }
    
}
#pragma mark--加号按钮
- (void)addClickde{
    a++;
   
        number.text= [NSString stringWithFormat: @"%ld", (long)a];
    
}

#pragma mark--返回按钮
- (void)backClickde{
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}
#pragma mark--选择地址
- (void)placeClickde{
    ChosePlaceViewController *chosePlaceVC=[[ChosePlaceViewController alloc]init];
    [self presentViewController:chosePlaceVC animated:YES completion:^{
        
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
