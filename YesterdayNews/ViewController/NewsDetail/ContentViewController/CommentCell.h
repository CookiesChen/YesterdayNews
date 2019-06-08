//
//  CommentCell.h
//  YesterdayNews
//
//  Created by chenbb6 on 2019/5/24.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef CommentCell_h
#define CommentCell_h

#import <UIKit/UIKit.h>
#import "../../../Model/Comment/Comment.h"

@interface CommentCell : UIView

@property(nonatomic, strong) UIImageView *user_icon;
@property(nonatomic, strong) UILabel *user_name;
@property(nonatomic, strong) UILabel *comment_content;
@property(nonatomic, strong) UIImageView *thumb_up_icon;
@property(nonatomic, strong) UILabel *thumb_up_count;
@property(nonatomic, strong) UILabel *comment_time;
@property(nonatomic, strong) Comment* comment;

- (void)updateViewByComment: (Comment *)comment;

@end
#endif /* CommentCell_h */
