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
#import "../../Model/Comment/Comment.h"

@interface NewsDetailViewModel : NSObject

@property(nonatomic, strong) NSMutableArray *comments;
@property(nonatomic, strong) NSString *htmlString;
@property(nonatomic, strong) NSString *newsTitle;
@property(nonatomic, strong) NSString *avatar;
@property(nonatomic, strong) NSString *t;

@end

#endif /* NewsDetailViewModel_h */
