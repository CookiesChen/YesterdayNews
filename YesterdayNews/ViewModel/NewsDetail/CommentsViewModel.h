//
//  CommentsViewModel.h
//  YesterdayNews
//
//  Created by chenbb6 on 2019/5/25.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef CommentsViewModel_h
#define CommentsViewModel_h

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "../../Model/Comment/Comment.h"
@interface CommentsViewModel : NSObject

@property(nonatomic, strong) NSMutableArray* comments;

@end

#endif /* CommentsViewModel_h */
