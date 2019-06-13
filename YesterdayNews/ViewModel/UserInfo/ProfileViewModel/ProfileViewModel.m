//
//  ProfileViewModel.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/1.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ProfileViewModel.h"

@interface ProfileViewModel()

@end

@implementation ProfileViewModel

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
    self.username = [[User getInstance] getUsername];
    self.like = @"1";
    self.following = @"2";
    self.follower = @"3";
}

@end
