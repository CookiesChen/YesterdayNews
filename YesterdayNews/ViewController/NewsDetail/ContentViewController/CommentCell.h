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

- (void)updateViewByComment: (Comment *)comment;

@end
#endif /* CommentCell_h */
