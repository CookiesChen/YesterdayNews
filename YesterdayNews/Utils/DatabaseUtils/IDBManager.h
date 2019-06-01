//
//  IDBManager.h
//  YesterdayNews
//
//  Created by xwy on 2019/5/18.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef IDBManager_h
#define IDBManager_h
#import <sqlite3.h>

@interface IDBManager : NSObject

@property(nonatomic, assign) sqlite3 *db;

+ (IDBManager *)getInstance;

- (BOOL)openDB;

- (BOOL)execSQL:(NSString *)SQL;

@end

#endif /* IDBManager_h */
