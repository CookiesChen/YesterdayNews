//
//  ProfileViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/18.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ProfileViewController.h"
#import "../../Utils/ManagerUtils/ViewModelManager.h"
#import <SDWebImage/SDWebImage.h>

#define NUM_SIZE 20
#define NUM_LABEL_SIZE 14
#define NAME_SIZE 24
#define SIGN_SIZE 18

@interface ProfileViewController ()

@property(nonatomic, strong) ProfileViewModel *ViewModel;
@property(nonatomic, strong) UIImageView *backgroundImg;
@property(nonatomic, strong) UIImageView *userHeadImg;
@property(nonatomic, strong) UILabel *userNameLabel;

@property(nonatomic, strong) UILabel *userSignLabel;

@property(nonatomic, strong) UILabel *likesNumLabel;
@property(nonatomic, strong) UILabel *likesLabel;
@property(nonatomic, strong) UILabel *followingNumLabel;
@property(nonatomic, strong) UILabel *followingLabel;
@property(nonatomic, strong) UILabel *follersNumLabel;
@property(nonatomic, strong) UILabel *follersLabel;
@property(nonatomic, strong) NSString *userIconUrl;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self initData];
}

- (void)setupView {
    
    [self.view addSubview:self.backgroundImg];
    [self.view addSubview:self.userHeadImg];
    [self.view addSubview:self.userNameLabel];
    [self.view addSubview:self.userSignLabel];
    [self.view addSubview:self.followingLabel];
    [self.view addSubview:self.likesLabel];
    [self.view addSubview:self.follersLabel];
    [self.view addSubview:self.followingNumLabel];
    [self.view addSubview:self.likesNumLabel];
    [self.view addSubview:self.follersNumLabel];
}

- (void)initData {
    self.ViewModel = [[ViewModelManager getManager] getViewModel: @"ProfileViewModel"];
    
    RACChannelTo(self.userNameLabel, text) = RACChannelTo(self.ViewModel, username);
    RACChannelTo(self.likesNumLabel, text) = RACChannelTo(self.ViewModel, like);
    RACChannelTo(self.followingNumLabel, text) = RACChannelTo(self.ViewModel, following);
    RACChannelTo(self.follersNumLabel, text) = RACChannelTo(self.ViewModel, follower);
    RACChannelTo(self, userIconUrl) = RACChannelTo(self.ViewModel, userIconUrl);
}

- (void)setUserIconUrl:(NSString *)userIconUrl
{
    NSURL *imageURL = [NSURL URLWithString:userIconUrl];
    [[SDImageCache sharedImageCache] removeImageForKey:userIconUrl withCompletion:nil];
    UIImage *cachedImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:userIconUrl];
    if (!cachedImg) {
        [self.backgroundImg sd_setImageWithURL:imageURL placeholderImage:nil];
        [self.userHeadImg sd_setImageWithURL:imageURL placeholderImage:nil];
    }else{
        self.backgroundImg.image = cachedImg;
        self.userHeadImg.image = cachedImg;
    }
}


- (UIImageView *) backgroundImg {
    if(_backgroundImg == nil) {
        _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 320)];
        _backgroundImg.contentMode = UIViewContentModeScaleToFill;
        // 毛玻璃
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
        effectview.frame = CGRectMake(0, 0, _backgroundImg.frame.size.width, _backgroundImg.frame.size.height);
        [_backgroundImg addSubview:effectview];
    }
    return _backgroundImg;
}

- (UIImageView *) userHeadImg {
    if(_userHeadImg == nil) {
        _userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 55, 60, 110, 110)];
        _userHeadImg.contentMode = UIViewContentModeScaleAspectFill;
        _userHeadImg.layer.masksToBounds = YES;
        _userHeadImg.layer.cornerRadius = _userHeadImg.frame.size.width/2;
    }
    return _userHeadImg;
}

- (UILabel *) userNameLabel {
    if(_userNameLabel == nil) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
        _userNameLabel.textColor = [UIColor whiteColor];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.font = [UIFont boldSystemFontOfSize:NAME_SIZE];
    }
    return _userNameLabel;
}

- (UILabel *) userSignLabel {
    if(_userSignLabel == nil) {
        _userSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, self.view.frame.size.width, 20)];
        _userSignLabel.textColor = [UIColor lightGrayColor];
        _userSignLabel.textAlignment = NSTextAlignmentCenter;
        _userSignLabel.font = [UIFont systemFontOfSize:SIGN_SIZE];
    }
    return _userSignLabel;
}

- (UILabel *) likesLabel {
    if(_likesLabel == nil) {
        _likesLabel = [self createDataTitleLabelWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 280, 100, 30) text:@"获赞" color:[UIColor lightGrayColor]];
    }
    return _likesLabel;
}

- (UILabel *) followingLabel {
    if(_followingLabel == nil) {
        _followingLabel = [self createDataTitleLabelWithFrame:CGRectMake(30, 280, 100, 30) text:@"关注" color:[UIColor lightGrayColor]];
    }
    return _followingLabel;
}

- (UILabel *) follersLabel {
    if(_follersLabel == nil) {
        _follersLabel = [self createDataTitleLabelWithFrame:CGRectMake(self.view.frame.size.width - 130, 280, 100, 30) text:@"粉丝" color:[UIColor lightGrayColor]];
    }
    return _follersLabel;
}


- (UILabel *) likesNumLabel {
    if(_likesNumLabel == nil) {
        _likesNumLabel = [self createDataLabelWithFrame:CGRectMake(_likesLabel.frame.origin.x, _likesLabel.frame.origin.y - 25, 100, 30) color:[UIColor whiteColor]];
    }
    return _likesNumLabel;
}

- (UILabel *) followingNumLabel {
    if(_followingNumLabel == nil) {
        _followingNumLabel = [self createDataLabelWithFrame:CGRectMake(_followingLabel.frame.origin.x, _followingLabel.frame.origin.y - 25, 100, 30) color:[UIColor whiteColor]];
    }
    return _followingNumLabel;
}

- (UILabel *) follersNumLabel {
    if(_follersNumLabel == nil) {
        _follersNumLabel = [self createDataLabelWithFrame:CGRectMake(_follersLabel.frame.origin.x, _follersLabel.frame.origin.y - 25, 100, 30) color:[UIColor whiteColor]];
    }
    return _follersNumLabel;
}

-(UILabel *)createDataTitleLabelWithFrame:(CGRect)frame text:(NSString *)text color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:NUM_LABEL_SIZE];
    label.text = text;
    return label;
}

// 创建数字Label
-(UILabel *)createDataLabelWithFrame:(CGRect)frame color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:NUM_SIZE];
    return label;
}

@end
