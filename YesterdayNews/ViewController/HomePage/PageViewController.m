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

@property(nonatomic, strong) RecommendViewController *recommendVC;
@property(nonatomic, strong) HotspotViewController *hotspotVC;

@end

@implementation PageViewController


/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self bindViewModel];
}

/* -- progma mark - private methods -- */
- (void)setupView {
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    [self setIndex: 0];
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
    _current_index = -1;
}

- (void) setIndex:(NSInteger) index{
    if(self.current_index != index){
        NSInteger direction;
        if(self.current_index < index){
            direction = UIPageViewControllerNavigationDirectionForward;
        } else {
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        [self setViewControllers:@[self.pages[index]] direction:direction animated:YES completion:^(BOOL finished){
            self->_current_index = index;
        }];
    }
}

/* -- progma mark - UIPageViewControllerDataSource -- */

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
    NSUInteger index = [self.pages indexOfObject: viewController];
    if(index == self.page_num-1){
        return nil;
    } else {
        return self.pages[index+1];
    }
}

/* -- progma mark - getters and setters -- */

- (RecommendViewController *)recommendVC {
    if(_hotspotVC == nil){
        _recommendVC = [[RecommendViewController alloc] init];
    }
    return _recommendVC;
}

- (HotspotViewController *)hotspotVC {
    if(_hotspotVC == nil){
        _hotspotVC = [[HotspotViewController alloc] init];
    }
    return _hotspotVC;
}

- (NSArray *)pages{
    if(_pages == nil){
        _pages = @[self.recommendVC, self.hotspotVC];
    }
    return _pages;
}

@end
