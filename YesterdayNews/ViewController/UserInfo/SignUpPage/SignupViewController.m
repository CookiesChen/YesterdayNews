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
#define ZXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SignupViewController ()

@property(nonatomic, strong) UIButton *signupButton;
@property(nonatomic, strong) UILabel *signupTitleLabel;
@property(nonatomic, strong) UITextField *usernameInput;
@property(nonatomic, strong) UITextField *passwordInput;
@property(nonatomic, strong) UITextField *passwordInput2;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // label
    self.signupTitleLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:20];
        [label setText:@"♂♂注册页♂♂"];
        label;
    });
    [self.view addSubview:self.signupTitleLabel];
    
    // name
    self.usernameInput = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font = [UIFont systemFontOfSize:14];
        tf.layer.cornerRadius = 17.5;
        tf.layer.masksToBounds = YES;
        [tf.layer setBorderWidth:1];
        [tf.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"用户名" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [tf setAttributedPlaceholder: attri];
        [tf setAttributedPlaceholder: attri];
        [tf setTextAlignment: NSTextAlignmentCenter];
        tf;
    });
    [self.view addSubview:self.usernameInput];
    
    // password
    self.passwordInput = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font = [UIFont systemFontOfSize:14];
        tf.layer.cornerRadius = 17.5;
        tf.layer.masksToBounds = YES;
        [tf.layer setBorderWidth:1];
        [tf.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [tf setAttributedPlaceholder: attri];
        [tf setAttributedPlaceholder: attri];
        [tf setTextAlignment: NSTextAlignmentCenter];
        tf;
    });
    [self.view addSubview:self.passwordInput];
    
    // password
    self.passwordInput2 = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 280, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font = [UIFont systemFontOfSize:14];
        tf.layer.cornerRadius = 17.5;
        tf.layer.masksToBounds = YES;
        [tf.layer setBorderWidth:1];
        [tf.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:@"确认密码" attributes:@{NSForegroundColorAttributeName:[UIColor black50PercentColor], NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:style}];
        [tf setAttributedPlaceholder: attri];
        [tf setAttributedPlaceholder: attri];
        [tf setTextAlignment: NSTextAlignmentCenter];
        tf;
    });
    [self.view addSubview:self.passwordInput2];
    
    // sign up button
    self.signupButton = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, self.view.frame.size.width - 100, 35)];
        [btn setTitle:@"秘技----注册" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor infoBlueColor];
        btn.layer.cornerRadius = 17.5;
        btn;
    });
    [self.signupButton addTarget:self action:@selector(SignupButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signupButton];
}

- (void) SignupButtonClick:(id)sender {
    NSString *username = self.usernameInput.text;
    NSString *password = self.passwordInput.text;
    NSString *url = @"http://localhost:3000/user/signup";
    NSDictionary *parameters = @{@"username": username,
                                 @"password": password};
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        // TODO
        // 弹出提示框 提醒用户返回去登录
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        NSLog(@"%@", response[@"message"]);
    }];
//    [(UserInfoViewController *)self.parentViewController hideLoginPageAnimation];
//    [(UserInfoViewController *)self.parentViewController showUserInfoAnimation];
}


@end
