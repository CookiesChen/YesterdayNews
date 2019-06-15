//
//  SettingViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/24.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "SettingViewController.h"
#import "SubSettingViewController/EditInformationViewController.h"
#import "SubSettingViewController/PrivateSettingViewController.h"

typedef enum ItemType {
    Edit,
    Private,
    Notification,
    NightMode,
    ClearCache,
    TextSize,
    Advert,
    About,
    Logout,
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
    SettingItem i0 = {@"编辑资料", Edit};
    NSValue *v0 = [NSValue valueWithBytes:&i0 objCType:@encode(struct SettingItem)];
    SettingItem i1 = {@"账号和隐私设置", Private};
    NSValue *v1 = [NSValue valueWithBytes:&i1 objCType:@encode(struct SettingItem)];
    SettingItem i2 = {@"夜间模式", NightMode};
    NSValue *v2 = [NSValue valueWithBytes:&i2 objCType:@encode(struct SettingItem)];
    SettingItem i3 = {@"清理缓存", ClearCache};
    NSValue *v3 = [NSValue valueWithBytes:&i3 objCType:@encode(struct SettingItem)];
    SettingItem i4 = {@"字体大小", TextSize};
    NSValue *v4 = [NSValue valueWithBytes:&i4 objCType:@encode(struct SettingItem)];
    SettingItem i5 = {@"推送通知", Notification};
    NSValue *v5 = [NSValue valueWithBytes:&i5 objCType:@encode(struct SettingItem)];
    SettingItem i6 = {@"广告设置", Advert};
    NSValue *v6 = [NSValue valueWithBytes:&i6 objCType:@encode(struct SettingItem)];
    SettingItem i7 = {@"关于", About};
    NSValue *v7 = [NSValue valueWithBytes:&i7 objCType:@encode(struct SettingItem)];
    SettingItem i8 = {@"退出登录", Logout};
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

- (void)userLogout {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出" message:@"确认退出当前账号吗？" preferredStyle:UIAlertControllerStyleAlert];
    _okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
        [self.viewModel userLogout];
        User *user = [User getInstance];
        user.hasLogin = false;
        [user setUsername:@""];
        [user setToken:@""];
        
        // delete local token
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"TOKEN"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    _cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:_okAction];
    [alert addAction:_cancelAction];
    [self presentViewController:alert animated:true completion:nil];
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
        if(item.type == NightMode || item.type == Notification) {
            UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
            [switchview addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView = switchview;
            //[switchview release];
        }
        else if(item.type == Edit || item.type == Private || item.type == Advert || item.type == About) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if(item.type == TextSize || item.type == ClearCache) {
            cell.detailTextLabel.text = @"test";
        }
        else if(item.type == Logout) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.textColor = [UIColor redColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
    }
    
    cell.textLabel.text = item.text;
    
    return cell;
}

- (IBAction) updateSwitch:(id) sender {
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *items = self.tableItems[indexPath.section];
    NSValue *value = items[indexPath.row];
    SettingItem item;
    [value getValue:&item];
    if(item.type == Edit) {
        EditInformationViewController *controller = [[EditInformationViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(item.type == Private) {
        PrivateSettingViewController *controller = [[PrivateSettingViewController alloc] init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else if(item.type == Logout) {
        [self userLogout];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
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
