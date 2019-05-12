//
//  RecommendViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "RecommendViewController.h"
#import "../../../Utils/Notification/INotification.h"
#import "../../../Utils/TimeUtils/TimeUtils.h"
#import "../../../ViewModel/HomePage/Recommend/RecommendViewModel.h"
#import "../../../Layout/MultiImagesNews.h"
#import "../../../Model/News.h"
#import "../../NewsDetail/NewsDetailViewController.h"
#import <Colours.h>
#import <ReactiveObjC.h>

#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

@interface RecommendViewController() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UICollectionViewDelegate>

@property(nonatomic) CGRect frame;
@property(nonatomic, strong) RecommendViewModel *ViewModel;

@property(nonatomic, strong) UICollectionView *content;
@property(nonatomic, strong) UIRefreshControl *refreshControl;

@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic) NSInteger cell_height;
@property(nonatomic) NSInteger margin_bottom;

@end

@implementation RecommendViewController

/* -- progma mark - life cycle -- */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self bindViewModel];
}

/* -- progma mark - private methods -- */
- (void)setupView {
    [self.view setFrame: self.frame];
    [self.view addSubview: self.content];
    //[self sendMsg];
}

- (void)bindViewModel {
    self.ViewModel = [[RecommendViewModel alloc] init];
    
    // 刷新控制
    [[self.refreshControl rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@"加载中..." attributes:NULL]];
        [self.ViewModel refresh];
    }];
    
    // 刷新成功
    [self.ViewModel.success subscribeNext:^(id  _Nullable x) {
        //切换回主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.refreshControl endRefreshing];
            // reload Data
        }];
    }];
    
    // 刷新失败
    [self.ViewModel.fail subscribeNext:^(id  _Nullable x) {
        //切换回主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.refreshControl endRefreshing];
            // catch error
        }];
    }];
}

// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self.frame = frame;
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.identifier = @"news";
    self.margin_bottom = 10;
}

// 消息推送样例
- (void)sendMsg {
    // An invoking notification sample
    if ([INotification checkNotificationEnable]) {
        [INotification sendNotificationWithTitle:@"Attention"
                                        subTitle:@"Here's a notification"
                                            body:@"Congratulations! Notification works!"
                                           delay:[NSDate dateWithTimeIntervalSinceNow: 5]
                                           badge:[NSNumber numberWithInteger:1]];
    } else {
        [INotification showAlertView];
    }
}

/* -- progma mark - UICollectionViewDelegate -- */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"1");
    [self.navigationController pushViewController:[[NewsDetailViewController alloc]init] animated:YES];
}

/* -- progma mark - UICollectionViewDataDelegate -- */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// 数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ViewModel.news.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    for(UIView *view in cell.subviews){
        [view removeFromSuperview];
    }
    [cell setBackgroundColor: [UIColor whiteColor]];
    
    // 多图
    [cell addSubview: [[MultiImagesNews alloc] initWithFrame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)]];
    
    // 单图
    //[cell addSubview: [[MultiImagesNews alloc] initWithFrame: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)]];
    return cell;
}

/* -- progma mark - UICollectionViewDelegateFlowLayout -- */
// 下边距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.margin_bottom;
}

// Cell尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger type = 0;
    CGSize cellSize;
    switch (type) {
        case 0:
            cellSize = CGSizeMake(WIDTH, 230);
            break;
        case 1:
            cellSize = CGSizeMake(WIDTH, 230);
    }
    return cellSize;
}

/* -- progma mark - UIScrollViewDelegate -- */
// 滚动加载
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat height = self.content.frame.size.height;
    CGFloat contentOffsetY = self.content.contentOffset.y;
    CGFloat bottomOffset = self.content.contentSize.height - contentOffsetY;
    if(bottomOffset <= height){
        [self.ViewModel.news addObject: [[News alloc] init]];
        [self.ViewModel.news addObject: [[News alloc] init]];
        [self.ViewModel.news addObject: [[News alloc] init]];
        [self.ViewModel.news addObject: [[News alloc] init]];
        [UIView transitionWithView:self.content duration:0.1f options:UIViewAnimationOptionTransitionCrossDissolve animations:^(void) {
            [self.content reloadData];
        } completion:nil];
    }
}

/* -- progma mark - getters and setters -- */
- (UICollectionView* )content {
    if(_content == nil){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection: UICollectionViewScrollDirectionVertical];
        [layout setItemSize:CGSizeMake(WIDTH, 100)];
        
        _content = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
        [_content setBackgroundColor: [UIColor colorFromHexString:@"#efeff4"]];
        [_content setAlwaysBounceVertical:YES];
        
        // 注册cell
        [_content registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: self.identifier];
        
        [_content addSubview: self.refreshControl];
        _content.delegate = self;
        _content.dataSource = self;
    }
    return _content;
}

- (UIRefreshControl *)refreshControl {
    if(_refreshControl == nil){
        _refreshControl = [UIRefreshControl new];
        [_refreshControl setTintColor: [UIColor infoBlueColor]];
        [_refreshControl setAttributedTitle: [[NSAttributedString alloc] initWithString:@"" attributes:NULL]];
    }
    return _refreshControl;
}

@end
