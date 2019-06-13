//
//  User.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/17.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef User_h
#define User_h

#import <Foundation/Foundation.h>

@interface User : NSObject

+ (User *)getInstance;
- (void)setUsername:(NSString *)username;
- (void)setToken:(NSString *)token;
- (NSString *)getUsername;
- (NSString *)getToken;

@property(nonatomic, assign) BOOL hasLogin;

@end

#endif /* User_h */
