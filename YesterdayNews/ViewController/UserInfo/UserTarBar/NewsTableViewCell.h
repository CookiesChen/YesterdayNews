//
//  NewsTableViewCell.h
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/28.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../Utils/TimeUtils/TimeUtils.h"
#import "../../../Model/News.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic,strong) News *newsItem;
@property (assign,nonatomic) CGFloat height;

- (void)setFrameWidth:(CGFloat) width;

@end

NS_ASSUME_NONNULL_END
