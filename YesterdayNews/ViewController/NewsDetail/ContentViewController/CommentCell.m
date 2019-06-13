//
//  CommentCell.m
//  YesterdayNews
//
//  Created by chenbb6 on 2019/5/24.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentCell.h"
#import <Colours.h>
#import <SDWebImage/SDWebImage.h>
#import "../../../Utils/TimeUtils/TimeUtils.h"
#import "ViewModelManager.h"


@interface CommentCell()
{
    CGFloat user_icon_height;
    CGFloat user_icon_width;
    CGFloat thumb_up_icon_height;
    CGFloat thumb_up_icon_width;
    CGFloat space;
    CGFloat marginBottom;
};

@property(nonatomic, strong) UIImageView *user_icon;
@property(nonatomic, strong) UILabel *user_name;
@property(nonatomic, strong) UILabel *comment_content;
@property(nonatomic, strong) UIImageView *thumb_up_icon;
@property(nonatomic, strong) UILabel *thumb_up_count;
@property(nonatomic, strong) UILabel *comment_time;
@property(nonatomic, strong) Comment* comment;
@property(nonatomic, assign) BOOL hasThumbUp;

@end

@implementation CommentCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    // 初始化
    user_icon_width = 48;
    user_icon_height = 48;
    thumb_up_icon_height = 20;
    thumb_up_icon_width = 20;
    space = 5;
    marginBottom = 20;
    
    // 计算是否点赞过
    [self computeIfThumbUp];
    // 设置背景色
    [self setBackgroundColor:[UIColor whiteColor]];
    // 添加子view
    [self loadSubView];
    // 调整位置
    [self fitLocation];
    // 适配cell尺寸
    [self fitCellFrame];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateViewByComment: self.comment];
}


- (void)loadSubView
{
    [self addSubview: self.user_icon];
    [self addSubview: self.user_name];
    [self addSubview: self.thumb_up_icon];
    [self addSubview: self.thumb_up_count];
    [self addSubview: self.comment_content];
    [self addSubview: self.comment_time];
}

- (void)fitLocation
{
    [self.user_name sizeToFit];
    [self.thumb_up_count sizeToFit];
    [self.user_icon setCenter:CGPointMake(user_icon_width/2, user_icon_height/2)];
    [self.user_name setCenter:CGPointMake(user_icon_width + space + self.user_name.frame.size.width/2, self.user_name.frame.size.height/2)];
    [self.thumb_up_count setCenter:CGPointMake(self.frame.size.width - self.thumb_up_count.frame.size.width/2, self.thumb_up_count.frame.size.height/2)];
    [self.thumb_up_icon setCenter:CGPointMake(self.thumb_up_count.frame.origin.x - self.thumb_up_count.frame.size.width/2 - space, self.thumb_up_icon.frame.size.height/2)];
    [self.comment_content setFrame:CGRectMake(self.user_icon.frame.size.width + space, self.thumb_up_icon.frame.origin.y + self.thumb_up_icon.frame.size.height + space, self.frame.size.width - self.user_icon.frame.size.width, 0)];
    [self.comment_content sizeToFit];
    [self.comment_time setFrame:CGRectMake(self.user_icon.frame.size.width + space, self.comment_content.frame.origin.y + self.comment_content.frame.size.height + space, (self.frame.size.width - self.user_icon.frame.size.width) / 2, 0)];
    [self.comment_time sizeToFit];
}

- (void)fitCellFrame
{
    CGRect cell_frame = self.frame;
    cell_frame.size.height = self.comment_time.frame.origin.y + self.comment_time.frame.size.height + marginBottom;
    [self setFrame:cell_frame];
}

- (UIImageView *)user_icon {
    if(_user_icon == nil) {
        _user_icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, user_icon_width, user_icon_height)];
        [_user_icon setImage:[UIImage imageNamed:@"headImg"]];
    }
    return _user_icon;
}

- (UILabel *)user_name {
    if(_user_name == nil) {
        _user_name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_user_name setText:@"匿名用户"];
        [_user_name setTextColor:[UIColor pastelBlueColor]];
        [_comment_content setFont: [UIFont systemFontOfSize: 17]];
        [_comment_content setLineBreakMode: NSLineBreakByTruncatingTail];
        [_comment_content setNumberOfLines: 1];
        [_user_name sizeToFit];
    }
    return _user_name;
}

- (UIImageView *)thumb_up_icon {
    if(_thumb_up_icon == nil) {
        _thumb_up_icon = [[UIImageView alloc] initWithFrame:CGRectMake(32, 0, thumb_up_icon_width, thumb_up_icon_height)];
        if(_hasThumbUp) {
            [_thumb_up_icon setImage: [UIImage imageNamed: @"thumb_up_red"]];
        }
        else {
            [_thumb_up_icon setImage:[UIImage imageNamed:@"thumb_up_white"]];
        }
        [_thumb_up_icon setUserInteractionEnabled: YES];
        UITapGestureRecognizer *thumbUpClick = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(handleThumbUp:)];
        [_thumb_up_icon addGestureRecognizer: thumbUpClick];
    }
    return _thumb_up_icon;
}

- (UILabel *)thumb_up_count {
    if(_thumb_up_count == nil) {
        _thumb_up_count = [[UILabel alloc] initWithFrame:CGRectZero];
        [_thumb_up_count setText:@"点赞数"];
        [_thumb_up_count sizeToFit];
    }
    return _thumb_up_count;
}

- (UILabel *)comment_content {
    if(_comment_content == nil) {
        _comment_content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_comment_content setText:@"这里是评论内容"];
        [_comment_content setFont: [UIFont systemFontOfSize: 17]];
        [_comment_content setLineBreakMode: NSLineBreakByTruncatingTail];
        [_comment_content setNumberOfLines: 0];
        [_comment_content sizeToFit];
    }
    return _comment_content;
}

- (UILabel *)comment_time {
    if(_comment_time == nil) {
        _comment_time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        [_comment_time setText:@"评论时间"];
        [_comment_time setFont:[UIFont systemFontOfSize: 15]];
        [_comment_time setLineBreakMode: NSLineBreakByTruncatingTail];
        [_comment_time setNumberOfLines: 0];
        [_comment_time sizeToFit];
    }
    return _comment_time;
}

- (void)updateViewByComment: (Comment *)comment
{
    [self setComment: comment];
    [self.user_name setText: self.comment.UserName];
    [self.user_name sizeToFit];
    [self.user_icon sd_setImageWithURL:[NSURL URLWithString:self.comment.UserIcon] placeholderImage: [UIImage imageNamed:@"headImg"] options:SDWebImageAllowInvalidSSLCertificates];
    [self.thumb_up_count setText: self.comment.ThumbUpCount];
    [self.comment_content setText: self.comment.CommentContent];
    [self.comment_time setText: [TimeUtils getTimeDifference:self.comment.CommentTime]];
    [self fitLocation];
    [self fitCellFrame];
}

- (void)handleThumbUp: (UIGestureRecognizer *)gestureRecognizer
{
    if(!_hasThumbUp) {
        NewsDetailViewModel *ViewModel = [[ViewModelManager getManager] getViewModel:@"NewsDetailViewModel"];
        [ViewModel addThumbUpCountWithCommentID:_comment.commentID UserID: [[User getInstance] getUsername]];
//        [self.thumb_up_icon setImage: [UIImage imageNamed: @"thumb_up_red"]];
//        _hasThumbUp = true;
        [self fitLocation];
    }
}

// 计算是否点赞过
- (void)computeIfThumbUp
{
    _hasThumbUp = false;
}

@end


