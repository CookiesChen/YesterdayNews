//
//  HomePageViewModel.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface HomePageViewModel : NSObject

@property(nonatomic, strong) RACCommand *onTabBarClick;

@end
