//
//  PageViewController.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController: UIPageViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic) NSInteger current_index;

- (void) setIndex:(NSInteger) index;
- (instancetype)initWithFrame:(CGRect)frame;

@end
