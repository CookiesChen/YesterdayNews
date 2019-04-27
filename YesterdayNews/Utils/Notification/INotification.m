//
//  INotification.m
//  YesterdayNews
//
//  Created by student6 on 2019/4/27.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INotification.h"
#import <UserNotifications/UserNotifications.h>

@implementation INotification

+ (void)sendNotificationWithTitle:(NSString *)title subTitle:(NSString *)subTitle body:(NSString *)body delay:(NSDate *) time; {
    [self removeNotificationwithID:@"noticeID"];
    if (@available(iOS 10.0, *)) { // device >= iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = title;
        content.subtitle = subTitle;
        content.body = body;
        content.sound = [UNNotificationSound defaultSound];
        content.badge = @1;
        UNTimeIntervalNotificationTrigger *trigger =
            [UNTimeIntervalNotificationTrigger triggerWithTimeInterval: [time timeIntervalSinceNow]
                                                               repeats: NO];
        
        NSString *identifier = @"noticeID";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                              content:content
                                                                              trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable err) {
            if (nil == err) {
                NSLog(@"Notify successfully");
            } else {
                NSLog(@"%@", err);
            }
        }];
    } else { // device < iOS 10
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate = time;
        notification.alertBody = body;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.userInfo = @{@"noticeID": @"00001"};
        notification.applicationIconBadgeNumber = 1;
    }
}

+ (void)removeNotificationwithID:(NSString *)noticeID {
    if (@available(iOS 10.0, *)) { // device >= iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removePendingNotificationRequestsWithIdentifiers:@[noticeID]];
    } else { // device < iOS 10
        NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
        for (UILocalNotification *notify in arr) {
            NSDictionary  *userInfo = notify.userInfo;
            NSString *notifyID = [userInfo objectForKey:@"noticeID"];
            if ([notifyID isEqualToString:noticeID]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notify];
            }
        }
    }
}

+ (void)removeAllNotification {
    if (@available(iOS 10.0, *)) { // device >= iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
    } else { // device < iOS 10
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
}

+ (BOOL)checkNotificationEnable {
    __block BOOL isOn = YES;
    if (@available(iOS 10.0, *)) { // device >= iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *_Nonnull setting) {
            if (setting.notificationCenterSetting != UNNotificationSettingEnabled) {
                isOn = NO;
            }
        }];
    } else { // device < iOS 10
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
            isOn = NO;
        }
    }
    return isOn;
}

+ (void)showAlertView {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle: @"通知"
                                                                   message: @"未获得通知权限，请前往设置。"
                                                            preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle: @"取消"
                                              style: UIAlertActionStyleCancel
                                            handler: nil]];
    [alert addAction:[UIAlertAction actionWithTitle: @"设置"
                                              style: UIAlertActionStyleDefault
                                            handler: ^(UIAlertAction *_Nonnull action) {
                                                [self goToSystemSetting];
                                            }]];
    
}

+ (void)goToSystemSetting {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([application canOpenURL: url]) {
            if (@available(iOS 10.0, *)) { // device >= iOS 10
                if  ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                    [application openURL:url options:@{} completionHandler:nil];
                }
            } else { // device < iOS 10
                [application openURL:url];
            }
        }
    });
}

@end
