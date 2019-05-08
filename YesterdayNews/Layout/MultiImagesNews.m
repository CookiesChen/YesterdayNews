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

@interface MultiImagesNews()

@end

@implementation MultiImagesNews

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(self){
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackgroundColor: [UIColor whiteColor]];
    
    NSInteger margin = 10;
    CGFloat marginTop = 10;
    //NSInteger height = 25;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH-2*margin, 100)];
    [title setText: @"打工熬到脱水！“星马影帝”笑言港姐女友靓汤补身"];
    [title setFont: [UIFont systemFontOfSize: 20]];
    [title setLineBreakMode: NSLineBreakByWordWrapping];
    [title setNumberOfLines: 0];
    [title sizeToFit];
    
    [self addSubview: title];
    
    marginTop += 50 + 10;
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
    UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH, 25)];
    [author setText: @"新华网客户端"];
    [author setFont: [UIFont systemFontOfSize: 15]];
    [author setTextColor: [UIColor black25PercentColor]];
    [author sizeToFit];
    [self addSubview: author];
    
    UILabel *comment = [[UILabel alloc] initWithFrame:CGRectMake(margin+author.frame.size.width+10, marginTop, WIDTH, 25)];
    [comment setText: @"508评论"];
    [comment setFont: [UIFont systemFontOfSize: 15]];
    [comment setTextColor: [UIColor black25PercentColor]];
    [comment sizeToFit];
    [self addSubview: comment];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-margin, marginTop, WIDTH, 25)];
    [time setText: [TimeUtils getTimeDifference:[NSDate dateWithTimeIntervalSinceNow: -2*60*60]]];
    [time setFont: [UIFont systemFontOfSize: 15]];
    [time setTextColor: [UIColor black25PercentColor]];
    [time sizeToFit];
    [time setFrame:CGRectMake(WIDTH-margin-time.frame.size.width, marginTop, time.frame.size.width, 25)];
    
    [self addSubview: time];
}

@end
