//
//  NewsDetailViewModel.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/5.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsDetailViewModel.h"
#import <UIKit/UIKit.h>
#import "YBImageBrowserTipView.h"
#import "User.h"

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
    /* 获取新闻内容 */
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
    
    /* 获取评论列表 */
    url = [NSString stringWithFormat: @"http://localhost:3000/comment/newsID=%@", [news newsId]];
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *commentsData = [NSArray arrayWithArray: responseObject[@"comments"]];
        [self.comments removeAllObjects];
        for (id commentData in commentsData) {
            Comment *temp = [[Comment alloc] init];
            temp.ThumbUpCount = [NSString stringWithFormat:@"%@",commentData[@"stars"]];
            temp.CommentContent = commentData[@"content"];
            NSTimeInterval interval = [commentData[@"time"] longLongValue]/1000;
            temp.CommentTime = [NSDate dateWithTimeIntervalSince1970:interval];
            temp.UserName = commentData[@"userID"];
            temp.commentID = [NSString stringWithFormat:@"%@",commentData[@"commentID"]];
            temp.UserIcon = [NSString stringWithFormat: @"http://serverIP/image/avatar/%@.png", commentData[@"userID"]];
            [self.comments addObject: temp];
        }
        NSLog(@"commentData:%@", responseObject[@"comments"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[get comments] fail");
    }];
    
    /* 获取我的评论点赞 TODO*/
    
}

- (void)addCommentsWithNewsID:(NSString *)newsID UserID:(NSString *)userID Time:(NSString *)time Content:(NSString *)content
{
    // 查看是否已登陆
    if(![User getInstance].hasLogin) {
        NSLog(@"[LOG] you didn't login");
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"请先登录"];
        return;
    }
    // 发送网络请求添加评论
    NSString *url = @"http://localhost:3000/comment";
    NSDictionary *parameters = @{@"newsID": newsID,
                                 @"userID": userID,
                                 @"time": time,
                                 @"content": content
                                 };
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", [[User getInstance] getToken]];
    [manage.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 如果添加评论成功
        // 更新viewmodel
        Comment *newComment = [[Comment alloc] init];
        newComment.commentID = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
        newComment.UserName = userID;
        NSTimeInterval interval = [time longLongValue]/1000;
        newComment.CommentTime = [NSDate dateWithTimeIntervalSince1970:interval];
        newComment.CommentContent = content;
        [_comments addObject: newComment];
        // 提示框呈现
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"提交评论成功"];
        // 代理响应reloadData方法更新界面
        if ([_commentDelegate respondsToSelector:@selector(reloadCommentData)]) {
            [_commentDelegate reloadCommentData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[LOG] post comments fail");
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"提交评论失败"];
    }];
}

- (void)addThumbUpCountWithCommentID:(NSString *)commentID UserID:(NSString *)userID
{
    // 查看是否已登陆
    if(![User getInstance].hasLogin) {
        NSLog(@"[LOG] you didn't login");
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"请先登录"];
        return;
    }
    // 发送网络请求添加点赞
    NSString *url = @"http://localhost:3000/star/creation";
    NSDictionary *parameters = @{@"userID": userID,
                                 @"commentID": commentID
                                 };
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", [[User getInstance] getToken]];
    [manage.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 如果点赞成功
        // 更新viewmodel
        for (Comment *comment in _comments) {
            if([comment.commentID isEqualToString:commentID]) {
                comment.ThumbUpCount = [NSString stringWithFormat:@"%@", responseObject[@"count"]];
            }
        }
        // 提示框呈现
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"点赞成功"];
        // 代理响应reloadData方法更新界面
        if ([_commentDelegate respondsToSelector:@selector(reloadCommentData)]) {
            [_commentDelegate reloadCommentData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[LOG] post star fail");
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"点赞失败"];
    }];
}

@end
