//
//  UserPageViewController.h
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/30.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserPageViewController : UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

- (void) setIndex:(NSInteger) index;
@property(nonatomic) NSInteger current_index;

@end

NS_ASSUME_NONNULL_END
