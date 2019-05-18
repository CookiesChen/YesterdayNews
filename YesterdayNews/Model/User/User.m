//
//  User.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/17.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "User.h"

static User *user = nil;
@interface User()

@end

@implementation User

+ (User *)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    return user;
}

@end
