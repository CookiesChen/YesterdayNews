//
//  UserInfoViewModel.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "UserInfoViewModel.h"

@interface UserInfoViewModel ()

@end

@implementation UserInfoViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.login = [RACSubject subject];
    self.logout = [RACSubject subject];
}

- (void)userLogin {
    [self.login sendNext:@"success"];
    NSLog(@"[user login] success");
}

- (void)userLogout {
    [self.logout sendNext:@"success"];
    NSLog(@"[user logout] success");
}

@end
