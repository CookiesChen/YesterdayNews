//
//  NoCommentCell.h
//  YesterdayNews
//
//  Created by 陈冬禹 on 2019/6/22.
//  Copyright © 2019年 Cookieschen. All rights reserved.
//

#ifndef NoCommentCell_h
#define NoCommentCell_h

#import <UIKit/UIKit.h>
#import "../../../Model/Comment/Comment.h"

@interface NoCommentCell : UIView

- (void)updateViewByComment: (NSString *)comment;

@end

#endif /* NoCommentCell_h */
