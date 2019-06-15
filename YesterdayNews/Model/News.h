//
//  News.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/7.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MultiImagesNewsTag,
    SingleImageNewsTag,
    PureTextNewsTag
} NewsTag;

@interface News : NSObject

@property NSString *newsId;
@property NSString *title;
@property NSString *author;
@property NSDate *time;
@property NSString *comments;
@property NSMutableArray *images;
@property(nonatomic, assign) NewsTag tag;

@end
