//
//  RecommendViewController.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/4/20.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "RecommendViewController.h"
#import "../../../Utils/Notification/INotification.h"
#import <Colours.h>
#import <ReactiveObjC.h>

#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

@interface RecommendViewController() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) NSMutableArray *data;
@property(nonatomic, strong) NSString *identifier;
@property(nonatomic)NSInteger cell_height;
@property(nonatomic)NSInteger margin_bottom;

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
    // 顶部留白去除
    if(@available(iOS 11.0, *)){
        [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } else{
        [self setAutomaticallyAdjustsScrollViewInsets: NO];
    }
    [self initCollectionView];
    
    //[self sendMsg];
}

- (void)bindViewModel {

}

// 初始化
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout: layout];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.identifier = @"news";
    self.cell_height = 100;
    self.margin_bottom = 10;
}

- (void)initCollectionView {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    [layout setScrollDirection: UICollectionViewScrollDirectionVertical];
    [layout setItemSize:CGSizeMake(WIDTH, 100)];
    [layout setHeaderReferenceSize: CGSizeMake(WIDTH, 50.0f)];
    [layout setFooterReferenceSize: CGSizeMake(WIDTH, 50.0f)];
    
    [self.collectionView setFrame: CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.collectionView setBackgroundColor: [UIColor colorFromHexString:@"#efeff4"]];
    [self.collectionView setAlwaysBounceVertical: YES];
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier: self.identifier];
    // 注册组头
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"newsHeader"];
    // 注册组尾
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"newsFooter"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
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

/* -- progma mark - UICollectionViewDataDelegate -- */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    
    UIButton *button = [[UIButton alloc] init];
    [button setFrame: CGRectMake(0, 0, WIDTH, 100)];
    [button setTitleColor:[UIColor black75PercentColor] forState:UIControlStateNormal];
    [button setTitle:@"123" forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setBackgroundColor: [UIColor whiteColor]];
    [[button rac_signalForControlEvents: UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        NSLog(@"click cell!");
    }];
    [cell addSubview: button];
    
    return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    // 上拉刷新布局
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"newsHeader" forIndexPath:indexPath];
        [header setBackgroundColor:[UIColor blackColor]];
        
        UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, WIDTH, header.frame.size.height)];
        [label setBackgroundColor:[UIColor redColor]];
        [label setText:@"刷新"];
        [label setTextColor:[UIColor blackColor]];
        [header addSubview:label];
        return header;
    }
    // 下拉加载布局
    else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"newsFooter" forIndexPath:indexPath];
        [footer setBackgroundColor:[UIColor blackColor]];
        
        return footer;
    }
    return nil;
}

/* -- progma mark - UICollectionViewDelegateFlowLayout -- */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.margin_bottom;
}

/* -- progma mark - getters and setters -- */



@end
