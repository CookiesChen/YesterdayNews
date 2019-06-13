//
//  NewsDetailViewModel.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/5.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsDetailViewModel.h"

@interface NewsDetailViewModel()

@end

@implementation NewsDetailViewModel

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
