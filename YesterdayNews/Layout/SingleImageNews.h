//
//  SingleImageNews.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef SingleImageNews_h
#define SingleImageNews_h

#import <UIKit/UIKit.h>
#import "../Model/News.h"

@interface SingleImageNews : UIView

- (instancetype)initWithFrame:(CGRect)frame andNews:(News *)news;

@end

#endif /* SingleImageNews_h */
