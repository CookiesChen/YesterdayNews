//
//  MultiImagesNews.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "../Utils/TimeUtils/TimeUtils.h"
#import "MultiImagesNews.h"
#import <Colours.h>

#define HEIGHT self.frame.size.height
#define WIDTH self.frame.size.width

@interface MultiImagesNews(){
    NSInteger margin;
    CGFloat marginTop;
}

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *author;
@property(nonatomic, strong) UILabel *comment;
@property(nonatomic, strong) UILabel *time;

@end

@implementation MultiImagesNews

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self){
        margin = 10;
        marginTop = 10;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackgroundColor: [UIColor whiteColor]];

    [self addSubview: self.title];
    marginTop += self.title.frame.size.height + 10;
    
    NSInteger count = 3;
    CGFloat imageMargin = 10;
    CGFloat imageSize = (WIDTH-2*margin-2*imageMargin)/3;
    for(int i = 0; i < count; i++){
        CGFloat marginLeft = 0;
        if(i == 0){
            marginLeft = margin;
        } else {
            marginLeft = margin + (imageSize + imageMargin)*i;
        }
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"example_image.png"]];
        [image setBackgroundColor: [UIColor black75PercentColor]];
        [image setFrame:CGRectMake(marginLeft, marginTop, imageSize, imageSize)];
        
        [self addSubview:image];
    }
    marginTop += imageSize + 5;
    
    [self addSubview: self.author];
    [self addSubview: self.comment];
    [self addSubview: self.time];
}

- (UILabel *)title {
    if(_time == nil){
        _title = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH-2*margin, 100)];
        [_title setText: @"打工熬到脱水！“星马影帝”笑言港姐女友靓汤补身"];
        [_title setFont: [UIFont systemFontOfSize: 20]];
        [_title setLineBreakMode: NSLineBreakByWordWrapping];
        [_title setNumberOfLines: 0];
        [_title sizeToFit];
    }
    return _title;
}

- (UILabel *)author {
    if(_author == nil){
        _author = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH, 25)];
        [_author setText: @"新华网客户端"];
        [_author setFont: [UIFont systemFontOfSize: 15]];
        [_author setTextColor: [UIColor black25PercentColor]];
        [_author sizeToFit];
    }
    return _author;
}

- (UILabel *)comment {
    if(_comment == nil){
        _comment = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH, 25)];
        _comment = [[UILabel alloc] initWithFrame:CGRectMake(margin+self.author.frame.size.width+10, marginTop, WIDTH, 25)];
        [_comment setText: @"508评论"];
        [_comment setFont: [UIFont systemFontOfSize: 15]];
        [_comment setTextColor: [UIColor black25PercentColor]];
        [_comment sizeToFit];
    }
    return _comment;
}

- (UILabel *)time {
    if(_time == nil){
        _time = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-margin, marginTop, WIDTH, 25)];
        [_time setText: [TimeUtils getTimeDifference:[NSDate dateWithTimeIntervalSinceNow: -2*60*60]]];
        [_time setFont: [UIFont systemFontOfSize: 15]];
        [_time setTextColor: [UIColor black25PercentColor]];
        [_time sizeToFit];
        [_time setFrame:CGRectMake(WIDTH-margin-_time.frame.size.width, marginTop, _time.frame.size.width, 25)];
    }
    return _time;
}

@end
