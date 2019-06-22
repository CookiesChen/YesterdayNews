//
//  PureTextNews.m
//  YesterdayNews
//
//  Created by 陈冬禹 on 2019/6/15.
//  Copyright © 2019年 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Utils/TimeUtils/TimeUtils.h"
#import "PureTextNews.h"
#import "../Model/User/User.h"
#import <Colours.h>
#import <ReactiveObjC.h>

#define HEIGHT self.frame.size.height
#define WIDTH self.frame.size.width

@interface PureTextNews() <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger margin;
    CGFloat marginTop;
    CGFloat padding;
    NSString* identifer;
}

@property (nonatomic, strong) News *news;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) UILabel *comment;
@property (nonatomic, strong) UILabel *time;

@end

@implementation PureTextNews

- (instancetype)initWithFrame:(CGRect)frame andNews:(News *)news {
    self.news = news;
    self = [super initWithFrame:frame];
    if (self) {
        margin = 10;
        marginTop = 10;
        padding = 10;
        identifer = @"textCell";
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        margin = 10;
        marginTop = 10;
        identifer = @"textCell";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview: self.title];
    [self addSubview: self.author];
    [self addSubview: self.comment];
    [self addSubview: self.time];
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH - 2 * padding - 2 * margin, 24)];
        [_title setText:self.news.title];
        [_title setFont:[UIFont systemFontOfSize:20]];
        [_title setLineBreakMode:NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail];
        [_title setNumberOfLines:1];
//        [_title sizeToFit];
    }
    return _title;
}

- (UILabel *)author {
    if (_author == nil) {
        _author = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop + _title.frame.size.height + 10, WIDTH, 25)];
        [_author setText:self.news.author];
        [_author setFont:[UIFont systemFontOfSize:15]];
        [_author setTextColor: [UIColor black25PercentColor]];
        [_author sizeToFit];
    }
    return _author;
}

- (UILabel *)comment {
    if (_comment == nil) {
        _comment = [[UILabel alloc] initWithFrame:CGRectMake(margin + _author.frame.size.width + 10, marginTop + _title.frame.size.height + 10, WIDTH, 25)];
        [_comment setText: [NSString stringWithFormat:@"%@评论", self.news.comments]];
        [_comment setFont: [UIFont systemFontOfSize: 15]];
        [_comment setTextColor: [UIColor black25PercentColor]];
        [_comment sizeToFit];
    }
    return _comment;
}

- (UILabel *)time {
    if(_time == nil){
        _time = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - margin, marginTop, WIDTH, 25)];
        [_time setText: [TimeUtils getTimeDifference:self.news.time]];
        [_time setFont: [UIFont systemFontOfSize: 15]];
        [_time setTextColor: [UIColor black25PercentColor]];
        [_time sizeToFit];
        [_time setFrame:CGRectMake(WIDTH - margin - _time.frame.size.width, marginTop + _title.frame.size.height + 10, _time.frame.size.width, 25)];
    }
    return _time;
}

+ (CGFloat)itemHeight
{
    return 70;
}

@end
