//
//  SettingViewController.h
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/24.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../ViewModel/UserInfo/UserInfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController : UIViewController

@property (strong, nonatomic) UserInfoViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
