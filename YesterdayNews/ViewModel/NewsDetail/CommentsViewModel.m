//
//  CommentsViewModel.m
//  YesterdayNews
//
//  Created by chenbb6 on 2019/5/25.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentsViewModel.h"
@interface CommentsViewModel ()

@end

@implementation CommentsViewModel

- (instancetype)init
{
    self = [super init];
    if(self){
        [self initialize];
        
    }
    return self;
}

- (void)initialize {
    self.comments = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [self.comments addObject:[[Comment alloc] init]];
    }
}

@end
