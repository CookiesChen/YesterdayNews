//
//  MainPageViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "MainPageViewController.h"
#import "ViewModel/MainPageViewModel.h"
#import "ViewController/HomePage/HomePageViewController.h"
#import "ViewController/UserInfo/UserInfoViewController.h"

#import <ReactiveObjC.h>
#import <Colours.h>

#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

@interface MainPageViewController ()

@property(nonatomic, strong) MainPageViewModel *ViewModel;
@property(nonatomic, strong) HomePageViewController *homeVC;
@property(nonatomic, strong) UserInfoViewController *userVC;

@property(nonatomic, strong) UIView *buttom_bar;
@property(nonatomic, strong) UIButton *selected_button;

@property(nonatomic) NSInteger buttom_bar_height;
@property(nonatomic, strong)NSArray *tags;
@property(nonatomic, strong)NSArray *images;
@property(nonatomic, strong)NSArray *images_sel;
@end

@implementation MainPageViewController

/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialize];
    [self setupView];
    [self bindViewModel];
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
    self.buttom_bar_height = HEIGHT*0.1;
}


// UI布局
- (void)setupView {
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [self.tabBar setHidden: YES];
    
    [self.view addSubview: self.buttom_bar];
    self.viewControllers = @[self.homeVC, self.userVC];
}


// viewmodel绑定
- (void)bindViewModel {
    self.ViewModel = [[MainPageViewModel alloc] init];
}


/* -- progma mark - getters and setters -- */
- (HomePageViewController *)homeVC {
    if(_homeVC == nil){
        _homeVC = [[HomePageViewController alloc] init];
        [_homeVC.view setFrame: CGRectMake(0, 0, WIDTH, HEIGHT - self.buttom_bar_height)];
    }
    return _homeVC;
}

- (UserInfoViewController *)userVC {
    if(_userVC == nil){
        _userVC = [[UserInfoViewController alloc] init];
        [_userVC.view setFrame: CGRectMake(0, 0, WIDTH, HEIGHT - self.buttom_bar_height)];
    }
    return _userVC;
}

- (UIView *)buttom_bar {
    self.tags = @[@"首页", @"我的"];
    self.images = @[@"icon_home", @"icon_user"];
    self.images_sel = @[@"icon_home_sel", @"icon_user_sel"];
    if(_buttom_bar == nil){
        _buttom_bar = [[UIView alloc]
                       initWithFrame:CGRectMake(0, HEIGHT - self.buttom_bar_height, WIDTH, self.buttom_bar_height)];
        [_buttom_bar setBackgroundColor: [UIColor whiteColor]];
        
        CGFloat bar_width = WIDTH;
        CGFloat bar_height = self.buttom_bar_height;
        NSInteger count = self.tags.count;
        for(int i = 0; i < count; i++){
            CGFloat itemWidth = bar_width / count;
            CGFloat width = itemWidth * 0.4;
            CGFloat height = bar_height * 0.5;
            CGFloat x = (itemWidth-width)/2 + i * itemWidth;
            CGFloat y = (bar_height - height)/4;
            
            UIButton *button = [[UIButton alloc] init];
            [button setTitle: self.tags[i] forState: UIControlStateNormal];
            [button setAdjustsImageWhenHighlighted: NO];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setFrame: CGRectMake(x, y, width, height)];
            // 未选中
            [button setTitleColor:[UIColor black75PercentColor] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
            // 选中
            [button setTitleColor:[UIColor infoBlueColor] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:self.images_sel[i]] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor infoBlueColor] forState:UIControlStateSelected | UIControlStateHighlighted];
            [button setImage:[UIImage imageNamed:self.images_sel[i]] forState:UIControlStateSelected | UIControlStateHighlighted];
            
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView.frame.size.width, -button.imageView.frame.size.height-10, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height, 0, 0, -button.titleLabel.intrinsicContentSize.width);
            // 点击事件
            [[button rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
                if(x.tag == self.selected_button.tag) return;
                // 动画
                CATransition *animation = [CATransition animation];
                [animation setDuration: 0.2f];
                [animation setType: kCATransitionMoveIn];
                if(x.tag > self.selected_button.tag){
                    [animation setSubtype:kCATransitionFromRight];
                } else {
                    [animation setSubtype:kCATransitionFromLeft];
                }
                [animation setTimingFunction: [CAMediaTimingFunction functionWithName:
                                               kCAMediaTimingFunctionEaseInEaseOut]];
                [[[self valueForKey:@"_viewControllerTransitionView"]layer] addAnimation:animation forKey:@"changeView"];
                
                // 标签状态
                [x setSelected: YES];
                [self.selected_button setSelected: NO];
                self.selected_button = x;
                [self setSelectedIndex: x.tag];
            }];
            
            [button setTag: i];
            [_buttom_bar addSubview: button];
            
            if(i == 0){
                [button setSelected: YES];
                self.selected_button = button;
            }
        }
    }
    return _buttom_bar;
}

@end
