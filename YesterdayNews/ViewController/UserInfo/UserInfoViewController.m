//
//  UserInfoViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoViewController.h"
#import "ProfileViewController.h"


@interface UserInfoViewController ()



@end

@implementation UserInfoViewController

- (instancetype)init {
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    return [self initWithRootViewController:profile];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


@end
