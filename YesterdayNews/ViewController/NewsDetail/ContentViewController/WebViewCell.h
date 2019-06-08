//
//  WebViewCell.h
//  YesterdayNews
//
//  Created by chenbb6 on 2019/6/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#ifndef WebViewCell_h
#define WebViewCell_h

#import <UIKit/UIKit.h>

@protocol WebViewCellDelegate <NSObject>

@optional
- (void)reloadWebViewData: (NSUInteger) cellHeight;

@end

@interface WebViewCell : UIView

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, weak) id<WebViewCellDelegate> delegate;

@end
#endif /* WebViewCell_h */
