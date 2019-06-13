//
//  authorBarCell.m
//  YesterdayNews
//
//  Created by chenbb6 on 2019/6/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorBarCell.h"
#import "Colours.h"

@interface AuthorBarCell() {
    NSInteger marginTop;
    NSInteger space;
}

@end

@implementation AuthorBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    // 初始化
    marginTop = 10;
    space = 10;
    
    // 设置背景色
    [self setBackgroundColor:[UIColor whiteColor]];
    // 添加子view
    [self loadSubView];
    // 调整位置
    [self fitLocation];
    // 调整cell大小
    [self fitCellFrame];
}

- (void)loadSubView
{
    [self addSubview: self.authorHeadImg];
    [self addSubview: self.authorName];
    [self addSubview: self.authorInfo];
    [self addSubview: self.followButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self fitLocation];
    [self fitCellFrame];
}

- (void)fitLocation
{
    float authorHeadImgWidth = 40.f, authorHeadImgHeight = 40.0f;
    float followButtonWidth = 50.0f, followButtonHeight = 30.0f;
    [self.authorHeadImg setFrame: CGRectMake(0, marginTop, authorHeadImgWidth, authorHeadImgWidth)];
    [self.authorName setFrame: CGRectMake(authorHeadImgWidth + space, marginTop, 200, authorHeadImgHeight*3/5)];
    [self.authorInfo setFrame: CGRectMake(authorHeadImgWidth + space, [self bottom: self.authorName], 200, authorHeadImgHeight*2/5)];

    [self.followButton setFrame: CGRectMake(self.frame.size.width-followButtonWidth, marginTop + (authorHeadImgHeight - followButtonHeight)/2, followButtonWidth, followButtonHeight)];
    [self.followButton.layer setCornerRadius:followButtonHeight/3];
}

- (void)fitCellFrame
{
    CGRect cell_frame = self.frame;
    CGFloat max_height = MAX([self bottom: self.authorHeadImg], [self bottom: self.followButton]);
    cell_frame.size.height = max_height;
    [self setFrame:cell_frame];
}


- (UIImageView *)authorHeadImg
{
    if(_authorHeadImg == nil) {
        _authorHeadImg = [UIImageView new];
        _authorHeadImg.image = [UIImage imageNamed:@"headImg"];
        _authorHeadImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _authorHeadImg;
}


- (UILabel *)authorName {
    if(_authorName == nil) {
        _authorName = [UILabel new];
        [_authorName setText:@"作者名"];
        [_authorName setFont:[UIFont systemFontOfSize:15]];
        [_authorName setTextAlignment:NSTextAlignmentLeft];
        [_authorName setNumberOfLines: 1];
    }
    return _authorName;
}

- (UILabel *)authorInfo {
    if(_authorInfo == nil) {
        _authorInfo = [UILabel new];
        [_authorInfo setText:@"作者简称"];
        [_authorInfo setFont:[UIFont systemFontOfSize:13]];
        [_authorName setNumberOfLines: 1];
        [_authorInfo setTextColor:[UIColor black50PercentColor]];
    }
    return _authorInfo;
}

- (UIButton *)followButton {
    if(_followButton == nil) {
//        CGFloat width = 50.f, height = 30.0f;
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _followButton.frame = CGRectMake(self.frame.size.width-width, (self.frame.size.height-height)/2, width, height);
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        [_followButton setTitleColor:[UIColor whiteColor] forState:normal];
        [_followButton setContentMode:UIViewContentModeCenter];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_followButton setBackgroundColor:[UIColor redColor]];
    }
    return _followButton;
}

- (void)sizeFitHeight:(UIView *)view
{
    CGRect frame = view.frame;
    [view sizeToFit];
    frame.size.height = view.frame.size.height;
    [view setFrame: frame];
}

- (CGFloat)bottom: (UIView *)view
{
    return view.frame.origin.y + view.frame.size.height;
}

@end
