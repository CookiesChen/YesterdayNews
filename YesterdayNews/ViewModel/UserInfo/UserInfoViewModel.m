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

#pragma mark - life cycle
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
    [self setDefaultValue];
    [self bindOperationType];
}

#pragma mark - private
- (void)bindOperationType {
    [RACObserve(self, operationType) subscribeNext:^(id  _Nullable x) {
        OperationType operationType = (OperationType)[x integerValue];
        switch (operationType) {
            case LOGIN:
                self.hideLoginView = YES;
                self.hideSignupView = NO;
                break;
            case SIGNUP:
                self.hideLoginView = NO;
                self.hideSignupView = YES;
                break;
            default:
                break;
        }
    }];
}


- (void)setDefaultValue {
    self.operationType = LOGIN;
}

@end
