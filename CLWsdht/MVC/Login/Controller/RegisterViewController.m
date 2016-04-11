//
//  RegisterViewController.m
//  登陆注册模块
//
//  Created by tom on 16/1/7.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserInforViewController.h"
#import "ZHQUtil.h"
#import "UserInfo.h"//用户模型信息

@interface RegisterViewController ()<NSXMLParserDelegate>{
    NSTimer *_timer;//定时器
    NSInteger seconds;//时间
}

@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkTextField;
@property (weak, nonatomic) IBOutlet UIButton *getPassWord;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;//注册按钮

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _getPassWord.layer.cornerRadius = 5;
    _btnRegister.layer.cornerRadius = 5;
}

#pragma mark *** 获取验证码按钮 ***
- (IBAction)getPassWord:(UIButton *)sender {
    if (![MJYUtils mjy_checkTel:_telTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式有误"];
    } else {
        [self getCodeFromNetwork];
    }
    
}




#pragma mark *** 计时器的响应事件 ***
- (void)changeTheTime:(NSTimer *)timer {
    if (seconds > 1) {
        -- seconds; //每次进入减一秒
        [_getPassWord setTitle:[NSString stringWithFormat:@"发送验证码(%ld)", (long)seconds] forState:UIControlStateNormal];
        //设置button是否可以点击，默认是yes
        [_getPassWord setEnabled:NO];
    } else {
        [_getPassWord setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        //设置button是否可以点击
        [_getPassWord setEnabled:YES];
        //关闭并删除计时器
        [_timer invalidate];
        seconds = 60;
    }
}



#pragma mark *** 注册按钮 ***
- (IBAction)registerBtn:(UIButton *)sender {
    
    if (![MJYUtils mjy_checkVerifyCode:_checkTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"验证码格式有误"];
    } else {
        [self postVerityCodeToNetwork];
    }
}


/**
 *  获取验证码
 */
- (void) getCodeFromNetwork
{
    [SVProgressHUD showWithStatus:k_Status_GetVerifyCode];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_get_code];
    
    NSDictionary *paramDict = @{
                                @"mobile":_telTextField.text,
                                @"codeType":@"0"
                                };
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"0"]) {
                //成功返回
                [SVProgressHUD showSuccessWithStatus:@"验证码发送成功"];
                seconds = 60;
                [_getPassWord setTitle:@"发送验证码(60)" forState:UIControlStateNormal];
                //设置计时器
                _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeTheTime:) userInfo:nil repeats:YES];
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
 *  验证验证码
 */
- (void) postVerityCodeToNetwork
{
    [SVProgressHUD showWithStatus:k_Status_VerifyCode];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_auth_StoreLogin];
    
    NSDictionary *paramDict = @{
                                @"mobile":_telTextField.text,
                                @"code":_checkTextField.text
                                };
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [[NSUserDefaults standardUserDefaults] setObject:_telTextField.text forKey:k_UD_username];
                [self getUserInfoToNetwork];
                
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
 *  获取用户信息
 */

- (void) getUserInfoToNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_auth_StoreByMobile];
    
    NSDictionary *paramDict = @{
                                @"mobile":_telTextField.text,
                                };
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSLog(@"%@",jsonDic);
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回
                [SVProgressHUD dismiss];
                
                [[NSUserDefaults standardUserDefaults] setObject:_telTextField.text forKey:k_UD_username];
                UserInfo *userInfo = [[UserInfo alloc] initWithDic:jsonDic[@"Data"]];
                ApplicationDelegate.userInfo = userInfo;
                ApplicationDelegate.isLogin = YES;
                UserInforViewController *vc  = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInforViewController"];
                [self.navigationController pushViewController:vc animated:YES];
                
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
