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
    [self setComments: @"0评论"];
    [self setImages: [[NSMutableArray alloc] initWithArray: @[
                                                              @"https://hbimg.huabanimg.com/dbb108fc6f4643d1e728de78a685e7acedd5f03a12576f-U8hpJS_fw658"
                                                              ,@"http://meisudci.oss-cn-beijing.aliyuncs.com/bn_thumb/MSBQ53640500096936.jpg?x-oss-process=style/bn_info_thumb"
                                                              ,@"http://meisudci.oss-cn-beijing.aliyuncs.com/bn_thumb/MSBQ67590700070838.jpg?x-oss-process=style/bn_info_thumb"]]];
    [self setTag:SingleImageNewsTag];
    return self;
}



@end
