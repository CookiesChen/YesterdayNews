//
//  AuthorBarCell.h
//  YesterdayNews
//
//  Created by chenbb6 on 2019/6/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef authorBarCell_h
#define authorBarCell_h

#import <UIKit/UIKit.h>

@interface AuthorBarCell : UIView

@property(nonatomic, strong) UIImageView *authorHeadImg;
@property(nonatomic, strong) UILabel *authorName;
@property(nonatomic, strong) UILabel *authorInfo;
@property(nonatomic, strong) UIButton *followButton;

@end
#endif /* AuthorBarCell_h */

