//
//  IDBManager.m
//  YesterdayNews
//
//  Created by xwy on 2019/5/18.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDBManager.h"

static IDBManager* _instance = nil;

@implementation IDBManager

+ (IDBManager *)getInstance {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[self.class alloc] init];
        [_instance openDB];
    });
    return _instance;
}
- (BOOL)openDB {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *DBPath = [documentPath stringByAppendingPathComponent:@"newsCache.sqlite"];
    NSLog(@"%@", DBPath);
    if (sqlite3_open(DBPath.UTF8String, &_db) != SQLITE_OK) {
        NSLog(@"[Error] opening DB: %s", DBPath.UTF8String);
        return NO;
    } else {
        NSString *createUserTable =
        @"CREATE TABLE IF NOT EXISTS NewsCache ("
        "ID VARCHAR(30) NOT NULL PRIMARY KEY,"
        "title TEXT NOT NULL,"
        "author TEXT NOT NULL,"
        "time TEXT NOT NULL,"
        "comments INT DEFAULT 0,"
        "images JSON)";
        return [self execSQL:createUserTable];
    }
}
- (BOOL)execSQL:(NSString *)SQL {
    char *err;
    if (sqlite3_exec(_db, SQL.UTF8String, nil, nil, &err) == SQLITE_OK) {
        return YES;
    } else {
        NSLog(@"[Error] executing SQL: %@", SQL);
        NSLog(@"[Error] err: %s", err);
        return NO;
    } }
@end
