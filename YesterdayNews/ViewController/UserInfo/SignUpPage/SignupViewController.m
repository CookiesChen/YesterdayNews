//
//  SignupViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "SignupViewController.h"
#import "../ProfileViewController.h"
#define ZXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SignupViewController ()

@property(nonatomic, strong) UIButton *signupButton;
@property(nonatomic, strong) UILabel *signupTitleLabel;
@property(nonatomic, strong) UITextField *nameInput;
@property(nonatomic, strong) UITextField *emailInput;
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
    self.nameInput = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 160, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font = [UIFont systemFontOfSize:14];
        tf.layer.cornerRadius = 17.5;
        tf.layer.masksToBounds = YES;
        [tf.layer setBorderWidth:1];
        [tf.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        tf.placeholder = @"    用户名";
        tf;
    });
    [self.view addSubview:self.nameInput];
    
    // email
    self.emailInput = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 220, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font = [UIFont systemFontOfSize:14];
        tf.layer.cornerRadius = 17.5;
        tf.layer.masksToBounds = YES;
        [tf.layer setBorderWidth:1];
        [tf.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        tf.placeholder = @"    邮箱";
        tf;
    });
    [self.view addSubview:self.emailInput];
    
    // password
    self.passwordInput = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 280, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font = [UIFont systemFontOfSize:14];
        tf.layer.cornerRadius = 17.5;
        tf.layer.masksToBounds = YES;
        [tf.layer setBorderWidth:1];
        [tf.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        tf.placeholder = @"    密码";
        tf;
    });
    [self.view addSubview:self.passwordInput];
    
    // password
    self.passwordInput2 = ({
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(50, 340, self.view.frame.size.width - 100, 35)];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.font = [UIFont systemFontOfSize:14];
        tf.layer.cornerRadius = 17.5;
        tf.layer.masksToBounds = YES;
        [tf.layer setBorderWidth:1];
        [tf.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        tf.placeholder = @"    确认密码";
        tf;
    });
    [self.view addSubview:self.passwordInput2];
    
    // login button
    self.signupButton = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, self.view.frame.size.width - 100, 35)];
        [btn setTitle:@"秘技----注册" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = ZXColorFromRGB(0xf38181);
        btn.layer.cornerRadius = 17.5;
        btn;
    });
    [self.signupButton addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signupButton];
}

- (void) LoginButtonClick:(id)sender {
    [(ProfileViewController*)self.parentViewController hideLoginPageAnimation];
    [(ProfileViewController*)self.parentViewController showUserInfoAnimation];
}


@end
