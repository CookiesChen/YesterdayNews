//
//  SignupViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "SignupViewController.h"
#import "../UserInfoViewController.h"
#import <AFNetworking.h>
#import <Colours.h>
#import "YBImageBrowserTipView.h"
#define ZXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SignupViewController ()

@property(nonatomic, strong) UIButton *signupButton;
@property(nonatomic, strong) UILabel *signupTitleLabel;
@property(nonatomic, strong) UITextField *usernameInput;
@property(nonatomic, strong) UITextField *passwordInput;
@property(nonatomic, strong) UITextField *passwordInput2;
@property(nonatomic, strong) UITextField *phoneInput;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.signupTitleLabel];
    [self.view addSubview:self.usernameInput];
    [self.view addSubview:self.passwordInput];
    [self.view addSubview:self.phoneInput];
    [self.view addSubview:self.signupButton];
}

- (void) SignupButtonClick:(id)sender {
    NSString *username = self.usernameInput.text;
    NSString *password = self.passwordInput.text;
    NSString *telephone = self.phoneInput.text;
    
    if([username isEqualToString:@""] || [password isEqualToString:@""] || [telephone isEqualToString:@""]) {
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"信息不完整"];
        return;
    }
    
    NSString *url = @"http://localhost:3000/user/signup";
    NSDictionary *parameters = @{@"username": username,
                                 @"password": password,
                                 @"telephone": telephone};
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        // 弹出提示框 提醒用户返回去登录
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"注册成功，请前往登录页面"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        NSLog(@"---------%@", error);
        NSLog(@"%@", response[@"message"]);
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:response[@"message"]];
    }];
//    [(UserInfoViewController *)self.parentViewController hideLoginPageAnimation];
//    [(UserInfoViewController *)self.parentViewController showUserInfoAnimation];
}

# pragma getter and setter
- (UILabel *)signupTitleLabel {
    if(_signupTitleLabel == nil) {
        _signupTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
        _signupTitleLabel.textColor = [UIColor blackColor];
        _signupTitleLabel.textAlignment = NSTextAlignmentCenter;
        _signupTitleLabel.font = [UIFont systemFontOfSize:20];
        [_signupTitleLabel setText:@"♂♂注册页♂♂"];
    }
    return _signupTitleLabel;
}

- (UIButton *)signupButton {
    if(_signupButton == nil) {
        _signupButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, self.view.frame.size.width - 100, 35)];
        [_signupButton setTitle:@"秘技----注册" forState:UIControlStateNormal];
        _signupButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _signupButton.backgroundColor = [UIColor infoBlueColor];
        _signupButton.layer.cornerRadius = 17.5;
        [_signupButton addTarget:self action:@selector(SignupButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signupButton;
}

- (UITextField *)usernameInput {
    if(_usernameInput == nil) {
        _usernameInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width - 100, 35)];
        _usernameInput.borderStyle = UITextBorderStyleRoundedRect;
        _usernameInput.font = [UIFont systemFontOfSize:14];
        _usernameInput.layer.cornerRadius = 17.5;
        _usernameInput.layer.masksToBounds = YES;
        [_usernameInput.layer setBorderWidth:1];
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

- (UITextField *)phoneInput {
    if(_phoneInput == nil) {
        _phoneInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 280, self.view.frame.size.width - 100, 35)];
        _phoneInput.borderStyle = UITextBorderStyleRoundedRect;
        _phoneInput.font = [UIFont systemFontOfSize:14];
        _phoneInput.layer.cornerRadius = 17.5;
        _phoneInput.layer.masksToBounds = YES;
        [_phoneInput.layer setBorderWidth:1];
        [_phoneInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"电话" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_phoneInput setAttributedPlaceholder: attri];
        [_phoneInput setAttributedPlaceholder: attri];
        [_phoneInput setTextAlignment: NSTextAlignmentCenter];
    }
    return _phoneInput;
}

- (UITextField *)passwordInput {
    if(_passwordInput == nil) {
        _passwordInput = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, self.view.frame.size.width - 100, 35)];
        _passwordInput.borderStyle = UITextBorderStyleRoundedRect;
        _passwordInput.font = [UIFont systemFontOfSize:14];
        _passwordInput.layer.cornerRadius = 17.5;
        _passwordInput.layer.masksToBounds = YES;
        [_passwordInput.layer setBorderWidth:1];
        [_passwordInput.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_passwordInput setAttributedPlaceholder: attri];
        [_passwordInput setAttributedPlaceholder: attri];
        [_passwordInput setTextAlignment: NSTextAlignmentCenter];
    }
    return _passwordInput;
}

- (UITextField *)passwordInput2 {
    if(_passwordInput2 == nil) {
        _passwordInput2 = [[UITextField alloc] initWithFrame:CGRectMake(50, 280, self.view.frame.size.width - 100, 35)];
        _passwordInput2.borderStyle = UITextBorderStyleRoundedRect;
        _passwordInput2.font = [UIFont systemFontOfSize:14];
        _passwordInput2.layer.cornerRadius = 17.5;
        _passwordInput2.layer.masksToBounds = YES;
        [_passwordInput2.layer setBorderWidth:1];
        [_passwordInput2.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [_passwordInput2 setAttributedPlaceholder: attri];
        [_passwordInput2 setAttributedPlaceholder: attri];
        [_passwordInput2 setTextAlignment: NSTextAlignmentCenter];
    }
    return _passwordInput;
}


@end
