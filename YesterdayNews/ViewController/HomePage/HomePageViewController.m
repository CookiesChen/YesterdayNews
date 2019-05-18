//
//  HomePageViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "HomePageViewController.h"
#import "PageViewController.h"
#import "../../ViewModel/HomePage/HomePageViewModel.h"
#import <Colours.h>
#import <ReactiveObjC.h>

#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

@interface HomePageViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic) CGRect frame;

@property(nonatomic, strong) HomePageViewModel *ViewModel;
@property(nonnull, nonatomic) PageViewController *pageVC;

@property(nonatomic, strong) UICollectionView *tab_bar;
@property(nonatomic, strong) UIView *bottom_line;
@property(nonatomic, strong) UIView *separator_line;

@property(nonatomic, strong) UIButton *button;

@property(nonatomic, strong) NSArray *tabs;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic) NSInteger current_index;
@property(nonatomic) NSInteger tab_height;
@property(nonatomic) NSInteger tab_width;
@property(nonatomic) NSInteger margin_top;

@end

@implementation HomePageViewController

# pragma mark life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self bindViewModel];
}

# pragma mark private methods
//初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self.frame = frame;
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.margin_top = 75;
    self.tab_height = 45;
    self.tab_width = 100;
    
    self.tabs = @[@"推荐", @"热点"];
    self.identifier = @"tags";
}

// ui布局
- (void)setupView {
    [self.view setBackgroundColor: [UIColor infoBlueColor]];
    [self.view setFrame: self.frame];
    
    [self.view addSubview: self.pageVC.view];
    [self addChildViewController: self.pageVC];
    
    [self.view addSubview: self.tab_bar];
    [self.view addSubview: self.separator_line];
    [self.view addSubview: self.bottom_line];
}

// viewmodel绑定
- (void)bindViewModel {
    self.ViewModel = [[HomePageViewModel alloc] init];
    
}

# pragma mark UICollectionViewDelegate
// 标签数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tabs.count;
}

// 标签
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    
    UIButton *button = [[UIButton alloc] init];
    [button setFrame: CGRectMake(0, 0, self.tab_width, self.tab_height)];
    [button setTitleColor:[UIColor black75PercentColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor infoBlueColor] forState:UIControlStateSelected];
    [button setTitle:self.tabs[indexPath.row] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setBackgroundColor: [UIColor whiteColor]];
    // 点击事件
    [[button rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        // 修改标签状态
        [self.button setSelected: NO];
        [x setSelected: YES];
        self.button = x;
        
        self.current_index = indexPath.row;
        [self.pageVC setIndex: self.current_index];
        // 动画
        [UIView animateWithDuration:0.1 animations:^{
            [self.bottom_line setCenter: CGPointMake((indexPath.row*100)+50, self.margin_top+self.tab_height)];
        }];
    }];
    if(indexPath.row == 0){
        [button setSelected: YES];
        self.button = button;
    }
    [cell addSubview: button];
    
    return cell;
}

// cell间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

# pragma mark getters and setters
- (PageViewController *)pageVC {
    if(_pageVC == nil){
        _pageVC = [[PageViewController alloc] initWithFrame:CGRectMake(0, self.margin_top+self.tab_height, WIDTH, HEIGHT-self.tab_height-self.margin_top)];
    }
    return _pageVC;
}

- (UICollectionView *)tab_bar {
    if(_tab_bar == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection: UICollectionViewScrollDirectionHorizontal];
        [layout setItemSize: CGSizeMake(self.tab_width, self.tab_height)];
        
        _tab_bar = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.margin_top, WIDTH, self.tab_height) collectionViewLayout:layout];
        [_tab_bar setBackgroundColor: [UIColor whiteColor]];
        [_tab_bar setDelaysContentTouches: NO];
        
        [_tab_bar registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:self.identifier];
        _tab_bar.delegate = self;
        _tab_bar.dataSource = self;
    }
    return _tab_bar;
}

// 分割线
- (UIView *)separator_line {
    if(_separator_line == nil){
        _separator_line = [[UIView alloc] initWithFrame:CGRectMake(0, self.margin_top+self.tab_height, WIDTH, 1)];
        [_separator_line setBackgroundColor:[UIColor wheatColor]];
    }
    return _separator_line;
}

// 底部颜色指示器
- (UIView *)bottom_line {
    if(_bottom_line == nil){
        _bottom_line = [[UIView alloc] initWithFrame:CGRectMake(self.tab_width/4, self.margin_top+self.tab_height-3, self.tab_width/2, 3)];
        [_bottom_line setBackgroundColor:[UIColor infoBlueColor]];
    }
    return _bottom_line;
}

@end
