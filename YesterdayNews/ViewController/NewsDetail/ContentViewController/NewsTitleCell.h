//
//  NewsTitleCell.h
//  YesterdayNews
//
//  Created by chenbb6 on 2019/6/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef NewsTitleCell_h
#define NewsTitleCell_h
#import <UIKit/UIKit.h>

@interface NewsTitleCell : UIView

@property(nonatomic, strong) UILabel *titleContent;

- (void)updateViewByTitle: (NSString *)title;

@end

#endif /* NewsTitleCell.h */


