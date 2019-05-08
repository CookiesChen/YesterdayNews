//
//  RecommendViewModel.m
//  YesterdayNews
//
//  Created by CookiesChen on 2019/5/2.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "RecommendViewModel.h"
#import "../../../Model/News.h"

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
    [self.news addObject: [[News alloc] init]];
    [self.news addObject: [[News alloc] init]];
    [self.news addObject: [[News alloc] init]];
    [self.news addObject: [[News alloc] init]];
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
