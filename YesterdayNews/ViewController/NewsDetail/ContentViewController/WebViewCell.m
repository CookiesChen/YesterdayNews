//
//  WebViewCell.m
//  YesterdayNews
//
//  Created by chenbb6 on 2019/6/8.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "WebViewCell.h"


@interface WebViewCell() <WKNavigationDelegate>
{
    CGFloat marginTop;
    CGFloat cellHeight;
};

@property(nonatomic, strong) NewsDetailViewModel *ViewModel;

@end

@implementation WebViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize{
    // 初始化
    marginTop = 10;
    cellHeight = 742;
    
    self.ViewModel = [[ViewModelManager getManager] getViewModel:@"NewsDetailViewModel"];
    // 设置背景色
    [self setBackgroundColor:[UIColor whiteColor]];
    // 添加子view
    [self loadSubView];
    // 调整cell大小
    [self fitCellFrame];
}

- (void)loadSubView
{
    [self addSubview: self.webView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self fitCellFrame];
}

- (void)fitCellFrame
{
    CGRect cell_frame = self.frame;
    cell_frame.size.height = cellHeight;
    [self setFrame:cell_frame];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable a, NSError * _Nullable error) {
        CGRect frame = webView.frame;
        frame.size.height = webView.scrollView.contentSize.height;
        webView.frame= frame;
        
        cellHeight = _webView.frame.size.height + marginTop;
        [self reloadDataActionBack];
    }];
}


- (void)reloadDataActionBack
{
    //代理响应reloadData方法
    if ([_delegate respondsToSelector:@selector(reloadWebViewData:)]) {
        [_delegate reloadWebViewData: cellHeight];
    }
}

- (WKWebView *)webView {
    if(_webView == nil) {
//        CGFloat height = _content.frame.size.height - marginTop;
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, marginTop, self.frame.size.width, self.frame.size.height)];
        
        [RACObserve(self.ViewModel, htmlString) subscribeNext:^(id  _Nullable x) {
            NSString *s = x;
            if(s != nil){
                NSString *head = @"<meta name=\"viewport\" content=\"width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no\" />";
                NSString *css = @"<style type=\"text/css\">img{max-width: 100%;width: 100%;height: auto;}</style>";
                [self->_webView loadHTMLString:[[head stringByAppendingString:s] stringByAppendingString:css] baseURL: nil];
                [self->_webView.scrollView setScrollEnabled: NO];
            }
        }];
        _webView.navigationDelegate = self;
    }
    return _webView;
}


@end


