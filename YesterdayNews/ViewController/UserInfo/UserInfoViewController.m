//
//  UserInfoViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView{
    [self.view setBackgroundColor: UIColor.whiteColor];
    UILabel *label = [[UILabel alloc] init];
    [label setFrame: CGRectMake(200, 200, 100, 40)];
    [label setText: @"这是个人信息"];
    [label setTextColor: UIColor.blackColor];
    
    [self.view addSubview: label];
}

@end
