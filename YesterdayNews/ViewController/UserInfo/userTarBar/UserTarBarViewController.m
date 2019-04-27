//
//  UserTarBarViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "UserTarBarViewController.h"
#import <ReactiveObjC.h>

@interface UserTarBarViewController ()

@property(nonatomic, strong) UIView *title_label;
@property(nonatomic, strong) UIView *back_button;

@end

@implementation UserTarBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindViewModel];
    
}

// ui布局
- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setTitle:@"test"];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack:)];
    [self.view addSubview: self.title_label];
    [self.view addSubview: self.back_button];
}

// viewmodel绑定
- (void)bindViewModel {
    
}

// 标题Label
- (UILabel *)title_label {
    if(_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 15, self.view.frame.size.width, 30)];
        ((UILabel *)_title_label).textColor = [UIColor blackColor];
        ((UILabel *)_title_label).textAlignment = NSTextAlignmentCenter;
        ((UILabel *)_title_label).font = [UIFont systemFontOfSize:20];
        ((UILabel *)_title_label).text = @"This is a fucking test page";
    }
    return ((UILabel *)_title_label);
}

- (UIButton *)back_button {
    if(_back_button == nil) {
        _back_button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 30, 30)];
        [(UIButton *)_back_button setTitle:@"<" forState:UIControlStateNormal];
        ((UIButton *)_back_button).titleLabel.font = [UIFont systemFontOfSize:20];
        NSMutableAttributedString *str0 = [[NSMutableAttributedString alloc] initWithString:((UIButton *)_back_button).titleLabel.text];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor blackColor] range:[((UIButton *)_back_button).titleLabel.text rangeOfString:((UIButton *)_back_button).titleLabel.text]];
        [(UIButton *)_back_button setAttributedTitle:str0 forState:UIControlStateNormal];
        ((UIButton *)_back_button).titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [[(UIButton *)_back_button rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return ((UIButton *)_back_button);
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
