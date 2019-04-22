//
//  PageViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "PageViewController.h"
#import "RecommendViewController.h"
#import "HotspotViewController.h"

@interface PageViewController()
{
    
}

@property(nonatomic, strong) NSArray *pages;
@property(nonatomic) NSInteger page_num;

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewController];
    [self setupView];
    [self bindViewModel];
}

- (void)createViewController {
    RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
    HotspotViewController *hotspotVC = [[HotspotViewController alloc] init];
    
    _pages = @[recommendVC, hotspotVC];
}

- (void)setupView {
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    // 初始页
    [self setViewControllers:@[_pages[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.delegate = self;
    self.dataSource = self;
}

- (void)bindViewModel {
    
}

// 初始化
- (instancetype)init
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _page_num = 2;
    _current_index = 0;
}

/* ---代理--- */

// 获取前一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [_pages indexOfObject: viewController];
    if(index == 0){
        return nil;
    } else {
        return _pages[index-1];
    }
}

// 获取后一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [_pages indexOfObject: viewController];
    if(index == _page_num-1){
        return nil;
    } else {
        return _pages[index+1];
    }
}

- (void) setIndex:(NSInteger) index{
    if(_current_index != index){
        if(_current_index < index){
            [self setViewControllers:@[_pages[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished){
                self->_current_index = index;
            }];
        } else {
            [self setViewControllers:@[_pages[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished){
                self->_current_index = index;
            }];
        }
    }
}

@end
