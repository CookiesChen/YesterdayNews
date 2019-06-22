//
//  EditInformationViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/24.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "EditInformationViewController.h"
#import "../../../../Layout/BottomBounceView.h"
#import "UserInfoViewController.h"
#import "ViewModelManager.h"

@interface EditInformationViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(nonatomic, strong) NSMutableArray *tableItems;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) BottomBounceView *bbv;

@end

@implementation EditInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationItem setTitle:@"编辑资料"];
}

- (void)initData {
    self.tableItems = [@[@[@"头像", @"介绍"], @[@"性别", @"生日"]] mutableCopy];
}

- (void)setupView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    self.bbv = [[BottomBounceView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
}

- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)editDiscription {
    [self.bbv showTextFieldInView:self.view withReturnText:^(NSString *text) {
        NSLog(@"###current discription - %@\n", text);
    }];
}

- (void)editHeadImg {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickActionControl];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // do nothing
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:cancel];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)editSex {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)editBirthday {
    [self.bbv showDatePickerInView:self.view withReturnDate:^(NSDate *date) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
        NSString *dateString = [dateFormat stringFromDate:date];
        NSLog(@"###current date - %@\n", dateString);
    }];
}

- (void)imagePickActionControl
{
    NSLog(@"[LOG] imagePickActionControl");
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    NSLog(@"[LOG] didFinishPickingMediaWithInfo");
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *imageName = [NSString stringWithFormat:@"%@.png", [[User getInstance] getUsername]];
    NSLog(@"[LOG] save user icon name:%@", imageName);
    [self savePickUserIcon:image withName:imageName];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)savePickUserIcon:(UIImage *)image withName:(NSString *)imageName
{
    // 获取imageData和config path
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *docPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/image/avatar"];
    NSString *fullPath = [docPath stringByAppendingPathComponent:imageName];
    NSLog(@"[LOG] save user icon path: %@", fullPath);
    // 检查Documentsd头像存储路径，若无则创建目录
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:docPath]) {
        [fileManager createDirectoryAtPath:docPath withIntermediateDirectories:nil attributes:nil error:nil];
    }
    // 存储选择的头像
    [imageData writeToFile:fullPath atomically:NO];
    // 更新ViewModel
    ProfileViewModel *ViewModel = [[ViewModelManager getManager] getViewModel: @"ProfileViewModel"];
    [ViewModel updateIconwithIconData: imageData withUserName:[[User getInstance] getUsername]];
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
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    NSMutableArray *items = self.tableItems[indexPath.section];
    cell.textLabel.text = items[indexPath.row];
    
    return cell;
}

- (IBAction) updateSwitch:(id) sender {
    
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self editHeadImg];
                break;
            case 1:
                [self editDiscription];
                break;
            default:
                break;
        }
    }
    else if(indexPath.section == 1) {
        if(indexPath.row == 0) {
            [self editSex];
        }
        else if(indexPath.row == 1) {
            [self editBirthday];
        }
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
