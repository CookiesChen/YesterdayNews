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
#define TopBarHeight 50
#define BottomBarHeight 60
#define TopHeight (StatusBarHeight + NavBarHeight)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface NewsDetailViewController(){
    CGFloat margin;
}

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIImageView *topImg;
@property(nonatomic, strong) UIScrollView *content;
@property(nonatomic, strong) UILabel *newsTitle;
@property(nonatomic, strong) UIView *authorBar;
@property(nonatomic, strong) UIImageView *authorHeadImg;
@property(nonatomic, strong) UILabel *authorName;
@property(nonatomic, strong) UILabel *authorInfo;
@property(nonatomic, strong) UIButton *followButton;
@property(nonatomic, strong) UIView *bottomBar;
@property(nonatomic, strong) UIButton *writeCommentButton;
@property(nonatomic, strong) UIButton *viewCommentButton;
@property(nonatomic, strong) UIButton *collectButton;
@property(nonatomic, strong) UIButton *praiseButton;
@property(nonatomic, strong) UIButton *forwardButton;

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
    margin = 20.0f;
}

// ui布局
- (void)setupView {
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    [self.view addSubview: self.topBar];
    [self.view addSubview: self.content];
    [self.view addSubview: self.bottomBar];
}

// viewmodel绑定
- (void)bindViewModel {
    
}

- (UIView *) bottomBar{
    if(_bottomBar == nil){
        _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-BottomBarHeight, ScreenWidth, BottomBarHeight)];
        [_bottomBar setBackgroundColor:[UIColor whiteColor]];
        // 写评论
        CGFloat width = 40.f, height = 40.0f;
        _writeCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _writeCommentButton.frame = CGRectMake(margin, (BottomBarHeight-height)/2, ScreenWidth-4*(margin+width), height);
        [_writeCommentButton setTitle:@"我来评论.." forState:UIControlStateNormal];
        [_writeCommentButton setTitleColor:[UIColor black50PercentColor] forState:UIControlStateNormal];
        [_writeCommentButton setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
        [_writeCommentButton.layer setCornerRadius:20.0];
        [_bottomBar addSubview:_writeCommentButton];
        // 查看评论
        width = 25.0f; height = 25.0f;
        _viewCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _viewCommentButton.frame = CGRectMake(ScreenWidth-4*(margin+width), (BottomBarHeight-height)/2, width, height);
        [_viewCommentButton setBackgroundImage:[UIImage imageNamed:@"button_comment"] forState:normal];
        _viewCommentButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_bottomBar addSubview:_viewCommentButton];
        // 收藏
        _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectButton.frame = CGRectMake(ScreenWidth-3*(margin+width), (BottomBarHeight-height)/2, width, height);
        [_collectButton setBackgroundImage:[UIImage imageNamed:@"button_collection"] forState:normal];
        _collectButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_bottomBar addSubview:_collectButton];
        // 点赞
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.frame = CGRectMake(ScreenWidth-2*(margin+width), (BottomBarHeight-height)/2, width, height);
        [_praiseButton setBackgroundImage:[UIImage imageNamed:@"button_like"] forState:normal];
        _praiseButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_bottomBar addSubview:_praiseButton];
        // 转发
        width = 30.f; height = 30.0f;
        _forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _forwardButton.frame = CGRectMake(ScreenWidth-(margin+width), (BottomBarHeight-height)/2, width, height);
        [_forwardButton setBackgroundImage:[UIImage imageNamed:@"button_share"] forState:normal];
        _forwardButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_bottomBar addSubview:_forwardButton];
        
        // 分割线
        UIView *separator_line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        [separator_line setBackgroundColor:[UIColor black75PercentColor]];
        [_bottomBar addSubview:separator_line];
    }
    return _bottomBar;
}

/* -- progma mark - UICollectionViewDelegate -- */

/* -- progma mark - getters and setters -- */
- (UIView *)topBar {
    if(_topBar == nil) {
        _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, TopBarHeight)];
        [_topBar setBackgroundColor: [UIColor whiteColor]];
        
        // 返回按钮
        CGFloat width = 20.0f, height = 20.0f;
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
        backButton.frame = CGRectMake(margin, (TopBarHeight-width)/2, width, height);
        backButton.imageView.contentMode = UIViewContentModeCenter;
        [[backButton rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [_topBar addSubview:backButton];
        
        // 标题
        UILabel *topTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 45)];
        [topTitle setText:@"昨日头条"];
        [topTitle setFont:[UIFont systemFontOfSize:20]];
        [topTitle setShadowColor:[UIColor black25PercentColor]];
        [topTitle setTextAlignment:NSTextAlignmentCenter];
        [topTitle sizeToFit];
        width = topTitle.frame.size.width; height = topTitle.frame.size.height;
        [topTitle setFrame: CGRectMake((ScreenWidth-width)/2, (TopBarHeight-height)/2, width, height)];
        [_topBar addSubview:topTitle];
        // 搜索按钮
        width = 20.0f; height = 20.0f;
        UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchButton setBackgroundImage:[UIImage imageNamed:@"button_search"] forState:UIControlStateNormal];
        searchButton.frame = CGRectMake(ScreenWidth - 2*(margin+width), (TopBarHeight-width)/2, width, height);
        searchButton.imageView.contentMode = UIViewContentModeCenter;
        [_topBar addSubview:searchButton];
        // ‘更多’按钮
        UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [moreButton setBackgroundImage:[UIImage imageNamed:@"button_more"] forState:UIControlStateNormal];
        moreButton.frame = CGRectMake(ScreenWidth - (margin+width), (TopBarHeight-width)/2, width, height);
        moreButton.imageView.contentMode = UIViewContentModeCenter;
        [_topBar addSubview:moreButton];
        
        // 分割线
        UIView *separator_line = [[UIView alloc] initWithFrame:CGRectMake(0, TopBarHeight, ScreenWidth, 1)];
        [separator_line setBackgroundColor:[UIColor black75PercentColor]];
        [_topBar addSubview:separator_line];
    }
    return _topBar;
}

- (UIScrollView *)content {
    if(_content == nil){
        _content = [[UIScrollView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + TopBarHeight, ScreenWidth, ScreenHeight-StatusBarHeight-TopBarHeight-BottomBarHeight)];
        // 新闻标题
        CGFloat marginTop = 20.0f;
        _newsTitle = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, ScreenWidth-margin, 400)];
        [_newsTitle setText:@"这款国剧正以风暴速度席卷朋友圈，年度王者终于来了！"];
        _newsTitle.numberOfLines = 0;
        [_newsTitle setFont:[UIFont systemFontOfSize:23]];
        [_newsTitle setTextAlignment:NSTextAlignmentLeft];
        [_newsTitle sizeToFit];
        [_newsTitle setFrame:CGRectMake(margin, marginTop, _newsTitle.frame.size.width, _newsTitle.frame.size.height)];
        [_content addSubview:_newsTitle];
        marginTop += _newsTitle.frame.size.height + 20;
        // 作者信息
        _authorBar = [[UIView alloc] initWithFrame:CGRectMake(margin, marginTop, ScreenWidth-2*margin, 100)];
        // 头像
        float width = 40.f, height = 40.0f;
        _authorHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        _authorHeadImg.image = [UIImage imageNamed:@"headImg"];
        _authorHeadImg.contentMode = UIViewContentModeScaleAspectFit;
        [_authorBar addSubview:_authorHeadImg];
        // 名字
        _authorName = [[UILabel alloc] initWithFrame:CGRectMake(width+10, 0, 200, height*3/5)];
        [_authorName setText:@"电影烂番茄"];
        [_authorName setFont:[UIFont systemFontOfSize:15]];
        [_authorBar addSubview:_authorName];
        // 信息
        _authorInfo = [[UILabel alloc] initWithFrame:CGRectMake(width+10, height*3/5, 300, height*2/5)];
        [_authorInfo setText:@"优质影视领域创作者"];
        [_authorInfo setFont:[UIFont systemFontOfSize:13]];
        [_authorInfo setTextColor:[UIColor black50PercentColor]];
        [_authorBar addSubview:_authorInfo];
        // 关注按钮
        width = 50.f; height = 30.0f;
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _followButton.frame = CGRectMake(ScreenWidth-2*margin-width, (TopBarHeight-height)/2, width, height);
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:[UIColor whiteColor] forState:normal];
        [_followButton setContentMode:UIViewContentModeCenter];
        [_followButton.layer setCornerRadius:height/3];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_followButton setBackgroundColor:[UIColor redColor]];
        [_authorBar addSubview:_followButton];
        [_content addSubview:_authorBar];
        
    }
    return _content;
}

@end
