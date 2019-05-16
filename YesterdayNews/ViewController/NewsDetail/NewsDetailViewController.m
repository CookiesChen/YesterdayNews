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
#define TopHeight (StatusBarHeight + NavBarHeight)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height



@interface NewsDetailViewController()

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIImageView *topImg;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) UIButton *moreButton;
@property(nonatomic, strong) UIView *part1;
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

- (void)setTopBar;

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
    [self setTopBar];
    [self setPart1];
    [self setBottomBar];
}

// viewmodel绑定
- (void)bindViewModel {
    
}

- (void)setTopBar {
    _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, TopBarHeight)];
    _topBar.backgroundColor = [UIColor lightTextColor];
    [self.view addSubview:_topBar];
    UIImage *backgroundImg = [UIImage imageNamed:@"backButton"];
    // 返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setBackgroundImage:backgroundImg forState:UIControlStateNormal];
    _backButton.frame = CGRectMake(0, 0, 45, 45);
    _backButton.imageView.contentMode = UIViewContentModeCenter;
    [[_backButton rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [_topBar addSubview:_backButton];
    // 标题
    UILabel *topTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 45)];
    [topTitle setText:@"今日头条"];
    [topTitle setFont:[UIFont systemFontOfSize:30]];
    [topTitle setTextAlignment:NSTextAlignmentCenter];
    [_topBar addSubview:topTitle];
    // 搜索按钮
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundImg = [UIImage imageNamed:@"searchButton"];
    [_searchButton setBackgroundImage:backgroundImg forState:UIControlStateNormal];
    _searchButton.frame = CGRectMake(300, 0, 45, 45);
    _searchButton.imageView.contentMode = UIViewContentModeCenter;
    [_topBar addSubview:_searchButton];
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backgroundImg = [UIImage imageNamed:@"moreButton"];
    // ‘更多’按钮
    [_moreButton setBackgroundImage:backgroundImg forState:UIControlStateNormal];
    _moreButton.frame = CGRectMake(360, 0, 45, 45);
    _moreButton.imageView.contentMode = UIViewContentModeCenter;
    [_topBar addSubview:_moreButton];
}

- (void)setPart1 {
    _part1 = [[UIView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + TopBarHeight, ScreenWidth, 300)];
    [self.view addSubview:_part1];
    // 新闻标题
    _newsTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 100)];
    [_newsTitle setText:@"这款国剧正以风暴速度席卷朋友圈，年度王者终于来了！"];
    _newsTitle.numberOfLines = 0;
    [_newsTitle setFont:[UIFont systemFontOfSize:30]];
    [_newsTitle setTextAlignment:NSTextAlignmentLeft];
    [_part1 addSubview:_newsTitle];
    // 作者信息
    _authorBar = [[UIView alloc] initWithFrame:CGRectMake(10, 100, ScreenWidth, 100)];
    // 头像
    _authorHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 40, 40)];
    _authorHeadImg.image = [UIImage imageNamed:@"headImg"];
    _authorHeadImg.contentMode = UIViewContentModeScaleAspectFit;
    [_authorBar addSubview:_authorHeadImg];
    // 名字
    _authorName = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 200, 20)];
    [_authorName setText:@"电影烂番茄"];
    [_authorName setFont:[UIFont systemFontOfSize:20]];
    [_authorBar addSubview:_authorName];
    // 信息
    _authorInfo = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 300, 20)];
    [_authorInfo setText:@"优质影视领域创作者"];
    [_authorInfo setFont:[UIFont systemFontOfSize:20]];
    [_authorBar addSubview:_authorInfo];
    // 关注按钮
    _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _followButton.frame = CGRectMake(300, 0, 100, 50);
    [_followButton setTitle:@"关注" forState:UIControlStateNormal];
    [_followButton setTitleColor:[UIColor whiteColor] forState:normal];
    _followButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [_followButton setBackgroundColor:[UIColor redColor]];
    [_authorBar addSubview:_followButton];
    [_part1 addSubview:_authorBar];
    [self.view addSubview:_part1];
}

- (void)setBottomBar {
    // 底部按钮栏
    _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 120, ScreenWidth, 60)];
    [_bottomBar setBackgroundColor:[UIColor whiteColor]];
    [_bottomBar.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [_bottomBar.layer setBorderWidth:1];
    // 写评论
    _writeCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _writeCommentButton.frame = CGRectMake(5, 10, 110, 40);
    [_writeCommentButton setFont:[UIFont systemFontOfSize:15]];
    [_writeCommentButton setTitle:@"写评论..." forState:UIControlStateNormal];
    [_writeCommentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_writeCommentButton setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
    [_writeCommentButton.layer setCornerRadius:30.0];
    [_bottomBar addSubview:_writeCommentButton];
    // 查看评论
    _viewCommentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _viewCommentButton.frame = CGRectMake(120, 10, 40, 40);
    [_viewCommentButton setBackgroundImage:[UIImage imageNamed:@"commentButton"] forState:normal];
    _viewCommentButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bottomBar addSubview:_viewCommentButton];
    // 收藏
    _collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectButton.frame = CGRectMake(190, 10, 40, 40);
    [_collectButton setBackgroundImage:[UIImage imageNamed:@"collectButton"] forState:normal];
    _collectButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bottomBar addSubview:_collectButton];
    // 点赞
    _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _praiseButton.frame = CGRectMake(260, 10, 40, 40);
    [_praiseButton setBackgroundImage:[UIImage imageNamed:@"praiseButton"] forState:normal];
    _praiseButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bottomBar addSubview:_praiseButton];
    // 转发
    _forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _forwardButton.frame = CGRectMake(330, 10, 40, 40);
    [_forwardButton setBackgroundImage:[UIImage imageNamed:@"forwardButton"] forState:normal];
    _forwardButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_bottomBar addSubview:_forwardButton];
    [self.view addSubview:_bottomBar];
}

/* -- progma mark - UICollectionViewDelegate -- */

/* -- progma mark - getters and setters -- */



@end
