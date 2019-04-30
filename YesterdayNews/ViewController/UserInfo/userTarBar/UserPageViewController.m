//
//  UserPageViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/30.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "UserPageViewController.h"
#import "ListViewController.h"

@interface UserPageViewController ()

@property(nonatomic, strong) NSArray *pages;
@property(nonatomic) NSInteger page_num;

@property(nonatomic, strong) ListViewController *collectionVC;
@property(nonatomic, strong) ListViewController *commentVC;
@property(nonatomic, strong) ListViewController *likeVC;
@property(nonatomic, strong) ListViewController *historyVC;
@property(nonatomic, strong) ListViewController *recommendVC;

@end

@implementation UserPageViewController

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
    _page_num = 5;
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

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    //UIViewController *nextVC = [pendingViewControllers firstObject];
    
    //NSInteger index = [self.dataSource indexOfObject:nextVC];
    
    //self->_current_index = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    if (completed) {
        
    }
}

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

- (ListViewController *)collectionVC {
    if(_collectionVC == nil){
        _collectionVC = [[ListViewController alloc] init];
        _collectionVC.pageTitle = @"收藏";
    }
    return _collectionVC;
}

- (ListViewController *)commentVC {
    if(_commentVC == nil){
        _commentVC = [[ListViewController alloc] init];
        _commentVC.pageTitle = @"评论";
    }
    return _commentVC;
}

- (ListViewController *)likeVC {
    if(_likeVC == nil){
        _likeVC = [[ListViewController alloc] init];
        _likeVC.pageTitle = @"点赞";
    }
    return _likeVC;
}

- (ListViewController *)historyVC {
    if(_historyVC == nil){
        _historyVC = [[ListViewController alloc] init];
        _historyVC.pageTitle = @"历史";
    }
    return _historyVC;
}

- (ListViewController *)recommendVC {
    if(_recommendVC == nil){
        _recommendVC = [[ListViewController alloc] init];
        _recommendVC.pageTitle = @"推送";
    }
    return _recommendVC;
}

- (NSArray *)pages{
    if(_pages == nil){
        _pages = @[self.collectionVC, self.commentVC, self.likeVC, self.historyVC, self.recommendVC];
    }
    return _pages;
}

@end
