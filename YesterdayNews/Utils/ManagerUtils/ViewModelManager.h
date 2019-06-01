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
#import "../../ViewModel/HomePage/Recommend/RecommendViewModel.h"

@interface ViewModelManager : NSObject

+ (instancetype)getManager;
- (id)getViewModel:(NSString *)name;

@end

#endif /* ViewModelManager_h */
