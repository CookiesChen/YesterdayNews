//
//  UserInfoViewController.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Model/User/User.h"

@interface UserInfoViewController : UIViewController

- (void)hideLoginPageAnimation;
- (void)showLoginPageAnimation;
- (void)showUserInfoAnimation;
- (void)loginWithUser:(User*) user;

@end
