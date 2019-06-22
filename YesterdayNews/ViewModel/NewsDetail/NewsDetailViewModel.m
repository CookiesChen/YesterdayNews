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
#import "ViewModelManager.h"
#import "../../Utils/NewsCacheUtils/NewsCacheDB.h"

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
    self.myStarComments = [[NSMutableArray alloc] init];
}

- (void)setNews:(News *)news {
    self.newsTitle = [news title];
    self.author = [news author];
    self.newsID = [news newsId];
    
    // 获取新闻内容
    [self getNewsDetail: news];
    
    // 获取新闻评论列表
    [self getCommentList: news];
    
    // 获取我点赞过的评论列表
    [self getMyStarCommentList: [[User getInstance] getUsername]];
}

/* 获取新闻详情内容 */
- (void)getNewsDetail:(News *)news
{
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
}


/* 提交评论 */
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
        // 添加评论成功
        Comment *newComment = [[Comment alloc] init];
        newComment.commentID = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
        newComment.UserName = userID;
        NSTimeInterval interval = [time longLongValue]/1000;
        newComment.CommentTime = [NSDate dateWithTimeIntervalSince1970:interval];
        newComment.CommentContent = content;
        ProfileViewModel *ViewModel = [[ViewModelManager getManager] getViewModel: @"ProfileViewModel"];
        //NSInteger count = [(News)responseObject[@"news"] ]
        newComment.UserIcon = ViewModel.userIconUrl;
        [self.comments addObject: newComment];
        // 提示框呈现
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"提交评论成功"];
        // 代理响应reloadData方法更新界面
        if ([self.commentDelegate respondsToSelector:@selector(reloadCommentData)]) {
            [self.commentDelegate reloadCommentData];
        }
        // 更新缓存和推荐页面评论
        NSInteger commentCount = [responseObject[@"news"][@"comments"] integerValue];
        BOOL temp = [NewsCacheDB updateNewsComments:commentCount WithID: newsID];
        RecommendViewModel *recommendVM = [[ViewModelManager getManager] getViewModel: @"RecommendViewModel"];
        [recommendVM updateCommentById: newsID andCount: commentCount];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[LOG] post comments fail");
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"提交评论失败"];
    }];
}

/* 提交点赞 */
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
        // 如果点赞成功,更新viewmodel
        // 评论队列comments修改点赞数
        for (Comment *comment in self.comments) {
            if([comment.commentID isEqualToString:commentID]) {
                comment.ThumbUpCount = [NSString stringWithFormat:@"%@", responseObject[@"count"]];
            }
        }
        // 我点赞过的评论队列要添加这个评论
        Comment *newStarComment = [[Comment alloc] init];
        newStarComment.commentID = commentID;
        [self.myStarComments addObject:newStarComment];
        // 提示框呈现
        [[UIApplication sharedApplication].keyWindow yb_showHookTipView:@"点赞成功"];
        // 代理响应reloadData方法更新界面
        if ([self.commentDelegate respondsToSelector:@selector(reloadCommentData)]) {
            [self.commentDelegate reloadCommentData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[LOG] post star fail");
        [[UIApplication sharedApplication].keyWindow yb_showForkTipView:@"点赞失败"];
    }];
}


/* 获取新闻评论列表 */
- (void)getCommentList:(News *)news
{
    // AFNetManager
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 添加cookie-token
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", [[User getInstance] getToken]];
    [manage.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 设置url
    NSString *url = [NSString stringWithFormat: @"http://localhost:3000/comment/newsID=%@", [news newsId]];
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功回调
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
            temp.UserIcon = [NSString stringWithFormat: @"http://localhost:3000/image/avatar/%@.png", commentData[@"userID"]];
            [self.comments addObject: temp];
        }
        NSLog(@"[LOG] commentData:%@", responseObject[@"comments"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败回调
        NSLog(@"[LOG] get comments fail");
    }];
}

/* 获取我的点赞评论 */
- (void)getMyStarCommentList: (NSString*) username
{
    // AFNetManager
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 添加cookie-token
    NSString *cookieStr = [NSString stringWithFormat:@"Bearer %@", [[User getInstance] getToken]];
    [manage.requestSerializer setValue: cookieStr forHTTPHeaderField:@"Authorization"];
    // 设置url
    NSString *url = [NSString stringWithFormat: @"http://localhost:3000/star/comments/username=%@", username];
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功回调
        NSArray *commentsData = [NSArray arrayWithArray: responseObject[@"data"]];
        [self.myStarComments removeAllObjects];
        for (id commentData in commentsData) {
            Comment *temp = [[Comment alloc] init];
            temp.ThumbUpCount = [NSString stringWithFormat:@"%@",commentData[@"stars"]];
            temp.CommentContent = commentData[@"content"];
            NSTimeInterval interval = [commentData[@"time"] longLongValue]/1000;
            temp.CommentTime = [NSDate dateWithTimeIntervalSince1970:interval];
            temp.UserName = commentData[@"userID"];
            temp.commentID = [NSString stringWithFormat:@"%@",commentData[@"commentID"]];
            temp.UserIcon = [NSString stringWithFormat: @"http://localhost:3000/image/avatar/%@.png", commentData[@"userID"]];
            [self.myStarComments addObject: temp];
        }
        NSLog(@"[LOG] myStarComments:%@", responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 失败回调
        NSLog(@"[LOG] get starComments fail");
    }];
}

@end
