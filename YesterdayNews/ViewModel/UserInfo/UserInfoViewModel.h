//
//  UserInfoViewModel.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "../../Model/User/User.h"

@interface UserInfoViewModel: NSObject

@property(nonatomic, strong) RACSubject *login;
@property(nonatomic, strong) RACSubject *logout;
//@property(nonatomic, strong) User *currentUser;

- (void)userLogin;
- (void)userLogout;

@end
