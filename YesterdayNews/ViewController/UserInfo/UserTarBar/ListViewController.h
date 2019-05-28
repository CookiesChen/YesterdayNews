//
//  ListViewController.h
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/29.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../ViewModel/UserInfo/UserInfoViewModel.h"
#import "../../../Model/News.h"
#import "NewsTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController

@property (strong, nonatomic) UserInfoViewModel *viewModel;

@property(nonatomic) NSString *pageTitle;
@property(nonatomic, strong) NSMutableArray* newsList;

- (instancetype)initWithFrame;

@end

NS_ASSUME_NONNULL_END
