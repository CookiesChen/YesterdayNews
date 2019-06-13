//
//  BottomBounceView.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/31.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "BottomBounceView.h"
#import <Colours.h>

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
        self.contentHight = 200;
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
        _contentView.backgroundColor = [UIColor colorFromHexString:@"#efeff4"];
        [self addSubview:_contentView];
    }
    
    if(_ok == nil) {
        _ok = [UIButton buttonWithType:UIButtonTypeCustom];
        _ok.frame = CGRectMake(20, 8, 50, 30);
        [_ok setTitle:@"确定" forState:UIControlStateNormal];
        [_ok setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _ok.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        [_ok addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_ok];
    }
    
    if(_cancel == nil) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancel.frame = CGRectMake(self.frame.size.width - 70, 8, 50, 30);
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _cancel.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        [_cancel addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancel];
    }
}

- (void) showTextFieldInView:(UIView *)view withReturnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
    [self addTextField];
    [self showInView:view];
}

- (void) showDatePickerInView:(UIView *)view withReturnDate:(ReturnDateBlock)block {
    self.returnDateBlock = block;
    [self addDatePicker];
    [self showInView:view];
}

- (void)addDatePicker {
    self.contentHight = 250;
    [self.contentView setFrame:CGRectMake(0, self.frame.size.height - self.contentHight, self.frame.size.width, self.contentHight)];
    if(_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(25, 40, self.frame.size.width - 50, self.contentHight - 80)];
        // 设置地区: zh-中国
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        // 设置当前显示时间
        [_datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        [_datePicker setMaximumDate:[NSDate date]];
    }
    [_contentView addSubview:_datePicker];
}

- (void)addTextField {
    self.contentHight = 200;
    [self.contentView setFrame:CGRectMake(0, self.frame.size.height - self.contentHight, self.frame.size.width, self.contentHight)];
    if(_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(25, 40, self.frame.size.width - 50, self.contentHight - 80)];
        [_textView setFont:[UIFont systemFontOfSize: 16.0]];
        _textView.editable = YES;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.cornerRadius = 10;
    }
    //_textField.text = username;
    _textView.text = @"";
    [_contentView addSubview:_textView];
}

- (void)okButtonClick {
    if (self.returnTextBlock != nil && self.textView != nil) {
        self.returnTextBlock(self.textView.text);
    }
    if (self.returnDateBlock != nil && self.datePicker != nil) {
        self.returnDateBlock(self.datePicker.date);
    }
    [self disMissView];
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
                         [self.textView removeFromSuperview];
                         [self.datePicker removeFromSuperview];
                         self.returnTextBlock = nil;
                         self.returnDateBlock = nil;
                     }];
}

@end
