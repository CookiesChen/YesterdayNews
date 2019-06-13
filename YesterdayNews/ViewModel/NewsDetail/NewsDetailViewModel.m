//
//  NewsDetailViewModel.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/5.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsDetailViewModel.h"

@interface NewsDetailViewModel()

@end

@implementation NewsDetailViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        [self initialize];
        
    }
    return self;
}

- (void)initialize {
    self.comments = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 8; i++) {
//        [self.comments addObject:[[Comment alloc] init]];
//    }
}

- (void)setNews:(News *)news {
    self.newsTitle = [news title];
    self.author = [news author];
    self.newsID = [news newsId];
    NSString *url = [NSString stringWithFormat: @"http://localhost:3000/news/content/id=%@", [news newsId]];
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.htmlString = responseObject[@"data"][@"content"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[get content] fail");
    }];
    url = [NSString stringWithFormat: @"http://localhost:3000/comment/newsID=%@", [news newsId]];
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *commentsData = [NSArray arrayWithArray: responseObject[@"comments"]];
        [self.comments removeAllObjects];
        for (id commentData in commentsData) {
            Comment *temp = [[Comment alloc] init];
            temp.ThumbUpCount = [NSString stringWithFormat:@"%.0f",commentData[@"stars"]];
            temp.CommentContent = commentData[@"content"];
            NSTimeInterval interval = [commentData[@"time"] longLongValue]/1000;
            temp.CommentTime = [NSDate dateWithTimeIntervalSince1970:interval];
            temp.UserName = commentData[@"userID"];
            temp.commentID = [NSString stringWithFormat:@"%.0f",commentData[@"commentID"]];
            temp.UserIcon = [NSString stringWithFormat: @"http://serverIP/image/avatar/%@.png", commentData[@"userID"]];
            [self.comments addObject: temp];
        }
        NSLog(@"commentData:%@", responseObject[@"comments"]);
//        for(id comment in responseObject[@"comments"]) {
//            Comment temp = [[Comment alloc] init];
//            temp.ThumbUpCount = [NSString stringWithFormat:@"%f", comment.stars]
//            [self.comments]
//
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[get comments] fail");
    }];
}

@end
