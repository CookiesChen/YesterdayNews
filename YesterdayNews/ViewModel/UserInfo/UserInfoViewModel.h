//
//  UserInfoViewModel.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

typedef NS_ENUM(NSInteger,OperationType) {
    LOGIN = 0,
    SIGNUP = 1,
};


@interface UserInfoViewModel: NSObject

// 显示登录还是注册页面
@property (assign, nonatomic) OperationType operationType;
// 登录页面透明度
@property (assign, nonatomic) BOOL hideLoginView;
// 注册页面透明度
@property (assign, nonatomic) BOOL hideSignupView;

@end
