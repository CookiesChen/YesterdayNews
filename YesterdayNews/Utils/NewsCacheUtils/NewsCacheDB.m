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

+ (BOOL)addNewsWithID:(NSString *)newsID Title:(NSString *)title Author:(NSString *)author Time:(NSString *)time Comments:(NSInteger)comments Images:(NSString *)images {
    NSString *SQL = [[NSString alloc] initWithFormat:@"INSERT INTO NewsCache(ID, title, author, time, comments, images) VALUES ('%@', '%@', '%@', '%@', '%ld', '%@');", newsID, title, author, time, comments, images];
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
                             @"ID": [[NSString alloc] initWithFormat:@"%s", newsID],
                             @"title": [[NSString alloc] initWithFormat:@"%s", title],
                             @"author": [[NSString alloc] initWithFormat:@"%s", author],
                             @"time": [[NSString alloc] initWithFormat:@"%s",time],
                             @"comments": [NSNumber numberWithInt:comments],
                             @"images": [[NSString alloc] initWithFormat:@"%s", images]
                             }];
        }
    } else {
        NSLog(@"[Error] executing SQL: %@", SQL);
    }
    return res;
}

@end
