//
//  NewsTitleCell.m
//  YesterdayNews
//
//  Created by chenbb6 on 2019/6/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsTitleCell.h"


@interface NewsTitleCell()
{
    CGFloat marginTop;
};


@end

@implementation NewsTitleCell

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
    [self addSubview: self.titleContent];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self fitLocation];
    [self fitCellFrame];
}

- (void)fitLocation
{
    [self.titleContent setFrame: CGRectMake(0, marginTop, self.frame.size.width, 0)];
    [self sizeFitHeight: self.titleContent];
}

- (void)fitCellFrame
{
    CGRect cell_frame = self.frame;
    cell_frame.size.height = self.titleContent.frame.origin.y + self.titleContent.frame.size.height;
    [self setFrame:cell_frame];
}

- (void)updateViewByTitle: (NSString *)title
{
    [self.titleContent setText: title];
    [self fitLocation];
    [self fitCellFrame];
}

- (UILabel *)titleContent {
    if(_titleContent == nil) {
        _titleContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [_titleContent setText:@"这是原始标题的默认信息，请进行标题文字赋值"];
        [_titleContent setFont:[UIFont systemFontOfSize:23]];
        [_titleContent setTextAlignment:NSTextAlignmentLeft];
        [_titleContent setNumberOfLines: 0];
    }
    return _titleContent;
}

- (void)sizeFitHeight:(UIView *)view
{
    CGRect frame = view.frame;
    [view sizeToFit];
    frame.size.height = view.frame.size.height;
    [view setFrame: frame];
}

@end


