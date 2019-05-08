//
//  News.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/7.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)init{
    self = [super init];
    [self setTitle: @"打工熬到脱水！“星马影帝”笑言港姐女友靓汤补身"];
    [self setAuthor: @"新华网客户端"];
    [self setTime: [NSDate date]];
    [self setComments: [[NSMutableArray alloc] initWithArray:@[@"1", @"2"]]];
    [self setImages: [[NSMutableArray alloc] initWithArray:@[@"1", @"2", @"3"]]];
    return self;
}



@end
