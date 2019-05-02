//
//  INotification.h
//  YesterdayNews
//
//  Created by xwy on 2019/4/27.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef INotification_h
#define INotification_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface INotification : NSObject

+ (void)sendNotificationWithTitle:(NSString *)title subTitle:(NSString *)subTitle body:(NSString *)body delay:(NSDate *) time badge:(NSNumber *) badge;

+ (void)removeNotificationwithID:(NSString *)noticeID;

+ (void)removeAllNotification;

+ (BOOL)checkNotificationEnable;

+ (void)showAlertView;

+ (void)goToSystemSetting;

@end

#endif /* INotification_h */
