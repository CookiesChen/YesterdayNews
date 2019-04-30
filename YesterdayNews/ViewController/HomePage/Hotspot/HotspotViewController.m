//
//  HotspotViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/21.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "HotspotViewController.h"

@interface HotspotViewController(){
    
}

@end

@implementation HotspotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView{
    [self.view setBackgroundColor: UIColor.whiteColor];
    UILabel *label = [[UILabel alloc] init];
    [label setFrame: CGRectMake(200, 200, 100, 40)];
    [label setText: @"这是热点页"];
    [label setTextColor: UIColor.blackColor];
    
    [self.view addSubview: label];
}

@end
