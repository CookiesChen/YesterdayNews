//
//  NewsDetailViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <Colours.h>
#import <ReactiveObjC.h>

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavBarHeight 44
#define NavHeight (StatusBarHeight + NavBarHeight)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@interface NewsDetailViewController()

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIImage *topImg;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) UIButton *moreButton;

- (void)addBackBtn;

@end

@implementation NewsDetailViewController

/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindViewModel];
}


/* -- progma mark - private methods -- */

//初始化
- (instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
}

// ui布局
- (void)setupView {
    [self.view setFrame:[UIScreen mainScreen ].bounds];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight)];
    _topBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topBar];
    [self addBackBtn];
}

// viewmodel绑定
- (void)bindViewModel {
    
}

// 添加返回按钮
- (void)addBackBtn {
    UIImage *backgroundImg = [UIImage imageNamed:@"9"];
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:backgroundImg forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(0, 0, 60, 44);
    [_topBar addSubview:_backButton];
}

/* -- progma mark - UICollectionViewDelegate -- */

/* -- progma mark - getters and setters -- */



@end
