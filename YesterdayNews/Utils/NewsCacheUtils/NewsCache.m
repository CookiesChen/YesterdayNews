//
//  NewsCache.m
//  YesterdayNews
//
//  Created by xwy on 2019/5/18.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#import "NewsCacheDB.h"
#import "NewsCache.h"

#define CONST_COUNT @10

@implementation NewsCache

+ (BOOL)clearCache {
    return [NewsCacheDB clearCacheDB];
}

+ (NSMutableArray *)retrieveNewsWithOffset:(NSInteger)offset Count:(NSInteger)count {
    NSMutableArray *res = [NewsCacheDB retrieveNewsWithOffset:offset Count:count];
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://localhost:3000/news/list/offset=%ld&&count=%@", offset + [res count], CONST_COUNT];
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    // 设置请求体为JSON
    manage.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置响应体为JSON
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    [manage GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *newsData = responseObject[@"data"];
        for (id n in newsData) {
            [NewsCacheDB addNewsWithID:n[@"group_id"] Title:n[@"title"] Author:n[@"author"] Time:n[@"time"] Comments:(NSInteger)n[@"comments"] Images:n[@"images_info"]];
        }
        NSLog(@"[get news] success");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        NSLog(@"[get news] fail, msg:%@", response[@"message"]);
    }];
    return res;
}

@end
