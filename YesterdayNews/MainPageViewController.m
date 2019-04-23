//
//  MainPageViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "MainPageViewController.h"
#import "ViewModel/MainPageViewModel.h"
#import "ViewController/HomePage/HomePageViewController.h"
#import "ViewController/UserInfo/UserInfoViewController.h"

#import <ReactiveObjC.h>
#import <Colours.h>

#define WINDOW_HEIGHT self.view.frame.size.height
#define WINDOW_WIDTH self.view.frame.size.width

@interface MainPageViewController ()

@property(nonatomic, strong) HomePageViewController *homeVC;
@property(nonatomic, strong) UserInfoViewController *userVC;

@property(nonatomic, strong) MainPageViewModel *ViewModel;
@property(nonatomic) NSInteger bar_height;

@end

@implementation MainPageViewController

/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];

    [self createViewController];
    [self setupView];
    [self bindViewModel];
}

- (void)viewDidLayoutSubviews {
    [self.tabBar setFrame: CGRectMake(0, WINDOW_HEIGHT-self.bar_height, WINDOW_WIDTH, self.bar_height)];
}


/* -- progma mark - private methods -- */
// 初始化
- (instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.bar_height = 75;
}

// vc创建
- (void)createViewController {
    self.homeVC = [[HomePageViewController alloc] init];
    self.userVC = [[UserInfoViewController alloc] init];
    self.viewControllers = @[_homeVC, _userVC];
}

// UI布局
- (void)setupView {
    [self initTabBar];
}

// viewmodel绑定
- (void)bindViewModel {
    self.ViewModel = [[MainPageViewModel alloc] init];
}


/* -- progma mark - Delegate -- */


/* -- progma mark - getters and setters -- */
- (void )initTabBar {
    UITabBar *bar = self.tabBar;
    NSArray *titles = @[@"首页", @"我的"];
    NSArray *images = @[@"icon_home.png", @"icon_user.png"];
    
    // 未选中状态
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    attr[NSForegroundColorAttributeName] = [UIColor black75PercentColor];
    // 已选中状态
    NSMutableDictionary *selectAttr = [NSMutableDictionary dictionary];
    selectAttr[NSForegroundColorAttributeName] = [UIColor infoBlueColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
    
    [self setTabBarItem: item];
    
    int index = 0;
    for(UITabBarItem *item in bar.items) {
        [item setTitle: titles[index]];
        item.titlePositionAdjustment = UIOffsetMake(0, 20);
        [item setImage: [UIImage imageNamed:images[index]]];
        [item setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
        index++;
    }
}

@end
