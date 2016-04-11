//
//  LoginViewController.m
//  登陆注册模块
//
//  Created by tom on 16/1/7.
//  Copyright © 2016年 时代宏图. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UserInforViewController.h"//修改用户信息
#import "ZHQUtil.h"
#import "UserInfo.h"//用户模型信息

@interface LoginViewController ()
{
    NSTimer *_timer;//定时器
    NSInteger seconds;//时间
    NSInteger i_times;//验证码按钮点击次数
}

@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UILabel     *passWordLabel;
@property (weak, nonatomic) IBOutlet UIButton    *getPassWord;//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton    *btnChangeLoginWay;//登录方式切换
@property (weak, nonatomic) IBOutlet UIButton    *btnLogin;//登录按钮

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    self.hidesBottomBarWhenPushed = YES;
    
    _telTextField.text = @"13351784891";
    _passWordTextField.text = @"123";
    
    i_times = 0;
    _btnLogin.layer.cornerRadius = 5;
    _getPassWord.layer.cornerRadius = 5 ;
    _getPassWord.hidden = YES;
    
    ApplicationDelegate.loginViewController = self;
}

#pragma mark *** 登陆按钮 ***
- (IBAction)loginBtn:(UIButton *)sender
{
    
    if (![MJYUtils mjy_checkTel:_telTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式有误"];
    } else if (i_times%2 == 1 && ![MJYUtils mjy_checkVerifyCode:_passWordTextField.text]){
        //验证码
        [SVProgressHUD showErrorWithStatus:@"验证码格式有误"];
    } else if (i_times%2 == 0 && [_passWordTextField.text isEqualToString:@""]){
        //密码
        [SVProgressHUD showErrorWithStatus:@"密码格式有误"];
    } else {
        if (i_times%2 == 0) {
            //密码登录
            [self postLoginInfoWithPWDToNetwork];
        } else {
            //验证码登录
            [self postLoginInfoWithCodeToNetwork];
        }
    }
    
}
#pragma mark *** 验证码按钮 ***
- (IBAction)check:(UIButton *)sender
{
    
    i_times++;
    
    if (i_times%2 == 1) {
        _passWordLabel.text = @"验证码";
        _passWordTextField.placeholder = @"请输入验证码";
        _passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
        [_btnChangeLoginWay setTitle:@"密码登录" forState:UIControlStateNormal];
        _getPassWord.hidden = NO;
        
    } else {
        _passWordLabel.text=@"密码";
        _passWordTextField.placeholder = @"请输入密码";
        _passWordTextField.keyboardType = UIKeyboardTypeDefault;
        [_btnChangeLoginWay setTitle:@"验证码登录" forState:UIControlStateNormal];
        _getPassWord.hidden = YES;
        
    }
    
}
#pragma mark *** 获取验证码按钮 ***
- (IBAction)getPassWord:(UIButton *)sender
{
    if (![MJYUtils mjy_checkTel:_telTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式有误"];
    } else {
        [self getCodeFromNetwork];
    }
}
#pragma mark *** 计时器的响应事件 ***
- (void)changeTheTime:(NSTimer *)timer {
    if (seconds > 1) {
        --seconds; //每次进入减一秒
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

#pragma mark *** NetWorking ***

/**
 *  登录(密码登录)
 */
- (void) postLoginInfoWithPWDToNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_auth_StoreLoginByPwd];
    
    NSDictionary *paramDict = @{
                                @"mobile":_telTextField.text,
                                @"pwd":_passWordTextField.text
                                };
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"1"]) {
                //成功返回,获取用户信息
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
 *  登录(验证码)
 */
- (void) postLoginInfoWithCodeToNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_login_code];
    
    NSDictionary *paramDict = @{
                                @"mobile":_telTextField.text,
                                @"code":_passWordTextField.text
                                };
    
    [ApplicationDelegate.httpManager POST:urlStr parameters:paramDict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //http请求状态
        if (task.state == NSURLSessionTaskStateCompleted) {
            NSDictionary *jsonDic = [JYJSON dictionaryOrArrayWithJSONSData:responseObject];
            NSString *status = [NSString stringWithFormat:@"%@",jsonDic[@"Success"]];
            if ([status isEqualToString:@"0"]) {
                //成功返回,获取用户信息
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
 *  获取用户信息
 */

- (void) getUserInfoToNetwork
{
    [SVProgressHUD showWithStatus:k_Status_Load];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BASEURL,k_url_get_userInfo];
    
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
                //返回成功
                [[NSUserDefaults standardUserDefaults] setObject:_telTextField.text forKey:k_UD_username];
                UserInfo *userInfo = [[UserInfo alloc] initWithDic:jsonDic[@"Data"]];
                ApplicationDelegate.userInfo = userInfo;
                ApplicationDelegate.isLogin = YES;
                [self.navigationController popViewControllerAnimated:YES];
                [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                
//                if ([[MJYUtils mjy_fuckNULL:ApplicationDelegate.userInfo.IdNumber] isEqualToString:@""]) {
//                    UserInforViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"UserInforViewController"];
//                    [self.navigationController pushViewController:vc animated:YES];
//                } else {
//                    [self.navigationController popViewControllerAnimated:YES];
//                    [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
//                }
                
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
