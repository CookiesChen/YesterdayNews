//
//  MainPageViewModel.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../ViewController/HomePage/HomePageViewController.h"
#import "../ViewController/UserInfo/UserInfoViewController.h"

@interface MainPageViewModel : NSObject

@property(nonatomic, strong) HomePageViewController *homeVC;
@property(nonatomic, strong) UserInfoViewController *userVC;

@end
