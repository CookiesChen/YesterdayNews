//
//  MultiImagesNews.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "../Utils/TimeUtils/TimeUtils.h"
#import "MultiImagesNews.h"
#import <Colours.h>
#import <ReactiveObjC.h>
#import <YBImageBrowser.h>
#import "ImageCell.h"

#define HEIGHT self.frame.size.height
#define WIDTH self.frame.size.width

@interface MultiImagesNews() <UICollectionViewDelegate, UICollectionViewDataSource,
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

@implementation MultiImagesNews

- (instancetype)initWithFrame:(CGRect)frame andNews:(News *)news{
    self = [super initWithFrame: frame];
    if(self){
        margin = 10;
        marginTop = 10;
        identifier = @"imageCell";
        self.news = news;
        self.dataArray = [[NSMutableArray alloc] initWithArray: @[
                                            @"https://hbimg.huabanimg.com/dbb108fc6f4643d1e728de78a685e7acedd5f03a12576f-U8hpJS_fw658"
                                            ,@"http://meisudci.oss-cn-beijing.aliyuncs.com/bn_thumb/MSBQ53640500096936.jpg?x-oss-process=style/bn_info_thumb"
                                            ,@"http://meisudci.oss-cn-beijing.aliyuncs.com/bn_thumb/MSBQ67590700070838.jpg?x-oss-process=style/bn_info_thumb"]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackgroundColor: [UIColor whiteColor]];

    [self addSubview: self.title];
    marginTop += self.title.frame.size.height + 10;

    CGFloat padding = 5, cellLength = (WIDTH - 2 * padding - 2 * margin) / 3;
    [self.collectionView setFrame: CGRectMake(0, marginTop, WIDTH, cellLength)];
    [self addSubview: self.collectionView];
    
    marginTop += cellLength + 5;
    
    [self addSubview: self.author];
    [self addSubview: self.comment];
    [self addSubview: self.time];
}

# pragma YBImageBrowserDataSource
- (NSUInteger)yb_numberOfCellForImageBrowserView:(YBImageBrowserView *)imageBrowserView {
    return 3;
}

- (id<YBImageBrowserCellDataProtocol>)yb_imageBrowserView:(YBImageBrowserView *)imageBrowserView dataForCellAtIndex:(NSUInteger)index {
    YBImageBrowseCellData *data = [YBImageBrowseCellData new];
    data.url = [NSURL URLWithString: [self.news.images objectAtIndex:index]];
    data.sourceObject = [self sourceObjAtIdx:index];
    return data;
}

# pragma UICollectionViewDataDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.data = self.news.images[indexPath.row];
    return cell;
}

# pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *browserDataArr = [NSMutableArray array];
    [self.news.images enumerateObjectsUsingBlock:^(NSString *_Nonnull urlStr, NSUInteger idx, BOOL * _Nonnull stop) {
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
    if(_title == nil) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH-2*margin, 100)];
        [_title setText: [self.news title]];
        [_title setFont: [UIFont systemFontOfSize: 20]];
        [_title setLineBreakMode: NSLineBreakByWordWrapping];
        [_title setNumberOfLines: 0];
        [_title sizeToFit];
    }
    return _title;
}

- (UILabel *)author {
    if(_author == nil){
        _author = [[UILabel alloc] initWithFrame:CGRectMake(margin, marginTop, WIDTH, 25)];
        [_author setText: [self.news author]];
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
        [_comment setText: self.news.comments];
        [_comment setFont: [UIFont systemFontOfSize: 15]];
        [_comment setTextColor: [UIColor black25PercentColor]];
        [_comment sizeToFit];
    }
    return _comment;
}

- (UILabel *)time {
    if(_time == nil){
        _time = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH-margin, marginTop, WIDTH, 25)];
        [_time setText: [TimeUtils getTimeDifference:[self.news time]]];
        [_time setFont: [UIFont systemFontOfSize: 15]];
        [_time setTextColor: [UIColor black25PercentColor]];
        [_time sizeToFit];
        [_time setFrame:CGRectMake(WIDTH-margin-_time.frame.size.width, marginTop, _time.frame.size.width, 25)];
    }
    return _time;
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil){
        CGFloat padding = 5, cellLength = (WIDTH - 2 * padding - 2 * margin) / 3;
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(cellLength, cellLength);
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
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
