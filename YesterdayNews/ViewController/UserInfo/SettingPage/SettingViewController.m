//
//  SettingViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/24.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "SettingViewController.h"

typedef enum ItemType {
    NAVIGATE,           // 点击跳转
    BUTTON,             // 开关按钮
    TEXT,               // 右侧文字
    NORMAL,             // 啥也没有
    LOGOUT              // 退出登录
} ItemType;

typedef struct SettingItem {
    NSString *text;
    ItemType type;
}SettingItem;

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *tableItems;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setTitle:@"设置"];
}

- (void)initData {
    //self.tableItems = [@[@[@"编辑资料",@"账号和隐私设置"], @[@"夜间模式", @"清理缓存", @"字体大小", @"推送通知"], @[@"广告设置"], @[@"关于"], @[@"退出登录"]] mutableCopy];
    SettingItem i0 = {@"编辑资料", NAVIGATE};
    NSValue *v0 = [NSValue valueWithBytes:&i0 objCType:@encode(struct SettingItem)];
    SettingItem i1 = {@"账号和隐私设置", NAVIGATE};
    NSValue *v1 = [NSValue valueWithBytes:&i1 objCType:@encode(struct SettingItem)];
    SettingItem i2 = {@"夜间模式", BUTTON};
    NSValue *v2 = [NSValue valueWithBytes:&i2 objCType:@encode(struct SettingItem)];
    SettingItem i3 = {@"清理缓存", TEXT};
    NSValue *v3 = [NSValue valueWithBytes:&i3 objCType:@encode(struct SettingItem)];
    SettingItem i4 = {@"字体大小", TEXT};
    NSValue *v4 = [NSValue valueWithBytes:&i4 objCType:@encode(struct SettingItem)];
    SettingItem i5 = {@"推送通知", BUTTON};
    NSValue *v5 = [NSValue valueWithBytes:&i5 objCType:@encode(struct SettingItem)];
    SettingItem i6 = {@"广告设置", NAVIGATE};
    NSValue *v6 = [NSValue valueWithBytes:&i6 objCType:@encode(struct SettingItem)];
    SettingItem i7 = {@"关于", NAVIGATE};
    NSValue *v7 = [NSValue valueWithBytes:&i7 objCType:@encode(struct SettingItem)];
    SettingItem i8 = {@"退出登录", LOGOUT};
    NSValue *v8 = [NSValue valueWithBytes:&i8 objCType:@encode(struct SettingItem)];
    self.tableItems = [@[@[v0, v1], @[v2, v3, v4, v5], @[v6], @[v7], @[v8]] mutableCopy];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableItems[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    NSMutableArray *items = self.tableItems[indexPath.section];
    NSValue *value = items[indexPath.row];
    SettingItem item;
    [value getValue:&item];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        if(item.type == BUTTON) {
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            [switchview addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchview;
            //[switchview release];
        }
        else if(item.type == NAVIGATE) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
    cell.textLabel.text = item.text;
    
    return cell;
}

- (IBAction) updateSwitch:(id) sender {
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: fuck
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

@end
