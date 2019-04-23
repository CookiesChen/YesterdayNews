//
//  UserTarBarViewController.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/4/23.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "UserTarBarViewController.h"

@interface UserTarBarViewController ()

@end

@implementation UserTarBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setTitle:@"test"];
    NSLog(@"[NetWork Access] viewDidLoad");
    
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(onClickBack:)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 - 15, self.view.frame.size.width, 30)];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.text = @"This is a fucking test page";
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 30, 30)];
    [back setTitle:@"<" forState:UIControlStateNormal];
    back.titleLabel.font = [UIFont systemFontOfSize:20];
    NSMutableAttributedString *str0 = [[NSMutableAttributedString alloc] initWithString:back.titleLabel.text];
    [str0 addAttribute:(NSString*)NSForegroundColorAttributeName value:[UIColor blackColor] range:[back.titleLabel.text rangeOfString:back.titleLabel.text]];
    [back setAttributedTitle:str0 forState:UIControlStateNormal];
    back.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [back addTarget:self action:@selector(onClickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
    [self.view addSubview:label];
}

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    //NSLog(@"[NetworkAccessViewController] viewWillAppear");
}

- (void)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
