//
//  UserTarBarViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "UserTarBarViewController.h"
#import "ListViewController.h"
#import <ReactiveObjC.h>
#define BUTTON_TAG 100

@interface UserTarBarViewController ()

@property(nonatomic, strong) UILabel *title_label;
@property(nonatomic, strong) UIButton *back_button;
@property(nonatomic, strong) UIView *separator_line1;
@property(nonatomic, strong) UIView *button_group;
@property(nonatomic, strong) UIView *separator_line2;
@property(nonatomic, strong) UIView *red_line;  // 颜色指示器
@property(nonatomic, strong) NSArray<NSString *> *titleArr;

@property(nonatomic, strong) ListViewController *collectionVC;
@property(nonatomic, strong) ListViewController *commentVC;
@property(nonatomic, strong) ListViewController *likeVC;
@property(nonatomic, strong) ListViewController *historyVC;
@property(nonatomic, strong) ListViewController *recommendVC;

@end

@implementation UserTarBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindViewModel];
    
}

- (instancetype)initWithViewModel: (UserInfoViewModel*)viewModel {
    self = [super init];
    if(self){
        self.viewModel = viewModel;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.titleArr = @[@"收藏", @"评论", @"点赞", @"历史", @"推送"];
}


// ui布局
- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setTitle:@"test"];
    [self.view addSubview:self.separator_line1];
    [self.view addSubview: self.back_button];
    [self.view addSubview:self.separator_line2];
    [self.view addSubview:self.button_group];
    [self addButtons];
    [self.view addSubview: self.pageVC.view];
    [self addChildViewController: self.pageVC];
    [self.button_group addSubview:self.red_line];
}

// viewmodel绑定
- (void)bindViewModel {
    [self.viewModel loadCommentNews];
    [self.viewModel loadCollectionNews];
    [self.viewModel loadLikeNews];
    [self.viewModel loadHistoryNews];
    //[self.viewModel loadRecommendNews];
}

- (void)setCurrentPage:(NSInteger) index {
    self.current_index = index;
    [self changeButtonSelected];
    [self changeToCurrentIndexPage:UIPageViewControllerNavigationDirectionForward];
}

- (void) changeButtonSelected {
    for (int i = 0; i < self.titleArr.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:BUTTON_TAG + i];
        [btn setSelected:NO];
    }
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:BUTTON_TAG + self.current_index];
    [btn setSelected:YES];
    CGRect frame = CGRectMake(btn.frame.origin.x + 20, btn.frame.origin.y + 32, btn.frame.size.width - 40, 2);
    [self moveRedLine:frame];
}

- (void)moveRedLine:(CGRect)frame {
    [UIView animateWithDuration:0.3 animations:^{
        [self.red_line setFrame:frame];
    }];
}

- (void) changeToCurrentIndexPage:(NSInteger) direction {
    [self.pageVC setViewControllers:@[self.pages[self.current_index]] direction:direction animated:YES completion:^(BOOL finished){
        // emmm......
    }];
}

- (UIPageViewController *)pageVC {
    if(_pageVC == nil){
        //_pageVC = [[UIPageViewController alloc] init];
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        _pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        //_pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        [_pageVC.view setFrame: CGRectMake(0, 130, self.view.frame.size.width, self.view.frame.size.height - 130)];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    return _pageVC;
}

// buttons
- (UIView *)button_group {
    if(_button_group == nil){
        _button_group = [[UIView alloc] initWithFrame:CGRectMake(0, 86, self.view.frame.size.width, 40)];
    }
    return _button_group;
}

- (void)addButtons {
    int btnWidth = self.view.frame.size.width / self.titleArr.count;
    for(int i = 0; i < self.titleArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth * i, 5, btnWidth, 30);
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.tag = i + BUTTON_TAG;               // tag
        btn.selected = NO;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        //[btn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
        [[btn rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            for (int i = 0; i < self.titleArr.count; i++) {
                //UIButton *btn = (UIButton *)[[sender superview]viewWithTag:BUTTON_TAG + i];
                UIButton *btn = (UIButton *)[self.view viewWithTag:BUTTON_TAG + i];
                [btn setSelected:NO];
            }
            [x setSelected:YES];
            CGRect frame = CGRectMake(x.frame.origin.x + 20, x.frame.origin.y + 32, x.frame.size.width - 40, 2);
            [self moveRedLine:frame];
            
            // pageViewController
            NSInteger index = x.tag - BUTTON_TAG;
            if(self.current_index != index){
                NSInteger direction;
                if(self.current_index < index){
                    direction = UIPageViewControllerNavigationDirectionForward;
                } else {
                    direction = UIPageViewControllerNavigationDirectionReverse;
                }
                self.current_index = index;
                [self.pageVC setViewControllers:@[self.pages[self.current_index]] direction:direction animated:YES completion:^(BOOL finished){
                    //self->_current_index = index;
                }];
            }
        
            //self.current_index = x.tag - BUTTON_TAG;
        }];
        
        [self.button_group addSubview:btn];
    }
}

// 标题Label
- (UILabel *)title_label {
    if(_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 15, self.view.frame.size.width, 30)];
        _title_label.textColor = [UIColor blackColor];
        _title_label.textAlignment = NSTextAlignmentCenter;
        _title_label.font = [UIFont systemFontOfSize:20];
        _title_label.text = @"This is a fucking test page";
    }
    return _title_label;
}

- (UIButton *)back_button {
    if(_back_button == nil) {
        _back_button = [[UIButton alloc] initWithFrame:CGRectMake(30, 50, 20, 20)];
        _back_button.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [_back_button setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:normal];
        [[_back_button rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _back_button;
}

// 分割线
- (UIView *)separator_line1 {
    if(_separator_line1 == nil){
        _separator_line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, 1)];
        [_separator_line1 setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    }
    return _separator_line1;
}

- (UIView *)separator_line2 {
    if(_separator_line2 == nil){
        _separator_line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 124, self.view.frame.size.width, 1)];
        [_separator_line2 setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
    }
    return _separator_line2;
}

- (UIView *)red_line {
    int btnWidth = self.view.frame.size.width / self.titleArr.count;
    if(_red_line == nil){
        _red_line = [[UIView alloc] initWithFrame:CGRectMake(20, 37, btnWidth - 40, 2)];
        [_red_line setBackgroundColor:[UIColor redColor]];
    }
    return _red_line;
}


- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/* -- progma mark - UIPageViewControllerDataSource -- */

// 获取前一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.pages indexOfObject:viewController];
    if (index == 0 || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self.pages objectAtIndex:index];
}

// 获取后一页
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.pages indexOfObject:viewController];
    if (index == self.pages.count - 1 || (index == NSNotFound)) {
        return nil;
    }
    index++;
    return [self.pages objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *nextVC = [pendingViewControllers firstObject];
    
    NSInteger index = [self.pages indexOfObject:nextVC];
    
    self.current_index = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        [self changeButtonSelected];
    }
}

- (ListViewController *)collectionVC {
    if(_collectionVC == nil){
        _collectionVC = [[ListViewController alloc] initWithFrame];
        _collectionVC.pageTitle = @"收藏";
        _collectionVC.viewModel = self.viewModel;
        _collectionVC.newsList = self.viewModel.collectionNews;
    }
    return _collectionVC;
}

- (ListViewController *)commentVC {
    if(_commentVC == nil){
        _commentVC = [[ListViewController alloc] initWithFrame];
        _commentVC.pageTitle = @"评论";
        _commentVC.viewModel = self.viewModel;
        _commentVC.newsList = self.viewModel.commentNews;
    }
    return _commentVC;
}

- (ListViewController *)likeVC {
    if(_likeVC == nil){
        _likeVC = [[ListViewController alloc] initWithFrame];
        _likeVC.pageTitle = @"点赞";
        _likeVC.viewModel = self.viewModel;
        _likeVC.newsList = self.viewModel.likeNews;
    }
    return _likeVC;
}

- (ListViewController *)historyVC {
    if(_historyVC == nil){
        _historyVC = [[ListViewController alloc] initWithFrame];
        _historyVC.pageTitle = @"历史";
        _historyVC.viewModel = self.viewModel;
        _historyVC.newsList = self.viewModel.historyNews;
    }
    return _historyVC;
}

- (ListViewController *)recommendVC {
    if(_recommendVC == nil){
        _recommendVC = [[ListViewController alloc] initWithFrame];
        _recommendVC.pageTitle = @"推送";
        _recommendVC.viewModel = self.viewModel;
        _recommendVC.newsList = self.viewModel.recommendNews;
    }
    return _recommendVC;
}

- (NSArray *)pages{
    if(_pages == nil){
        _pages = @[self.collectionVC, self.commentVC, self.likeVC, self.historyVC, self.recommendVC];
    }
    return _pages;
}

@end
