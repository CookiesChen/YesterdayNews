//
//  ProfileViewModel.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/1.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef ProfileViewModel_h
#define ProfileViewModel_h

#import "../../../Model/User/User.h"
#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface ProfileViewModel : NSObject

@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *like;
@property(nonatomic, strong) NSString *following;
@property(nonatomic, strong) NSString *follower;

@end

#endif /* ProfileViewModel_h */
