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


@interface WebViewCell()
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

# pragma KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.webView.scrollView.contentSize.height;
        CGRect newFrame = self.webView.frame;
        newFrame.size.height = height;
        [self.webView setFrame:newFrame];
        //        [self.content setContentSize:CGSizeMake(WIDTH, marginTop+height)];
        
        // 注入js调整图片大小
        NSString *js = @"function imgAutoFit(){\
        var imgs = document.getElementsByTagName('img');\
        for(let i = 0; i < imgs.length; i++){\
        let img = imgs[i];\
        let imgWidth = img.width;\
        let imgHeight = img.height;\
        let factor = imgHeight/imgWidth;\
        img.style.maxWidth = %f;\
        img.height = img.width*factor;\
        }\
        }";
        js = [NSString stringWithFormat:js, self.frame.size.width];
        [self.webView evaluateJavaScript:js completionHandler:nil];
        [self.webView evaluateJavaScript:@"imgAutoFit()" completionHandler:nil];
        [self.webView sizeToFit];
        
        // 通知父页面tableview reloaddata
        if(_webView.frame.size.height > cellHeight) {
            NSLog(@"change:%f, %f", _webView.frame.size.height, cellHeight);
            cellHeight = _webView.frame.size.height + marginTop;
            [self reloadDataActionBack];
        }
    }
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
                [self->_webView loadHTMLString:[head stringByAppendingString:s] baseURL: nil];
                [self->_webView.scrollView setScrollEnabled: NO];
                // 监听webview, 实现高度自适应
                [self->_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            }
        }];
    }
    return _webView;
}


@end


