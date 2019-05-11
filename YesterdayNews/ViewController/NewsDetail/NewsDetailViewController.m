//
//  NewsDetailViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <Colours.h>
#import <ReactiveObjC.h>


@interface NewsDetailViewController()

@property(nonatomic, strong) UIToolbar *topBar;
@property(nonatomic, strong) UIButton *backButton;
@property(nonatomic, strong) UIImage *topImg;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, strong) UIButton *moreButton;
@property(nonatomic, strong) NSMutableArray<UIBarButtonItem*> *itemArr;

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
    [self.view addSubview:self.topBar];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.searchButton];
    [self.view addSubview:self.moreButton];
}

// viewmodel绑定
- (void)bindViewModel {
    
}

- (UIButton *)backButton {
    if(_backButton == nil) {
        _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 30, 30)];
        [_backButton setTitle:@"<" forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:20];
        NSMutableAttributedString *str0 = [[NSMutableAttributedString alloc] initWithString:_backButton.titleLabel.text];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor blackColor] range:[_backButton.titleLabel.text rangeOfString:((UIButton *)_backButton).titleLabel.text]];
        [_backButton setAttributedTitle:str0 forState:UIControlStateNormal];
        _backButton.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [[_backButton rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _backButton;
}

- (UIToolbar *)topBar {
    if(_topBar == nil) {
        [self.navigationController setToolbarHidden:NO animated:YES];
        _topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 50, 600, 30)];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
        UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
        _itemArr = [[NSMutableArray alloc]initWithObjects:backItem, searchItem, nil];
        [_topBar setItems:_itemArr];
    }
    return _topBar;
}

/* -- progma mark - UICollectionViewDelegate -- */


/* -- progma mark - getters and setters -- */



@end
