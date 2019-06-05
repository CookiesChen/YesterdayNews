//
//  RecommendViewModel.m
//  YesterdayNews
//
//  Created by CookiesChen on 2019/5/2.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "RecommendViewModel.h"
#import "../../../Model/News.h"
#import <AFNetworking.h>
#import "../../../Utils/NewsCacheUtils/NewsCache.h"

@interface RecommendViewModel()

@end

@implementation RecommendViewModel

- (instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.success = [RACSubject subject];
    self.fail = [RACSubject subject];
    self.news = [[NSMutableArray alloc] init];
}

- (void)refreshData {

// Sample code for invoking NewsCache
//    NSMutableArray *result = [[NSMutableArray alloc] init];
//    result = [NewsCache retrieveNewsWithOffset:0 Count:10];

    NSString *url = @"http://localhost:3000/news/list/offset=0&&count=10";
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSArray *newData = responseObject[@"data"];
        for(int i = 0; i < [newData count]; i++){
            News *news = [[News alloc] init];
            [news setTitle: newData[i][@"title"]];
            [news setAuthor: newData[i][@"author"]];
            [news setComments: [[NSString alloc] initWithFormat:@"%@", newData[i][@"comments"]]];
            NSTimeInterval interval = [newData[i][@"time"] longLongValue]/1000;
            [news setTime: [NSDate dateWithTimeIntervalSince1970: interval]];
            //NSArray *imgs = newData[i][@"image_infos"];
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
            if([news.images count] >= 3){
                news.tag = random()%2;
            } else {
                news.tag = 1;
            }
            [result addObject: news];
        }
        [result addObjectsFromArray: self.news];
        self.news = result;
        [self.success sendNext:@"success"];
        NSLog(@"[get news] success");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"[get news] fail");
    }];
}

- (void)refresh {
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(run) object:@"模拟网络请求"];
    thread.name = @"模拟网络请求";
    [thread start];
}

- (void)run {
    // update data
    [NSThread sleepForTimeInterval:2];
    [self.success sendNext:@"success"];
}

@end
