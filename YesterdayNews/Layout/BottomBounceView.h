//
//  BottomBounceView.h
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/31.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnTextBlock)(NSString *text);
typedef void (^ReturnDateBlock)(NSDate *date);

@interface BottomBounceView : UIView

@property(nonatomic, strong) UIButton *cancel;
@property(nonatomic, strong) UIButton *ok;
//@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UITextView *textView;
@property(nonatomic, strong) UIDatePicker *datePicker;

// block
@property (nonatomic, copy, nullable) ReturnTextBlock returnTextBlock;
@property (nonatomic, copy, nullable) ReturnDateBlock returnDateBlock;

- (instancetype) initWithFrame: (CGRect)frame;

- (void) showTextFieldInView:(UIView *)view withReturnText:(ReturnTextBlock)block;
- (void) showDatePickerInView:(UIView *)view withReturnDate:(ReturnDateBlock)block;

- (void)showInView:(UIView *)view;
- (void)addDatePicker;
- (void)addTextField;
//- (void)setTitle: (NSString *)text;

@end

NS_ASSUME_NONNULL_END
