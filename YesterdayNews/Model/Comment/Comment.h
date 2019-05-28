//
//  Comment.h
//  YesterdayNews
//
//  Created by chenbb6 on 2019/5/25.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef Comment_h
#define Comment_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Comment : NSObject

@property(nonatomic, strong) NSString *UserIcon;
@property(nonatomic, strong) NSString *UserName;
@property(nonatomic, strong) NSString *CommentContent;
@property(nonatomic, strong) NSString *ThumbUpIcon;
@property(nonatomic, strong) NSString *ThumbUpCount;
@property(nonatomic, strong) NSDate *CommentTime;
@property CGFloat CellHight;

@end

#endif /* Comment_h */
