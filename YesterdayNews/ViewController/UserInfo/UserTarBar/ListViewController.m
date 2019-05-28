//
//  ListViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/29.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ListViewController.h"
#import <Colours.h>
#import <ReactiveObjC.h>
#import "../../NewsDetail/NewsDetailViewController.h"

#define HEIGHT self.view.frame.size.height
#define WIDTH self.view.frame.size.width

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UILabel *title_label;
//@property(nonatomic, strong) UICollectionView *content;
@property(nonatomic, strong) NSString *identifier;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    [self setupView];
}

- (instancetype)initWithFrame{
    self = [super init];
    if(self){
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.identifier = @"news";
}

- (void)bindViewModel {
    [self.viewModel.reload subscribeNext:^(id  _Nullable x) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //[self.view addSubview: self.title_label];
    [self.view addSubview: self.tableView];
}

#pragma mark ------------ UITableViewDataSource ------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cellID";
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    News *newsItem;
    newsItem = self.newsList[indexPath.row];
    //cell.newsItem = newsItem;
    [cell setFrameWidth:self.view.frame.size.width];
    //NSLog(@"####-------------%f\n", self.view.frame.size.width);
    [cell setNewsItem:newsItem];
    
    return cell;
}

#pragma mark ------------ UITableViewDelegate ------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[NewsDetailViewController alloc]init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

# pragma mark getters and setters
// 标题Label
- (UILabel *)title_label {
    if(_title_label == nil) {
        _title_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
        _title_label.textColor = [UIColor blackColor];
        _title_label.textAlignment = NSTextAlignmentCenter;
        _title_label.font = [UIFont systemFontOfSize:20];
        _title_label.text = [NSString stringWithFormat:@"This is a %@ page", self.pageTitle];
    }
    return _title_label;
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
        [_tableView setBackgroundColor: [UIColor colorFromHexString:@"#efeff4"]];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
