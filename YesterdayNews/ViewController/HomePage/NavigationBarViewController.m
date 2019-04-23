//
//  NavigationBarViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/22.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NavigationBarViewController.h"
#import <ReactiveObjC.h>
#import <Colours.h>

@interface NavigationBarViewController() <UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView *tab_bar;
@property(nonatomic, strong) NSArray *tabs;
@property(nonatomic) NSInteger tab_height;

@property(nonatomic, strong) UIView *bottom_line;
@property(nonatomic, strong) UIView *separator_line;
@property(nonatomic, strong) UIButton *button;

@end

@implementation NavigationBarViewController

/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self bindViewModel];
}


/* -- progma mark - private methods -- */
//初始化
- (instancetype)initWithHeight:(NSInteger)height {
    self = [super init];
    if(self){
        self.tab_height = height;
        [self initialize];
    }
    return self;
}
- (void)initialize {
    self.tabs = @[@"推荐", @"热点"];
}

// ui布局
- (void)setupView {
    [self.view setBackgroundColor: [UIColor infoBlueColor]];
    
    [self.view addSubview: self.tab_bar];
    [self.view addSubview: self.separator_line];
    [self.view addSubview: self.bottom_line];
}

// viewmodel绑定
- (void)bindViewModel {
    
}


/* -- progma mark - UICollectionViewDelegate -- */
// 标签数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tabs.count;
}

// 标签
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];

    UIButton *button = [[UIButton alloc] init];
    [button setFrame: CGRectMake(0, 0, 100, self.tab_height)];
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
        // 动画
        [UIView animateWithDuration:0.1 animations:^{
            [self.bottom_line setCenter: CGPointMake(50+(indexPath.row*100), self.tab_height)];
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


/* -- progma mark - getters and setters -- */

// 标签栏
- (UICollectionView *)tab_bar {
    if(_tab_bar == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(100, _tab_height);
        
        _tab_bar = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tab_height) collectionViewLayout:layout];
        [_tab_bar setBackgroundColor: [UIColor whiteColor]];
        [_tab_bar setDelaysContentTouches: NO];
        
        // 注册cell
        [_tab_bar registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        _tab_bar.delegate = self;
        _tab_bar.dataSource = self;
    }
    return _tab_bar;
}

// 分割线
- (UIView *)separator_line {
    if(_separator_line == nil){
        _separator_line = [[UIView alloc] initWithFrame:CGRectMake(0, self.tab_height, self.view.frame.size.width, 1)];
        [_separator_line setBackgroundColor:[UIColor wheatColor]];
    }
    return _separator_line;
}

// 底部颜色指示器
- (UIView *)bottom_line {
    if(_bottom_line == nil){
        _bottom_line = [[UIView alloc] initWithFrame:CGRectMake(25, self.tab_height-3, 50, 3)];
        [_bottom_line setBackgroundColor:[UIColor infoBlueColor]];
    }
    return _bottom_line;
}

@end
