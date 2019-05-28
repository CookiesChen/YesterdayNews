//
//  NewsCacheDB.h
//  YesterdayNews
//
//  Created by xwy on 2019/5/18.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef NewsCacheDB_h
#define NewsCacheDB_h

@interface NewsCacheDB : NSObject

+ (BOOL)addNewsWithID:(NSString *)newsID Title:(NSString *)title Author:(NSString *)author Time:(NSNumber *)time Comments:(NSInteger)comments Images:(NSString *)images;

+ (BOOL)clearCacheDB;

+ (NSMutableArray *)retrieveNewsWithOffset:(NSInteger)offset Count:(NSInteger)count;

@end

#endif /* NewsCacheDB_h */
