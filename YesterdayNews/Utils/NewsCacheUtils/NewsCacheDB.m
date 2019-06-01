//
//  NewsCacheDB.m
//  YesterdayNews
//
//  Created by xwy on 2019/5/18.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCacheDB.h"
#import "../DatabaseUtils/IDBManager.h"

@implementation NewsCacheDB

+ (BOOL)addNewsWithID:(NSString *)newsID Title:(NSString *)title Author:(NSString *)author Time:(NSString *)time Comments:(int)comments Images:(NSString *)images {
    NSString *SQL = [[NSString alloc] initWithFormat:@"INSERT INTO NewsCache(ID, title, author, time, comments, images) VALUES ('%@', '%@', '%@', '%@', '%d', '%@');", newsID, title, author, time, comments, images];
    return [[IDBManager getInstance] execSQL:SQL];
}

+ (BOOL)clearCacheDB {
    NSString *SQL = @"DELETE FROM NewsCache;";
    return [[IDBManager getInstance] execSQL:SQL];
}

+ (NSMutableArray *)retrieveNewsWithOffset:(NSInteger)offset Count:(NSInteger)count {
    NSMutableArray *res = [[NSMutableArray alloc] init];
    NSString *SQL = [[NSString alloc] initWithFormat:@"SELECT * FROM NewsCache ORDER BY time LIMIT %ld OFFSET %ld;", count, offset];
    sqlite3_stmt *stmt = NULL;
    // precheck for the query
    if (sqlite3_prepare_v2([[IDBManager getInstance] db], SQL.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        // Every time sqlite3_step invoked, stmt links to a new result record
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *newsID = sqlite3_column_text(stmt, 0);
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *author = sqlite3_column_text(stmt, 2);
            const unsigned char *time = sqlite3_column_text(stmt, 3);
            int comments = sqlite3_column_int(stmt, 4);
            const unsigned char *images = sqlite3_column_text(stmt, 5);
            
            [res addObject:@{
                             @"ID": [NSString stringWithUTF8String:newsID],
                             @"title": [NSString stringWithUTF8String:title],
                             @"author": [NSString stringWithUTF8String:author],
                             @"time": [NSString stringWithUTF8String:time],
                             @"comments": [NSNumber numberWithInt:comments],
                             @"images": [NSString stringWithUTF8String:images]
                             }];
        }
    } else {
        NSLog(@"[Error] executing SQL: %@", SQL);
    }
    return res;
}

+ (int)countCache {
    int count = 0;
    NSString *SQL = @"SELECT COUNT(*) FROM NewsCache;";
    sqlite3_stmt *stmt = NULL;
    // precheck for the query
    if (sqlite3_prepare_v2([[IDBManager getInstance] db], SQL.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        // Every time sqlite3_step invoked, stmt links to a new result record
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            count = sqlite3_column_int(stmt, 0);
        }
    } else {
        NSLog(@"[Error] executing SQL: %@", SQL);
    }
    return count;
}

@end
