//
//  User.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/17.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "User.h"

@interface User()

@property(nonatomic, strong)NSString *username;
@property(nonatomic, strong)NSString *token;

@end

static User *user = nil;
@implementation User

+ (User *)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        if(user == nil) {
            user = [[User alloc] init];
        }
    });
    return user;
}

- (id)init {
    self = [super init];
    if(self) {
        _username = [NSString alloc];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)setUsername:(NSString *)username {
    _username = username;
}

- (void)setToken:(NSString *)token
{
    _token = token;
}

- (NSString *)getUsername {
    return _username;
}

- (NSString *)getToken
{
    return _token;
}

@end
