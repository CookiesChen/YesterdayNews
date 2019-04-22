//
//  HomePageViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "HomePageViewController.h"
#import "NavigationBarViewController.h"
#import "PageViewController.h"
#import "../../ViewModel/HomePage/HomePageViewModel.h"
#import <Colours.h>
#import <ReactiveObjC.h>

#define WINDOW_HEIGHT self.view.frame.size.height
#define WINDOW_WIDTH self.view.frame.size.width

@interface HomePageViewController () 

@property(nonatomic, strong) HomePageViewModel *ViewModel;
@property(nonnull, nonatomic) PageViewController *pageVC;
@property(nonnull, nonatomic) NavigationBarViewController *navbarVC;
@property(nonatomic, strong) UICollectionView *tabBar;
@property(nonatomic, strong) NSArray *tabs;
@property(nonatomic) NSInteger tab_height;
@property(nonatomic) NSInteger margin_top;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createViewController];
    [self setupView];
    [self bindViewModel];
}

//初始化
- (instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}
- (void)initialize {
    self.tab_height = 45;
    self.margin_top = 70;
}

// vc创建
- (void)createViewController {
    self.pageVC = [[PageViewController alloc] init];
    self.navbarVC = [[NavigationBarViewController alloc] initWithHeight: self.tab_height];
}

// ui布局
- (void)setupView {
    [self.view setBackgroundColor: [UIColor infoBlueColor]];
    
    [self.navbarVC.view setFrame:CGRectMake(0, self.margin_top,
                                            self.view.frame.size.width, self.tab_height)];
    [self.pageVC.view setFrame: CGRectMake(0, self.margin_top+self.tab_height,
                                           WINDOW_WIDTH, WINDOW_HEIGHT-self.tab_height)];
    [self addChildViewController: self.pageVC];
    [self addChildViewController: self.navbarVC];
    [self.view addSubview: self.pageVC.view];
    [self.view addSubview: self.navbarVC.view];
    
}

// viewmodel绑定
- (void)bindViewModel {
    self.ViewModel = [[HomePageViewModel alloc] init];
    
    [RACObserve(self.navbarVC, current_index) subscribeNext:^(NSNumber*  _Nullable x) {
        [self.pageVC setIndex: [x integerValue]];
    }];
}

@end
