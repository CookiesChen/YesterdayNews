//
//  NoCommentCell.m
//  YesterdayNews
//
//  Created by 陈冬禹 on 2019/6/22.
//  Copyright © 2019年 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoCommentCell.h"
#import <Colours.h>

@interface NoCommentCell ()
{
    CGFloat space;
    CGFloat marginBottom;
}

@property (nonatomic, strong) UILabel *comment_content;

@end

@implementation NoCommentCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    space = 5;
    marginBottom = 20;
    
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
    [self updateViewByComment:@"还没有人评论"];
}

- (void)loadSubView
{
    [self addSubview:self.comment_content];
}

- (void)updateViewByComment:(NSString *)comment
{
    [self.comment_content setText:comment];
    [self fitLocation];
    [self fitCellFrame];
}

- (void)fitLocation
{
    [self.comment_content setFrame:CGRectMake(space, space, self.frame.size.width, 30)];
}

- (void)fitCellFrame
{
    CGRect cellFrame = self.frame;
    cellFrame.size.height = 40;
    [self setFrame:cellFrame];
}

- (UILabel *)comment_content
{
    if (_comment_content == nil) {
        _comment_content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_comment_content setText:@"还没有人评论"];
        [_comment_content setTextColor:[UIColor black25PercentColor]];
        [_comment_content setTextAlignment:NSTextAlignmentCenter];
        [_comment_content setFont:[UIFont systemFontOfSize:17]];
        [_comment_content setNumberOfLines:1];
    }
    return _comment_content;
}

@end
