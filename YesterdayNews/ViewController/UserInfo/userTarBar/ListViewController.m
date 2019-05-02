//
//  ListViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/29.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@property(nonatomic, strong) UILabel *title_label;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: self.title_label];
}

// 标题Label
- (UILabel *)title_label {
    if(_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
        _title_label.textColor = [UIColor blackColor];
        _title_label.textAlignment = NSTextAlignmentCenter;
        _title_label.font = [UIFont systemFontOfSize:20];
        _title_label.text = [NSString stringWithFormat:@"This is a fucking %@ page", self.pageTitle];
    }
    return _title_label;
}

@end
