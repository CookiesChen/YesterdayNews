//
//  LoginViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "LoginViewController.h"
#import "../UserInfoViewController.h"
#define ZXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController ()

@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UILabel *loginTitleLabel;
@property(nonatomic, strong) UITextField *emailInput;
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
    // email
    [self.view addSubview:self.emailInput];
    // password
    [self.view addSubview:self.passwordInput];
    // login button
    [self.view addSubview:self.loginButton];
}

- (void) LoginButtonClick:(id)sender {
    [(UserInfoViewController *)self.parentViewController hideLoginPageAnimation];
    [(UserInfoViewController*)self.parentViewController showUserInfoAnimation];
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

- (UITextField *)emailInput {
    if(_emailInput == nil){
        _emailInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width - 100, 35)];
        _emailInput.borderStyle = UITextBorderStyleRoundedRect;
        _emailInput.font = [UIFont systemFontOfSize:14];
        _emailInput.layer.cornerRadius = 17.5;
        _emailInput.layer.masksToBounds = YES;
        [_emailInput.layer setBorderWidth:1];
        [_emailInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        _emailInput.placeholder = @"    邮箱";
    }
    return _emailInput;
}

- (UITextField *)passwordInput {
    if(_passwordInput == nil){
        _passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, self.view.frame.size.width - 100, 35)];
        _passwordInput.borderStyle = UITextBorderStyleRoundedRect;
        _passwordInput.font = [UIFont systemFontOfSize:14];
        _passwordInput.layer.cornerRadius = 17.5;
        _passwordInput.layer.masksToBounds = YES;
        [_passwordInput.layer setBorderWidth:1];
        [_passwordInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        _passwordInput.placeholder = @"    密码";
    }
    return _passwordInput;
}

- (UIButton *)loginButton {
    if(_loginButton == nil){
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 280, self.view.frame.size.width - 100, 35)];
        [_loginButton setTitle:@"秘技----一键登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _loginButton.backgroundColor = ZXColorFromRGB(0xf38181);
        _loginButton.layer.cornerRadius = 17.5;
        [_loginButton addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

@end
