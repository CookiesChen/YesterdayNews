//
//  LoginViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "LoginViewController.h"
#import "../UserInfoViewController.h"
#import "../../../Model/User/User.h"
#import "../../../Utils/ManagerUtils/ViewModelManager.h"
#import <Colours.h>
#import <AFNetworking.h>
#import "YBImageBrowserTipView.h"

#define ZXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController ()

@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UILabel *loginTitleLabel;
@property(nonatomic, strong) UITextField *usernameInput;
@property(nonatomic, strong) UITextField *passwordInput;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // label
    [self.view addSubview: self.loginTitleLabel];
    // username
    [self.view addSubview:self.usernameInput];
    // password
    [self.view addSubview:self.passwordInput];
    // login button
    [self.view addSubview:self.loginButton];
}

- (void) LoginButtonClick:(id)sender {
    NSString *username = self.usernameInput.text;
    NSString *password = self.passwordInput.text;
    
    if([username isEqualToString:@""] || [password isEqualToString:@""]) {
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"信息不完整"];
        return;
    }
    
    NSString *url = @"http://localhost:3000/user/login";
    NSDictionary *parameters = @{@"username": username,
                                 @"password": password};
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        User *user = [User getInstance];
        [user setUsername:username];
        [user setToken: responseObject[@"token"]];
        user.hasLogin = true;
        NSLog(@"[login] success");
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:[NSString stringWithFormat:@"欢迎回来, %@", username]];
        [[[ViewModelManager getManager] getViewModel:@"UserInfoViewModel"] userLogin];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        // 弹出提示框 用户名或密码错误
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"用户名或密码错误"];
        NSLog(@"%@", response[@"message"]);
    }];
}

# pragma getter and setter
- (UILabel *)loginTitleLabel {
    if(_loginTitleLabel == nil){
        _loginTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
        _loginTitleLabel.textColor = [UIColor blackColor];
        _loginTitleLabel.textAlignment = NSTextAlignmentCenter;
        _loginTitleLabel.font = [UIFont systemFontOfSize:20];
        [_loginTitleLabel setText:@"登陆你的头条，掌握昨日信息"];
    }
    return _loginTitleLabel;
}

- (UITextField *)usernameInput {
    if(_usernameInput == nil){
        _usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width - 100, 35)];
        _usernameInput.borderStyle = UITextBorderStyleRoundedRect;
        _usernameInput.font = [UIFont systemFontOfSize:14];
        _usernameInput.layer.cornerRadius = 17.5;
        _usernameInput.layer.masksToBounds = YES;
        [_usernameInput.layer setBorderWidth:1];
        [_usernameInput setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_usernameInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_usernameInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_usernameInput setAttributedPlaceholder: attri];
        [_usernameInput setAttributedPlaceholder: attri];
        [_usernameInput setTextAlignment: NSTextAlignmentCenter];
    }
    return _usernameInput;
}

- (UITextField *)passwordInput {
    if(_passwordInput == nil){
        _passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, self.view.frame.size.width - 100, 35)];
        _passwordInput.borderStyle = UITextBorderStyleRoundedRect;
        _passwordInput.font = [UIFont systemFontOfSize:14];
        _passwordInput.layer.cornerRadius = 17.5;
        _passwordInput.layer.masksToBounds = YES;
        [_passwordInput.layer setBorderWidth:1];
        [_passwordInput setAutocorrectionType:UITextAutocorrectionTypeNo];
        [_passwordInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [_passwordInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_passwordInput setAttributedPlaceholder: attri];
        [_passwordInput setTextAlignment: NSTextAlignmentCenter];
    }
    return _passwordInput;
}

- (UIButton *)loginButton {
    if(_loginButton == nil){
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 280, self.view.frame.size.width - 100, 35)];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_loginButton setBackgroundColor: [UIColor infoBlueColor]];
        
        [_loginButton.layer setCornerRadius: 17.5];
        [_loginButton addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
