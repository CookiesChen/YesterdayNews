//
//  SingleImageNews.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "../Utils/TimeUtils/TimeUtils.h"
#import "SingleImageNews.h"
#import "../Model/User/User.h"
#import <Colours.h>
#import <ReactiveObjC.h>
#import <YBImageBrowser.h>
#import "ImageCell.h"

#define HEIGHT self.frame.size.height
#define WIDTH self.frame.size.width

@interface SingleImageNews() <UICollectionViewDelegate, UICollectionViewDataSource,
YBImageBrowserDataSource>
{
    NSInteger margin;
    CGFloat marginTop;
    NSString *identifier;
}

@property(nonatomic, strong) News *news;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UILabel *author;
@property(nonatomic, strong) UILabel *comment;
@property(nonatomic, strong) UILabel *time;
@property(nonatomic, strong) NSMutableArray *dataArray;

@end


@implementation SingleImageNews

- (instancetype)initWithFrame:(CGRect)frame andNews:(News *)news{
    self.news = news;
    self = [super initWithFrame: frame];
    if(self){
        margin = 10;
        marginTop = 10;
        identifier = @"imageCell";
        self.dataArray = [[NSMutableArray alloc] initWithArray: @[@"http://p3-tt.bytecdn.cn/large/19f90001d3b34601fcce"]];
    }
    return self;
}

- (instancetype) init {
    self = [super init];
    if(self){
        margin = 10;
        marginTop = 10;
        identifier = @"imageCell";
        self.dataArray = [[NSMutableArray alloc] initWithArray: @[@"http://p3-tt.bytecdn.cn/large/19f90001d3b34601fcce"]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackgroundColor: [UIColor whiteColor]];
    
    [self addSubview: self.title];
    
    CGFloat padding = 10, cellLength = (WIDTH - padding - 2*margin) / 3;
    [self.collectionView setFrame: CGRectMake(margin + self.title.frame.size.width + padding, marginTop, cellLength, cellLength*2/3)];
    [self addSubview: self.collectionView];
    
    marginTop += self.collectionView.frame.size.height + 10;
    [self addSubview: self.author];
    [self addSubview: self.comment];
    [self addSubview: self.time];
}

# pragma YBImageBrowserDataSource
- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowserView *)imageBrowserView {
    return 1;
}

- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
    YBImageBrowseCellData *data = [YBImageBrowseCellData new];
    data.url = [NSURL URLWithString: [self.self.news.images objectAtIndex:index]];
    data.sourceObject = [self sourceObjAtIdx:index];
    return data;
}

# pragma UICollectionViewDataDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.news.images.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.data = self.self.news.images[indexPath.row];
    return cell;
}

# pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [self.self.news.images enumerateObjectsUsingBlock:^(NSString *_Nonnull urlStr, NSUInteger idx, BOOL * _Nonnull stop) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:urlStr];
        [browserDataArr addObject:data];
    }];
    
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = indexPath.row;
    [browser show];
}

# pragma TOOL
- (id)sourceObjAtIdx:(NSInteger)idx {
    ImageCell *cell = (ImageCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    return cell ? cell.mainImageView : nil;
}

# pragma getter and setter
- (UILabel *)title {
    if(_time == nil) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, (WIDTH-2*margin)*2/3, 20)];
        [_title setText: self.news.title];
        [_title setFont: [UIFont systemFontOfSize: 20]];
        [_title setLineBreakMode: NSLineBreakByTruncatingTail];
        [_title setNumberOfLines: 3];
        [_title sizeToFit];
    }
    return _title;
}

- (UILabel *)author {
    if(_author == nil){
        _author = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH, 25)];
        [_author setText: self.news.author];
        [_author setFont: [UIFont systemFontOfSize: 15]];
        [_author setTextColor: [UIColor black25PercentColor]];
        [_author sizeToFit];
    }
    return _author;
}

- (UILabel *)comment {
    if(_comment == nil){
        _comment = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH, 25)];
        _comment = [[UILabel alloc] initWithFrame:CGRectMake(margin+self.author.frame.size.width+10, marginTop, WIDTH, 25)];
        [_comment setText: [self.news.comments stringByAppendingString:@"评论"]];
        [_comment setFont: [UIFont systemFontOfSize: 15]];
        [_comment setTextColor: [UIColor black25PercentColor]];
        [_comment sizeToFit];
    }
    return _comment;
}

- (UILabel *)time {
    if(_time == nil){
        _time = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-margin, marginTop, WIDTH, 25)];
        [_time setText: [TimeUtils getTimeDifference:self.news.time]];
        [_time setFont: [UIFont systemFontOfSize: 15]];
        [_time setTextColor: [UIColor black25PercentColor]];
        [_time sizeToFit];
        [_time setFrame:CGRectMake(WIDTH-margin-_time.frame.size.width, marginTop, _time.frame.size.width, 25)];
    }
    return _time;
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil){
        CGFloat padding = 5, cellLength = (WIDTH - padding - 2*margin) / 3;
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(cellLength, cellLength*2/3);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, cellLength)
                                             collectionViewLayout:layout];
        [_collectionView registerClass:ImageCell.class forCellWithReuseIdentifier:identifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

@end
