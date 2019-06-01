//
//  BottomBounceView.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/31.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "BottomBounceView.h"

@interface BottomBounceView ()

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic) CGFloat contentHight;

@end

@implementation BottomBounceView

- (instancetype) initWithFrame: (CGRect)frame {
    self = [super initWithFrame: frame];
    if(self){
        self.contentHight = 200;
        [self setupConten];
    }
    return self;
}

- (instancetype) init {
    self = [super init];
    if(self){
        [self setupConten];
    }
    return self;
}

- (void)setupConten {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if(_contentView == nil) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - self.contentHight, self.frame.size.width, self.contentHight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
    }
    
    if(_ok == nil) {
        _ok = [UIButton buttonWithType:UIButtonTypeCustom];
        _ok.frame = CGRectMake(20, 8, 50, 30);
        [_ok setTitle:@"确定" forState:UIControlStateNormal];
        [_ok setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_ok addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_ok];
    }
    
    if(_cancel == nil) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancel.frame = CGRectMake(self.frame.size.width - 70, 8, 50, 30);
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancel addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancel];
    }
}

- (void)addDatePicker {
    
}

- (void)addTextField {
    
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [self.contentView setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.contentHight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self.contentView setFrame:CGRectMake(0, self.frame.size.height - self.contentHight, self.frame.size.width, self.contentHight)];
    } completion:nil];
}

- (void)disMissView {
    [self.contentView setFrame:CGRectMake(0, self.frame.size.height - self.contentHight, self.frame.size.width, self.contentHight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self.contentView setFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.contentHight)];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self.contentView removeFromSuperview];
                         
                     }];
}

@end
