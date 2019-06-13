//
//  NewsDetailViewModel.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/5.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef NewsDetailViewModel_h
#define NewsDetailViewModel_h

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import <AFNetworking.h>
#import "../../Model/News.h"
#import "../../Model/Comment/Comment.h"

@protocol CommentDelegate <NSObject>

@required
- (void)reloadCommentData;

@end

@interface NewsDetailViewModel : NSObject

@property(nonatomic, strong) NSString *newsID;
@property(nonatomic, strong) NSMutableArray *comments;
@property(nonatomic, strong) NSString *htmlString;
@property(nonatomic, strong) NSString *newsTitle;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *author;

@property(nonatomic, weak) id<CommentDelegate> commentDelegate;

- (void)setNews:(News *)news;
- (void)addCommentsWithNewsID:(NSString *)newsID UserID:(NSString *)userID Time:(NSString *)time Content:(NSString *)content;
- (void)addThumbUpCountWithCommentID:(NSString *)commentID UserID:(NSString *)userID;
@end

#endif /* NewsDetailViewModel_h */
