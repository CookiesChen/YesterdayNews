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

+ (BOOL)addNewsWithID:(NSString *)newsID Title:(NSString *)title Author:(NSString *)author Time:(NSString *)time Comments:(int)comments Images:(NSString *)images;

+ (BOOL)updateNewsComments:(NSInteger)comments WithID:(NSString *)newsID;

+ (BOOL)clearCacheDB;

+ (NSMutableArray *)retrieveNewsWithOffset:(NSInteger)offset Count:(NSInteger)count;

+ (int)countCache;

@end

#endif /* NewsCacheDB_h */
