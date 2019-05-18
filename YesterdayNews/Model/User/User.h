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

@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSString *password;

+ (User *)getInstance;

@end

#endif /* User_h */
