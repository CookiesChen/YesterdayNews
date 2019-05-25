//
//  NewsDetailViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "ContentViewController/ContentViewController.h"
#import <WebKit/WebKit.h>
#import <Colours.h>
#import <ReactiveObjC.h>

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define TopBarHeight 50
#define BottomBarHeight 60
#define TopHeight (StatusBarHeight + NavBarHeight)
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface NewsDetailViewController()
{
    CGFloat margin;
}

@property(nonatomic, strong) UILabel *newsTitle;
@property(nonatomic, strong) UIView *authorBar;
@property(nonatomic, strong) UIImageView *authorHeadImg;
@property(nonatomic, strong) UILabel *authorName;
@property(nonatomic, strong) UILabel *authorInfo;
@property(nonatomic, strong) UIButton *followButton;
@property(nonatomic, strong) WKWebView *webView;

// 顶
@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UILabel *topTitle;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) UIButton *moreButton;

// 内容
@property(nonatomic, strong) ContentViewController *content;

// 底
@property(nonatomic, strong) UIView *bottomBar;
@property(nonatomic, strong) UIButton *writeCommentButton;
@property(nonatomic, strong) UIButton *viewCommentButton;
@property(nonatomic, strong) UIButton *collectButton;
@property(nonatomic, strong) UIButton *praiseButton;
@property(nonatomic, strong) UIButton *forwardButton;

@end

@implementation NewsDetailViewController

# pragma life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindViewModel];
}


# pragma private methods
//初始化
- (instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    margin = 20.0f;
}

// ui布局
- (void)setupView {
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    [self.view addSubview: self.topBar];
    [self.view addSubview: self.content.view];
    [self.view addSubview: self.bottomBar];
}

// viewmodel绑定
- (void)bindViewModel {
    
}

# pragma getters and setters
// 横栏
- (UIView *) topBar {
    if(_topBar == nil) {
        _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, WIDTH, TopBarHeight)];
        
        [_topBar addSubview:self.backButton];
        [_topBar addSubview:self.topTitle];
        [_topBar addSubview:self.searchButton];
        [_topBar addSubview:self.moreButton];
        // 分割线
        UIView *separator_line = [[UIView alloc] initWithFrame:CGRectMake(0, TopBarHeight-1, WIDTH, 1)];
        [separator_line setBackgroundColor:[UIColor black75PercentColor]];
        [_topBar addSubview:separator_line];
    }
    return _topBar;
}

- (UIButton *)backButton {
    if(_backButton == nil){
        CGFloat width = 20.0f, height = 20.0f;
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
        _backButton.frame = CGRectMake(margin, (TopBarHeight-width)/2, width, height);
        _backButton.imageView.contentMode = UIViewContentModeCenter;
        [[_backButton rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backButton;
}

- (UILabel *)topTitle {
    if(_topTitle == nil) {
        _topTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
        [_topTitle setText:@"昨日头条"];
        [_topTitle setFont:[UIFont systemFontOfSize:20]];
        [_topTitle setShadowColor:[UIColor black25PercentColor]];
        [_topTitle setTextAlignment:NSTextAlignmentCenter];
        [_topTitle sizeToFit];
        CGFloat width = _topTitle.frame.size.width, height = _topTitle.frame.size.height;
        [_topTitle setFrame: CGRectMake((WIDTH-width)/2, (TopBarHeight-height)/2, width, height)];
    }
    return _topTitle;
}

- (UIButton *)searchButton {
    if(_searchButton == nil) {
        CGFloat width = 20.0f, height = 20.0f;
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setBackgroundImage:[UIImage imageNamed:@"button_search"] forState:UIControlStateNormal];
        _searchButton.frame = CGRectMake(WIDTH - 2*(margin+width), (TopBarHeight-width)/2, width, height);
        _searchButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _searchButton;
}

- (UIButton *)moreButton {
    if(_moreButton == nil) {
        CGFloat width = 20.0f, height = 20.0f;
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setBackgroundImage:[UIImage imageNamed:@"button_more"] forState:UIControlStateNormal];
        _moreButton.frame = CGRectMake(WIDTH - (margin+width), (TopBarHeight-width)/2, width, height);
        _moreButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _moreButton;
}

// 内容
- (ContentViewController *)content {
    if(_content == nil) {
        _content = [[ContentViewController alloc] initWithFrame:CGRectMake(0, TopBarHeight+StatusBarHeight, WIDTH, HEIGHT-TopBarHeight-StatusBarHeight-BottomBarHeight)];
    }
    return _content;
}

// 底栏
- (UIView *) bottomBar {
    if(_bottomBar == nil) {
        _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-BottomBarHeight, WIDTH, BottomBarHeight)];
        
        [_bottomBar addSubview:self.writeCommentButton];
        [_bottomBar addSubview:self.viewCommentButton];
        [_bottomBar addSubview:self.collectButton];
        [_bottomBar addSubview:self.praiseButton];
        [_bottomBar addSubview:self.forwardButton];
        // 分割线
        UIView *separator_line = [[UIView alloc] initWithFrame:CGRectMake(0, 1, WIDTH, 1)];
        [separator_line setBackgroundColor:[UIColor black75PercentColor]];
        [_bottomBar addSubview:separator_line];
    }
    return _bottomBar;
}

- (UIButton *)writeCommentButton {
    if(_writeCommentButton == nil){
        CGFloat width = 40.0f, height = 30.0f;
        _writeCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _writeCommentButton.frame = CGRectMake(margin, (BottomBarHeight-height)/2, WIDTH-4*(margin+width), height);
        [_writeCommentButton setTitle:@"我来评论.." forState:UIControlStateNormal];
        _writeCommentButton.titleLabel.font = [UIFont systemFontOfSize: 15.0f];
        [_writeCommentButton setTitleColor:[UIColor black50PercentColor] forState:UIControlStateNormal];
        [_writeCommentButton setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
        [_writeCommentButton.layer setCornerRadius:15.0];
    }
    return _writeCommentButton;
}

- (UIButton *)viewCommentButton {
    if(_viewCommentButton == nil) {
        CGFloat width = 25.0f, height = 25.0f;
        _viewCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _viewCommentButton.frame = CGRectMake(WIDTH-4*(margin+width), (BottomBarHeight-height)/2, width, height);
        [_viewCommentButton setBackgroundImage:[UIImage imageNamed:@"button_comment"] forState:normal];
        _viewCommentButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _viewCommentButton;
}

- (UIButton *)collectButton {
    if(_collectButton == nil) {
        CGFloat width = 25.0f, height = 25.0f;
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectButton.frame = CGRectMake(WIDTH-3*(margin+width), (BottomBarHeight-height)/2, width, height);
        [_collectButton setBackgroundImage:[UIImage imageNamed:@"button_collection"] forState:normal];
        _collectButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _collectButton;
}

- (UIButton *)praiseButton {
    if(_praiseButton == nil) {
        CGFloat width = 25.0f, height = 25.0f;
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.frame = CGRectMake(WIDTH-2*(margin+width), (BottomBarHeight-height)/2, width, height);
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"button_like"] forState:normal];
        _praiseButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _praiseButton;
}

- (UIButton *)forwardButton {
    if(_forwardButton == nil) {
        CGFloat width = 30.0f, height = 30.0f;
        _forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forwardButton.frame = CGRectMake(WIDTH-(margin+width), (BottomBarHeight-height)/2, width, height);
        [_forwardButton setBackgroundImage:[UIImage imageNamed:@"button_share"] forState:normal];
        _forwardButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _forwardButton;
}

@end
