//
//  UserInfoViewModel.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "../../Model/User/User.h"

@interface UserInfoViewModel: NSObject

@property(nonatomic, strong) RACSubject *login;
@property(nonatomic, strong) RACSubject *logout;
@property(nonatomic, strong) RACSubject *reload;
//@property(nonatomic, strong) User *currentUser;

@property(nonatomic, strong) NSMutableArray* collectionNews;
@property(nonatomic, strong) NSMutableArray* commentNews;
@property(nonatomic, strong) NSMutableArray* likeNews;
@property(nonatomic, strong) NSMutableArray* historyNews;
@property(nonatomic, strong) NSMutableArray* recommendNews;

- (void)userLogin;
- (void)userLogout;
- (void)loadCollectionNews;
- (void)loadCommentNews;
- (void)loadLikeNews;
- (void)loadHistoryNews;
- (void)loadRecommendNews;
- (void)loadNewsTo: (NSMutableArray*)list withURL: (NSString*)url;

@end
