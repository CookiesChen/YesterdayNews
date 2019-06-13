//
//  Comment.m
//  YesterdayNews
//
//  Created by chenbb6 on 2019/5/25.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"

@implementation Comment

- (instancetype)init{
    self = [super init];
//    [self setTitle: @"打工熬到脱水！“星马影帝”笑言港姐女友靓汤补身"];
//    [self setAuthor: @"新华网客户端"];
//    [self setTime: [NSDate date]];
//    [self setComments: @"0评论"];
//    [self setTag:SingleImageNewsTag];
    [self setCommentID:@"3"];
    [self setUserIcon:@"headImg"];
    [self setUserName:@"中大小邋遢"];
    [self setCellHight:238];
    [self setCommentTime:[NSDate date]];
    [self setCommentContent: @"去年有资格和勇士较量胜负的唯一球队，火箭。今年到目前为止最接近能打败勇士的还是火箭。去年有资格和勇士较量胜负的唯一球队，火箭。"];
    [self setThumbUpIcon:@"thumb_up_white"];
    [self setThumbUpCount:@"58"];
    return self;
}



@end
