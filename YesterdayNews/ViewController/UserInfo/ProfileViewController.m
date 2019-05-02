//
//  ProfileViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserTarBar/UserTarBarViewController.h"
#import "LogInPage/LoginViewController.h"
#import "SignUpPage/SignupViewController.h"
#define ICON_SIZE 22
#define ICON_LABEL_SIZE 12
#define NAME_SIZE 24
#define SIGN_SIZE 18
#define NUM_SIZE 20
#define NUM_LABEL_SIZE 14
#define TITLE_SIZE 28

#define ZXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIView *part1;
@property(nonatomic, strong) UIView *part2;
@property(nonatomic, strong) UIView *part3;
@property(nonatomic, strong) UIView *blackBlock;

@property(nonatomic, strong) UIImageView *backgroundImg;
@property(nonatomic, strong) UIImageView *userHeadImg;
@property(nonatomic, strong) UILabel *userNameLabel;
@property(nonatomic, strong) UILabel *userSignLabel;
@property(nonatomic, strong) UILabel *likesNumLabel;
@property(nonatomic, strong) UILabel *followingNumLabel;
@property(nonatomic, strong) UILabel *follersNumLabel;
@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UIButton *loginButton2;
@property(nonatomic, strong) UIButton *collecionIcon;
@property(nonatomic, strong) UIButton *commentIcon;
@property(nonatomic, strong) UIButton *likeIcon;
@property(nonatomic, strong) UIButton *historyIcon;

@property(nonatomic, strong) UILabel *loginTitleLabel;

@property(nonatomic, strong) NSMutableArray<NSMutableArray<NSString*>*> *tableItems;

@property(nonatomic, strong) LoginViewController *loginVC;
@property(nonatomic, strong) SignupViewController *signupVC;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupView];
    
    //  异步加载图片
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
    [operationQueue addOperation:op];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)setupView{
    // -------------------------------------------------part 1
    self.part1 = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 100)];
        view;
    });
    [self.view addSubview:self.part1];
    
    // background
    self.backgroundImg = ({
        UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 320)];
        backgroundImg.contentMode = UIViewContentModeScaleAspectFill;
        backgroundImg;
    });
    [self.part1 addSubview:self.backgroundImg];
    // 毛玻璃
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, self.backgroundImg.frame.size.width, self.backgroundImg.frame.size.height);
    [self.backgroundImg addSubview:effectview];
    // head
    self.userHeadImg = ({
        UIImageView *userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 55, 60, 110, 110)];
        userHeadImg.contentMode = UIViewContentModeScaleAspectFill;
        userHeadImg.layer.masksToBounds = YES;
        userHeadImg.layer.cornerRadius = userHeadImg.frame.size.width/2;
        userHeadImg;
    });
    [self.part1 addSubview:self.userHeadImg];
    // user name
    self.userNameLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 30)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:NAME_SIZE];
        label;
    });
    [self.part1 addSubview:self.userNameLabel];
    // user sign
    self.userSignLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, self.view.frame.size.width, 20)];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:SIGN_SIZE];
        label;
    });
    [self.part1 addSubview:self.userSignLabel];
    // other labels
    UILabel *label_following = [[UILabel alloc] initWithFrame:CGRectMake(30, 280, 100, 30)];
    label_following.textColor = [UIColor lightGrayColor];
    label_following.textAlignment = NSTextAlignmentCenter;
    label_following.font = [UIFont systemFontOfSize:NUM_LABEL_SIZE];
    label_following.text = @"关注";
    UILabel *label_likes = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 280, 100, 30)];
    label_likes.textColor = [UIColor lightGrayColor];
    label_likes.textAlignment = NSTextAlignmentCenter;
    label_likes.font = [UIFont systemFontOfSize:NUM_LABEL_SIZE];
    label_likes.text = @"获赞";
    UILabel *label_followers = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 130, 280, 100, 30)];
    label_followers.textColor = [UIColor lightGrayColor];
    label_followers.textAlignment = NSTextAlignmentCenter;
    label_followers.font = [UIFont systemFontOfSize:NUM_LABEL_SIZE];
    label_followers.text = @"粉丝";
    [self.part1 addSubview:label_following];
    [self.part1 addSubview:label_followers];
    [self.part1 addSubview:label_likes];
    // following num
    self.followingNumLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_following.frame.origin.x, label_following.frame.origin.y - 25, 100, 30)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:NUM_SIZE];
        label;
    });
    [self.part1 addSubview:self.followingNumLabel];
    //likes num
    self.likesNumLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_likes.frame.origin.x, label_likes.frame.origin.y - 25, 100, 30)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:NUM_SIZE];
        label;
    });
    [self.part1 addSubview:self.likesNumLabel];
    // followers num
    self.follersNumLabel = ({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(label_followers.frame.origin.x, label_followers.frame.origin.y - 25, 100, 30)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:NUM_SIZE];
        label;
    });
    [self.part1 addSubview:self.follersNumLabel];
    
    self.part1.alpha = 0;
    
    
    // ------------------------------------------------------------
    
    // -------------------------------------------------Login Button
    self.loginButton = ({
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 55, 110, 110, 110)];
        [btn setTitle:@"Login" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:NAME_SIZE];
        btn.backgroundColor = ZXColorFromRGB(0xf38181);
        btn.layer.cornerRadius = 55;
        btn;
    });
    [self.loginButton addTarget:self action:@selector(LoginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    // ------------------------------------------------------------
    
    // -------------------------------------------------part 2
    self.part2 = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 100)];
        view;
    });
    [self.view addSubview:self.part2];
    // table view
    self.tableItems = [@[@[@"我的关注",@"个人信息", @"消息通知"], @[@"用户反馈", @"系统设置"]] mutableCopy];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 330) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.part2 addSubview:self.tableView];
    // icon buttons
    // 段落属性，设置行距
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 8.0f;
    paraStyle.alignment = NSTextAlignmentCenter;
    // collection icon
    self.collecionIcon = ({
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width/4, 80)];
        [icon setTitle:@"\U0000E800\n我的收藏" forState:UIControlStateNormal];
        icon.titleLabel.font = [UIFont systemFontOfSize:ICON_LABEL_SIZE];
        NSMutableAttributedString *str0 = [[NSMutableAttributedString alloc] initWithString:icon.titleLabel.text];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor blackColor] range:[icon.titleLabel.text rangeOfString:@"我的收藏"]];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:ZXColorFromRGB(0xfce38a) range:[icon.titleLabel.text rangeOfString:@"\U0000E800"]];
        [str0 addAttribute:(NSString*)NSFontAttributeName value:[UIFont fontWithName:@"fontello" size:ICON_SIZE] range:[icon.titleLabel.text rangeOfString:@"\U0000E800"]];
        [str0 addAttribute:(NSString*)NSParagraphStyleAttributeName value:paraStyle range:[icon.titleLabel.text rangeOfString:icon.titleLabel.text]];
        [icon setAttributedTitle:str0 forState:UIControlStateNormal];
        icon.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        icon;
    });
    [self.collecionIcon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    // comment icon
    self.commentIcon = ({
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, 20, self.view.frame.size.width/4, 80)];
        [icon setTitle:@"\U0000E804\n我的评论" forState:UIControlStateNormal];
        icon.titleLabel.font = [UIFont systemFontOfSize:ICON_LABEL_SIZE];
        NSMutableAttributedString *str0 = [[NSMutableAttributedString alloc] initWithString:icon.titleLabel.text];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor blackColor] range:[icon.titleLabel.text rangeOfString:@"我的评论"]];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:ZXColorFromRGB(0x3ec1d3) range:[icon.titleLabel.text rangeOfString:@"\U0000E804"]];
        [str0 addAttribute:(NSString*)NSFontAttributeName value:[UIFont fontWithName:@"fontello" size:ICON_SIZE] range:[icon.titleLabel.text rangeOfString:@"\U0000E804"]];
        [str0 addAttribute:(NSString*)NSParagraphStyleAttributeName value:paraStyle range:[icon.titleLabel.text rangeOfString:icon.titleLabel.text]];
        [icon setAttributedTitle:str0 forState:UIControlStateNormal];
        icon.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        icon;
    });
    [self.commentIcon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    // like icon
    self.likeIcon = ({
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4*2, 20, self.view.frame.size.width/4, 80)];
        [icon setTitle:@"\U0000F164\n我的点赞" forState:UIControlStateNormal];
        icon.titleLabel.font = [UIFont systemFontOfSize:ICON_LABEL_SIZE];
        NSMutableAttributedString *str0 = [[NSMutableAttributedString alloc] initWithString:icon.titleLabel.text];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor blackColor] range:[icon.titleLabel.text rangeOfString:@"我的点赞"]];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:ZXColorFromRGB(0xf38181) range:[icon.titleLabel.text rangeOfString:@"\U0000F164"]];
        [str0 addAttribute:(NSString*)NSFontAttributeName value:[UIFont fontWithName:@"fontello" size:ICON_SIZE] range:[icon.titleLabel.text rangeOfString:@"\U0000F164"]];
        [str0 addAttribute:(NSString*)NSParagraphStyleAttributeName value:paraStyle range:[icon.titleLabel.text rangeOfString:icon.titleLabel.text]];
        [icon setAttributedTitle:str0 forState:UIControlStateNormal];
        icon.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        icon;
    });
    [self.likeIcon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    // history icon
    self.historyIcon = ({
        UIButton *icon = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4*3, 20, self.view.frame.size.width/4, 80)];
        [icon setTitle:@"\U0000E803\n浏览历史" forState:UIControlStateNormal];
        icon.titleLabel.font = [UIFont systemFontOfSize:ICON_LABEL_SIZE];
        NSMutableAttributedString *str0 = [[NSMutableAttributedString alloc] initWithString:icon.titleLabel.text];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor blackColor] range:[icon.titleLabel.text rangeOfString:@"浏览历史"]];
        [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:ZXColorFromRGB(0x00b8a9) range:[icon.titleLabel.text rangeOfString:@"\U0000E803"]];
        [str0 addAttribute:(NSString*)NSFontAttributeName value:[UIFont fontWithName:@"fontello" size:ICON_SIZE] range:[icon.titleLabel.text rangeOfString:@"\U0000E803"]];
        [str0 addAttribute:(NSString*)NSParagraphStyleAttributeName value:paraStyle range:[icon.titleLabel.text rangeOfString:icon.titleLabel.text]];
        [icon setAttributedTitle:str0 forState:UIControlStateNormal];
        icon.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        icon;
    });
    [self.historyIcon addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.part2 addSubview:self.collecionIcon];
    [self.part2 addSubview:self.commentIcon];
    [self.part2 addSubview:self.likeIcon];
    [self.part2 addSubview:self.historyIcon];
    // ------------------------------------------------------------
    
    // -------------------------------------------------black
    self.blackBlock = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0;
        view;
    });
    [self.view addSubview:self.blackBlock];
    // ------------------------------------------------------------
    
    // -------------------------------------------------part 3
    self.part3 = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
        view.backgroundColor = [UIColor whiteColor];
        view;
    });
    [self.view addSubview:self.part3];
    // close button
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.part3.frame.size.width-150, 10, 150, 30)];
    [closeBtn setTitle:@"close" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [closeBtn setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.part3 addSubview:closeBtn];

    // child VC
    self.loginVC = [[LoginViewController alloc] init];
    // 添加到父控制器中
    [self addChildViewController:self.loginVC];
    self.loginVC.view.frame = CGRectMake(0, 40, self.part3.frame.size.width, self.part3.frame.size.height);
    [self.part3 addSubview:self.loginVC.view];
    [self.loginVC didMoveToParentViewController:self];
    
    self.part3.transform = CGAffineTransformTranslate(self.part3.transform, 0, self.part3.frame.size.height);
    // ------------------------------------------------------------
 
}

- (void)downloadImage {
    NSURL *imageURL = [NSURL URLWithString:@"https://hbimg.huabanimg.com/954d812b554d7a23dda1b59c0f807446798aefa839a47-H6Z5G4_fw658"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}

- (void)updateUI:(UIImage*)image {
    self.backgroundImg.image = image;
    self.userHeadImg.image = image;
    
    // set information
    self.userNameLabel.text = @"BurningFish";
    self.userSignLabel.text = @"Suprise mother fucker";
    self.followingNumLabel.text = @"10";
    self.follersNumLabel.text = @"66";
    self.likesNumLabel.text = @"233";
}

#pragma Animation
- (void)showUserInfoAnimation {
    [UIView animateWithDuration:1.0 animations:^{
        self.part1.alpha = 100;
        self.loginButton.alpha = 0;
        self.part2.transform = CGAffineTransformTranslate(self.part1.transform, 0, 70);
    } completion:^(BOOL finished) {
        [self.loginButton removeFromSuperview];
    }];
}

- (void)showLoginPageAnimation {
    self.blackBlock.alpha = 0.2;
    [UIView animateWithDuration:0.5 animations:^{
        self.part3.transform = CGAffineTransformTranslate(self.part3.transform, 0, -self.part3.frame.size.height);
    }];
}

- (void)hideLoginPageAnimation {
    self.blackBlock.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.part3.transform = CGAffineTransformTranslate(self.part3.transform, 0, self.part3.frame.size.height);
    }];
}

-(void)buttonClick:(id)sender
{
    NSLog(@"%@", sender);
    
    UserTarBarViewController *controller = [[UserTarBarViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma Button click
- (void) closeButtonClick:(id)sender {
    [self hideLoginPageAnimation];
}

- (void) LoginButtonClick:(id)sender {
    [self showLoginPageAnimation];
}

- (void) LoginButtonClick2:(id)sender {
    [self hideLoginPageAnimation];
    [self showUserInfoAnimation];
}

- (void) testButton:(id)sender {
    [UIView animateWithDuration:2.5 animations:^{
        self.part1.transform = CGAffineTransformTranslate(self.part1.transform, 0, 100);
    }];
}

#pragma mark ------------ UITableViewDataSource ------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 第一排的icons暂时用一个sectiona来放置
    return self.tableItems.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return [self.tableItems[section - 1] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if (indexPath.section == 0) {
        cell.userInteractionEnabled = NO;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSMutableArray *items = self.tableItems[indexPath.section - 1];
        cell.textLabel.text = items[indexPath.row];
    }
    
    return cell;
}



#pragma mark ------------ UITableViewDelegate ------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 80;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
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


@end
