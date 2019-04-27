//
//  RecommendViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "RecommendViewController.h"
#import "../../Utils/Notification/INotification.h"

@interface RecommendViewController(){
    
}

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView{
    [self.view setBackgroundColor: UIColor.whiteColor];
    UILabel *label = [[UILabel alloc] init];
    [label setFrame: CGRectMake(200, 200, 100, 40)];
    [label setText: @"这是推荐页"];
    [label setTextColor: UIColor.blackColor];
    
    [self.view addSubview: label];
    [self sendMsg];
}

- (void)sendMsg {
    // An invoking notification sample
    if ([INotification checkNotificationEnable]) {
        [INotification sendNotificationWithTitle:@"Attention"
                                        subTitle:@"Here's a notification"
                                            body:@"Congratulations! Notification works!"
                                           delay:[NSDate dateWithTimeIntervalSinceNow: 5]];
    } else {
        [INotification showAlertView];
    }
}

@end
