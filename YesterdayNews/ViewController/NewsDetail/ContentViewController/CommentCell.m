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
#import "../../../Utils/TimeUtils/TimeUtils.h"


@interface CommentCell()
{
    CGFloat user_icon_height;
    CGFloat user_icon_width;
    CGFloat thumb_up_icon_height;
    CGFloat thumb_up_icon_width;
    CGFloat space;
    
};


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
    
    // 设置背景色
    [self setBackgroundColor:[UIColor whiteColor]];
    // 添加子view
    [self loadSubView];
    // 调整位置
    [self fitLocation];
    
//    CGRect cell_frame = self.frame;
//    cell_frame.size.height = self.comment_content.frame.origin.y + self.comment_content.frame.size.height;
//    [self setFrame:cell_frame];
//    NSLog(@"cell_frame(in): %@", NSStringFromCGRect(self.frame));
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"layoutSubViews:CommentCell");
    [self updateViewByComment: self.comment];
}


- (void)loadSubView
{
    [self addSubview: self.imageView];
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
    [self.comment_content setFrame:CGRectMake(self.user_icon.frame.size.width + space, self.thumb_up_icon.frame.size.height, self.frame.size.width - self.user_icon.frame.size.width - space, 0)];
    [self.comment_content sizeToFit];
    [self.comment_time setFrame:CGRectMake(self.user_icon.frame.size.width + space, self.thumb_up_icon.frame.size.height + self.comment_content.frame.size.height + space, (self.frame.size.width - self.user_icon.frame.size.width) / 2, 0)];
    [self.comment_time sizeToFit];
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
        [_comment_content setFont: [UIFont systemFontOfSize: 18]];
        [_comment_content setLineBreakMode: NSLineBreakByTruncatingTail];
        [_comment_content setNumberOfLines: 1];
        [_user_name sizeToFit];
    }
    return _user_name;
}

- (UIImageView *)thumb_up_icon {
    if(_thumb_up_icon == nil) {
        _thumb_up_icon = [[UIImageView alloc] initWithFrame:CGRectMake(32, 0, thumb_up_icon_width, thumb_up_icon_height)];
        [_thumb_up_icon setImage:[UIImage imageNamed:@"thumb_up_white"]];
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
        [_comment_content setFont: [UIFont systemFontOfSize: 20]];
        [_comment_content setLineBreakMode: NSLineBreakByTruncatingTail];
        [_comment_content setNumberOfLines: 0];
        [_comment_content sizeToFit];
    }
    return _comment_content;
}

- (UIImageView *)imageView {
    if(_imageView == nil) {
        // 居中显示 Cell
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, 80, 80)];
        CGFloat image_width = _imageView.frame.size.width;
        CGFloat leftMargin = (self.frame.size.width - image_width) / 2;
        [_imageView setCenter:CGPointMake(leftMargin + image_width/2, self.frame.size.height/2)];
    }
    return _imageView;
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
    [self.user_icon setImage: [UIImage imageNamed: self.comment.UserIcon]];
    [self.thumb_up_count setText: self.comment.ThumbUpCount];
    [self.comment_content setText: self.comment.CommentContent];
    [self.comment_time setText: [TimeUtils getTimeDifference:self.comment.CommentTime]];
    [self fitLocation];
}

@end


