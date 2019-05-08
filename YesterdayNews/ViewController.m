//
//  ViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ViewController.h"
#import "MainPageViewController.h"

@interface ViewController()

@end

@implementation ViewController

/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

/* -- progma mark - private methods -- */
// 初始化
- (instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
}

// UI布局
- (void)setupView {
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [self pushViewController:[[MainPageViewController alloc] init] animated:YES];
    [self setNavigationBarHidden:YES animated:NO];
}

@end
