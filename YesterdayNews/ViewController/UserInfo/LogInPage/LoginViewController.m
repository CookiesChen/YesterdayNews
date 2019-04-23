//
//  LoginViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "LoginViewController.h"
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
    self.loginTitleLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        [label setText:@"登陆你的头条，掌握昨日信息"];
        label;
    });
    [self.view addSubview:self.loginTitleLabel];
    
    // email
    self.emailInput = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleLine;
        tf.layer.cornerRadius = 20;
        tf.placeholder = @"邮箱";
        tf;
    });
    [self.view addSubview:self.emailInput];
    
    // password
    self.passwordInput = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleBezel;
        tf.placeholder = @"密码";
        tf;
    });
    [self.view addSubview:self.passwordInput];
    
    // login button
    self.loginButton = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 250, self.view.frame.size.width - 100, 35)];
        [btn setTitle:@"秘技----一键登录" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = ZXColorFromRGB(0xf38181);
        btn.layer.cornerRadius = 17.5;
        btn;
    });
    [self.loginButton addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
}

- (void) LoginButtonClick:(id)sender {
    
}

@end
