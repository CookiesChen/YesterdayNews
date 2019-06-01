//
//  UserTarBarViewController.h
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../ViewModel/UserInfo/UserInfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserTarBarViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UserInfoViewModel *viewModel;
// page view controller
@property(nonnull, nonatomic) UIPageViewController *pageVC;
// 当前index
@property(nonatomic) NSInteger current_index;
// 子控制器Array
@property(nonatomic, strong) NSArray *pages;
// 切换page, button, current_index
- (void)setCurrentPage:(NSInteger) index;

- (instancetype)initWithViewModel: (UserInfoViewModel*)viewModel;

@end

NS_ASSUME_NONNULL_END
