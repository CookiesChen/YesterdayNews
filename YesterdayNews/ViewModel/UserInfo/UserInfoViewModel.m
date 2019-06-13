//
//  UserInfoViewModel.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "UserInfoViewModel.h"
#import <AFNetworking.h>
#import "../../Model/News.h"

@interface UserInfoViewModel ()

@property(nonatomic, strong) AFHTTPSessionManager *manage;

@end

@implementation UserInfoViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.login = [RACSubject subject];
    self.logout = [RACSubject subject];
    self.reload = [RACSubject subject];
    self.collectionNews = [[NSMutableArray alloc] init];
    self.commentNews = [[NSMutableArray alloc] init];
    self.likeNews = [[NSMutableArray alloc] init];
    self.historyNews = [[NSMutableArray alloc] init];
    self.recommendNews = [[NSMutableArray alloc] init];
    
    self.manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    self.manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    self.manage.responseSerializer = [AFJSONResponseSerializer serializer];
}

- (void)userLogin {
    [self.login sendNext:@"success"];
    NSLog(@"[user login] success");
}

- (void)userLogout {
    [self.logout sendNext:@"success"];
    NSLog(@"[user logout] success");
}

- (void)loadNewsTo: (NSMutableArray*)list withURL: (NSString*)url {
    [self.manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSArray *newData = responseObject[@"data"];
        for(int i = 0; i < [newData count]; i++){
            News *news = [[News alloc] init];
            [news setTitle: newData[i][@"title"]];
            [news setAuthor: newData[i][@"author"]];
            [news setComments: [[NSString alloc] initWithFormat:@"%@", newData[i][@"comments"]]];
            NSTimeInterval interval = [newData[i][@"time"] longLongValue];
            interval /= 1000.0;
            [news setTime: [NSDate dateWithTimeIntervalSince1970: interval]];
            NSData *jsonString = [newData[i][@"image_infos"] dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *dic = [NSJSONSerialization JSONObjectWithData:jsonString
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
            news.images = [[NSMutableArray alloc] init];
            for(int j = 0; j < [dic count]; j++){
                NSString *prefix = dic[j][@"url_prefix"];
                NSString *url = dic[j][@"web_uri"];
                [ news.images addObject: [prefix stringByAppendingString:url]];
            }
            if([news.images count] == 0){
                news.tag = 0;
            } else {
                news.tag = 1;
            }
            [result addObject: news];
        }
        [list removeAllObjects];
        [list addObjectsFromArray:result];
        [self.reload sendNext:@"success"];
        NSLog(@"[load news] success");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[load news] fail: %@", url);
    }];
}

- (void)loadCollectionNews {
    [self loadNewsTo:self.collectionNews withURL:@"http://localhost:3000/news/list/offset=0&&count=5"];
}

- (void)loadCommentNews {
    [self loadNewsTo:self.commentNews withURL:@"http://localhost:3000/news/list/offset=5&&count=5"];
}

- (void)loadLikeNews {
    [self loadNewsTo:self.likeNews withURL:@"http://localhost:3000/news/list/offset=10&&count=5"];
}

- (void)loadHistoryNews{
    [self loadNewsTo:self.historyNews withURL:@"http://localhost:3000/news/list/offset=15&&count=5"];
}

- (void)loadRecommendNews {
    [self loadNewsTo:self.recommendNews withURL:@"http://localhost:3000/news/list/offset=20&&count=5"];
}

@end
