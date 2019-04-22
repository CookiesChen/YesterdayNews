//
//  PageViewController.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController: UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

- (void) setIndex:(NSInteger) index;
@property(nonatomic) NSInteger current_index;

@end
