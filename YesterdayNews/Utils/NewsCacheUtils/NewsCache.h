//
//  NewsCache.h
//  YesterdayNews
//
//  Created by xwy on 2019/5/18.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef NewsCache_h
#define NewsCache_h

@interface NewsCache : NSObject

+ (BOOL)clearCache;

+ (NSMutableArray *)retrieveNewsWithOffset:(NSInteger)offset Count:(NSInteger)count;

@end

#endif /* NewsCache_h */
