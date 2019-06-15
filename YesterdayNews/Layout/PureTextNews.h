//
//  PureTextNews.h
//  YesterdayNews
//
//  Created by 陈冬禹 on 2019/6/15.
//  Copyright © 2019年 Cookieschen. All rights reserved.
//

#ifndef PureTextNews_h
#define PureTextNews_h

#import <UIKit/UIKit.h>
#import "../Model/News.h"

@interface PureTextNews : UIView

- (instancetype)initWithFrame:(CGRect)frame andNews:(News *)news;

+ (CGFloat)itemHeight;
@end

#endif /* PureTextNews_h */
