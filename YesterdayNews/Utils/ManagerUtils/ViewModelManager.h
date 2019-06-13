//
//  ViewModelManager.h
//  YesterdayNews
//
//  Created by Cookieschen on 2019/6/1.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef ViewModelManager_h
#define ViewModelManager_h

#import <Foundation/Foundation.h>
#import "../../ViewModel/UserInfo/UserInfoViewModel.h"
#import "../../ViewModel/HomePage/Recommend/RecommendViewModel.h"
#import "../../ViewModel/NewsDetail/NewsDetailViewModel.h"
#import "../../ViewModel/UserInfo/ProfileViewModel/ProfileViewModel.h"

@interface ViewModelManager : NSObject

+ (instancetype)getManager;
- (id)getViewModel:(NSString *)name;

@end

#endif /* ViewModelManager_h */
