//
//  BottomBounceView.h
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/31.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomBounceView : UIView

@property(nonatomic, strong) UIButton *cancel;
@property(nonatomic, strong) UIButton *ok;

- (instancetype) initWithFrame: (CGRect)frame;
- (void)showInView:(UIView *)view;
- (void)addDatePicker;
- (void)addTextField;

@end

NS_ASSUME_NONNULL_END
