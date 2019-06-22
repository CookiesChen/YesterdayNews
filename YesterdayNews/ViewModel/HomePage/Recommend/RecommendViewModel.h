//
//  RecommendViewModel.h
//  YesterdayNews
//
//  Created by CookiesChen on 2019/5/2.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface RecommendViewModel : NSObject

@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) RACSubject *success;
@property(nonatomic, strong) RACSubject *fail;

@property(nonatomic, strong) NSMutableArray* news;

- (void)refresh;
- (void)loadMore;
- (void)updateCommentById:(NSString*)newsID andCount:(NSInteger)count;

@end
