//
//  AppDelegate.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (){
    MainPageViewController *vc;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    vc = [[MainPageViewController alloc] init];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController: vc];
    
    [self registerAPN];
    return YES;
}

- (void)registerAPN {
    if (@available(iOS 10.0, *)) { // device >= iOS 10
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center setDelegate: (id)self];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                              completionHandler:^(BOOL granted, NSError * _Nullable err) {}];
        
    } else { // device < iOS 10
        UIUserNotificationSettings *setting =
            [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert
                                              categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(nonnull UNNotification *)notification
         withCompletionHandler:(nonnull void (^)(UNNotificationPresentationOptions))completionHandler {
    // whether show the push when app is in the foreground
    UNNotificationRequest *req = notification.request;
    if ([req.trigger isKindOfClass: [UNPushNotificationTrigger class]]) { // remote push
        NSLog(@"Foreground Remote Push");
    } else { // local push
        NSLog(@"Foreground Local Push");
    }
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(nonnull UNNotificationResponse *)response
         withCompletionHandler:(nonnull void (^)(void))completionHandler {
    // callback after user interact with the push
    if ([response.notification.request.trigger isKindOfClass: [UNPushNotificationTrigger class]]) { // remote push
        NSLog(@"Interact Remote Push");
    } else { // local push
        // TODO: jump to the page
        NSLog(@"Interact Local Push");
    }
    completionHandler();
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
