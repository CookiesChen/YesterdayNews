//
//  NewsDetailViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <Colours.h>

@interface NewsDetailViewController()

@end

@implementation NewsDetailViewController

/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self bindViewModel];
}


/* -- progma mark - private methods -- */

//初始化
- (instancetype)init {
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
}

// ui布局
- (void)setupView {
    [self.view setFrame:[UIScreen mainScreen ].bounds];
    [self.view setBackgroundColor: [UIColor whiteColor]];
}

// viewmodel绑定
- (void)bindViewModel {
    
}


/* -- progma mark - UICollectionViewDelegate -- */


/* -- progma mark - getters and setters -- */



@end
