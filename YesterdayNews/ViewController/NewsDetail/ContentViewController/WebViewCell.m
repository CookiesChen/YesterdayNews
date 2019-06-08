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
        NSString *head = @"<meta name=\"viewport\" content=\"width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no\" />";
        NSString *htmlString = @"<html><head></head><body><div><p><img src=\"http://p3-tt.bytecdn.cn/large/19f90001d3190b592380\" fingerprint\": \"7918786322495759450\", \"hash_id\": 5748186951467652705, \"height\": 667, \"hit_group_count\": 0, \"image_type\": 1, \"md5\": \"4fc5a993c0c3d6615a02901a091c0a70\", \"mimetype\": \"image jpeg\", \"near_dup_id\": \"12151210947739832402\", \"ocr_text\": \"\", \"web_uri\": \"19f90001d3190b592380\", \"width\": 1024}\" height=\"667\" width=\"1024\"></p><p class=\"pgc-img-caption\">2017&#x5E74;&#x4F1A;&#x8BA1;&#x4E13;&#x4E1A;&#x5C31;&#x4E1A;&#x524D;&#x666F;&#x5982;&#x4F55;&#xFF1F;</p><p>2017&#x5E74;&#x4F1A;&#x8BA1;&#x884C;&#x4E1A;&#x5C31;&#x4E1A;&#x524D;&#x666F;&#x5982;&#x4F55;&#xFF1F;&#x73B0;&#x5728;&#x4E3A;&#x5927;&#x5BB6;&#x5206;&#x6790;&#x5F53;&#x524D;&#x4F1A;&#x8BA1;&#x884C;&#x4E1A;&#x5728;&#x5185;&#x8D44;&#x4F01;&#x4E1A;&#x3001;&#x5916;&#x8D44;&#x4F01;&#x4E1A;&#x7684;&#x804C;&#x4E1A;&#x7279;&#x70B9;&#x3001;&#x804C;&#x4E1A;&#x73B0;&#x72B6;&#x8FDB;&#x884C;&#x5206;&#x6790;&#xFF0C;&#x5E76;&#x5BF9;&#x6B64;&#x63D0;&#x51FA;&#x76F8;&#x5E94;&#x89E3;&#x51B3;&#x65B9;&#x6CD5;&#xFF01;</p><p><strong>&#x4E00;</strong><strong>&#x3001;</strong><strong>&#x5185;&#x8D44;&#x4F01;&#x4E1A;</strong></p><p><strong> &#x804C;&#x4E1A;&#x7279;&#x70B9;&#xFF1A;</strong><span>&#x9700;&#x6C42;&#x91CF;&#x5927;&#xFF0C;&#x5F85;&#x9047;&#x3001;&#x53D1;&#x5C55;&#x6B20;&#x4F73;&#x3002;</span></p><p><strong>&#x804C;&#x4E1A;&#x72B6;&#x51B5;&#xFF1A;</strong></p><p>&#x8FD9;&#x4E00;&#x5757;&#x5BF9;&#x4F1A;&#x8BA1;&#x4EBA;&#x624D;&#x7684;&#x9700;&#x6C42;&#x662F;&#x6700;&#x5927;&#x7684;&#xFF0C;&#x4E5F;&#x662F;&#x76EE;&#x524D;&#x4F1A;&#x8BA1;&#x6BD5;&#x4E1A;&#x751F;&#x7684;&#x6700;&#x5927;&#x5C31;&#x4E1A;&#x65B9;&#x5411;&#x3002;&#x56FD;&#x5185;&#x5F88;&#x591A;&#x4E2D;&#x5C0F;&#x4F01;&#x4E1A;&#x7279;&#x522B;&#x662F;&#x6C11;&#x8425;&#x4F01;&#x4E1A;&#xFF0C;&#x5BF9;&#x4E8E;&#x4F1A;&#x8BA1;&#x5C97;&#x4F4D;&#x4ED6;&#x4EEC;&#x9700;&#x8981;&#x627E;&#x7684;&#x53EA;&#x662F;&#x201C;&#x5E10;&#x623F;&#x5148;&#x751F;&#x201D;&#xFF0C;&#x800C;&#x4E0D;&#x662F;&#x5177;&#x6709;&#x8D22;&#x52A1;&#x7BA1;&#x7406;&#x548C;&#x5206;&#x6790;&#x80FD;&#x529B;&#x7684;&#x4E13;&#x4E1A;&#x4EBA;&#x624D;&#xFF0C;&#x800C;&#x4E14;&#xFF0C;&#x6B64;&#x7C7B;&#x516C;&#x53F8;&#x5927;&#x90FD;&#x8D22;&#x52A1;&#x76D1;&#x7763;&#x548C;&#x63A7;&#x5236;&#x4F53;&#x7CFB;&#x76F8;&#x5F53;&#x7B80;&#x964B;&#x3002;&#x56E0;&#x6B64;&#xFF0C;&#x5728;&#x521B;&#x4E1A;&#x521D;&#x671F;&#xFF0C;&#x4ED6;&#x4EEC;&#x7684;&#x4F1A;&#x8BA1;&#x5DE5;&#x4F5C;&#x4E00;&#x822C;&#x90FD;&#x662F;&#x638C;&#x63E1;&#x5728;&#x81EA;&#x5DF1;&#x7684;&#x4EB2;&#x4FE1;(&#x621A;)&#x624B;&#x91CC;&#x3002;&#x5230;&#x516C;&#x53F8;&#x505A;&#x5927;&#xFF0C;&#x8D22;&#x52A1;&#x590D;&#x6742;&#x5230;&#x4EB2;&#x4FE1;(&#x621A;)&#x65E0;&#x6CD5;&#x5168;&#x76D8;&#x63A7;&#x5236;&#x65F6;&#xFF0C;&#x624D;&#x4F1A;&#x62DB;&#x8058;&#x201C;&#x5916;&#x4EBA;&#x201D;&#x8BB0;&#x8BB0;&#x5E10;&#x3002;</p><p><strong>&#x5C31;&#x4E1A;</strong><strong>&#x5EFA;&#x8BAE;&#xFF1A;</strong></p><p>&#x5DE5;&#x4F5C;&#x4EFB;&#x52A1;&#x5C11;&#xFF0C;&#x538B;&#x529B;&#x5C0F;&#xFF0C;&#x7279;&#x522B;&#x662F;&#x56FD;&#x4F01;&#x3002;&#x8FD9;&#x5C31;&#x7ED9;&#x4F60;&#x5F88;&#x591A;&#x7684;&#x5B66;&#x4E60;&#x65F6;&#x95F4;&#xFF0C;&#x7ED9;&#x4F60;&#x7684;&#x9CA4;&#x9C7C;&#x8DF3;&#x9F99;&#x95E8;&#x68A6;&#x60F3;&#x63D0;&#x4F9B;&#x4E86;&#x821E;&#x53F0;&#x3002;&#x5982;&#x679C;&#x4F60;&#x7684;&#x5B66;&#x6821;&#x4E0D;&#x662F;&#x5F88;&#x597D;&#xFF0C;&#x4F1A;&#x8BA1;&#x4E13;&#x4E1A;&#x5728;&#x56FD;&#x5185;&#x4E0D;&#x662F;&#x5F88;&#x725B;&#xFF0C;&#x90A3;&#x7B14;&#x8005;&#x5EFA;&#x8BAE;&#x4F60;&#x9009;&#x62E9;&#x8FD9;&#x4E9B;&#x4F01;&#x4E1A;&#xFF0C;&#x56E0;&#x4E3A;&#x53EF;&#x4EE5;&#x5229;&#x7528;&#x65F6;&#x95F4;&#xFF0C;&#x53C2;&#x8003;&#x6CE8;&#x518C;&#x4F1A;&#x8BA1;&#x5E08;&#x6216;ACCA&#xFF0C;&#x65E2;&#x80FD;&#x79EF;&#x6512;&#x7ECF;&#x9A8C;&#xFF0C;&#x53C8;&#x80FD;&#x7EE7;&#x7EED;&#x52AA;&#x529B;&#x62FF;&#x8BC1;&#x4E66;&#x3002;</p><p>&#x5728;&#x6821;&#x671F;&#x95F4;&#x53C2;&#x52A0;&#x6CE8;&#x518C;&#x4F1A;&#x8BA1;&#x5E08;&#x8003;&#x8BD5;&#xFF0C;&#x6709;&#x6761;&#x4EF6;&#x7684;&#x53C2;&#x52A0;ACCA&#x8003;&#x8BD5;&#x3002;&#x524D;&#x8005;&#x5728;&#x4E00;&#x4E9B;&#x7701;&#x5E02;&#x5728;&#x6821;&#x4F1A;&#x8BA1;&#x5B66;&#x751F;&#x5C31;&#x80FD;&#x62A5;&#x540D;&#xFF0C;&#x800C;&#x4E14;&#x8D39;&#x7528;&#x76F8;&#x5BF9;&#x4F4E;&#xFF0C;&#x603B;&#x5171;5&#x95E8;&#xFF0C;&#x8003;&#x8FC7;&#x4E00;&#x95E8;&#x5728;5&#x5E74;&#x5185;&#x6301;&#x7EED;&#x6709;&#x6548;;&#x540E;&#x8005;&#x5168;&#x9762;&#xFF0C;&#x603B;&#x5171;14&#x95E8;&#x8BFE;&#x7A0B;&#xFF0C;&#x82F1;&#x6587;&#x8BD5;&#x9898;&#xFF0C;&#x5927;&#x4E8C;&#x53CA;&#x4EE5;&#x4E0A;&#x5C31;&#x53EF;&#x4EE5;&#x62A5;&#x540D;&#x57F9;&#x8BAD;&#x3002;&#x57F9;&#x8BAD;&#x540E;&#x4E0D;&#x4EC5;&#x80FD;&#x638C;&#x63E1;&#x56FD;&#x9645;&#x8D22;&#x52A1;&#x4F1A;&#x8BA1;&#x64CD;&#x4F5C;&#xFF0C;&#x66F4;&#x91CD;&#x8981;&#x7684;&#x662F;&#x5176;&#x8BFE;&#x7A0B;&#x6D89;&#x53CA;&#x7BA1;&#x7406;&#x3001;&#x91D1;&#x878D;&#x7B49;&#x65B9;&#x9762;&#xFF0C;&#x8FD8;&#x80FD;&#x63D0;&#x9AD8;&#x4E13;&#x4E1A;&#x82F1;&#x8BED;&#x6C34;&#x5E73;&#x3002;&#x6839;&#x636E;&#x8C03;&#x67E5;&#xFF0C;&#x4E0A;&#x6D77;&#x73B0;&#x6709;ACCA&#x4F1A;&#x5458;&#x5E74;&#x85AA;&#x5728;10&#x4E07;&#x5230;80&#x4E07;&#x4E4B;&#x95F4;&#xFF0C;&#x7F3A;&#x70B9;&#x5728;&#x4E8E;&#x62A5;&#x540D;&#x548C;&#x57F9;&#x8BAD;&#x8D39;&#x7528;&#x7A0D;&#x5FAE;&#x6709;&#x70B9;&#x9AD8;&#x3002;</p><p>&#x53C2;&#x52A0;&#x4E0A;&#x8FF0;&#x4E24;&#x9879;&#x8003;&#x8BD5;&#x5728;&#x56FD;&#x5185;&#x4F01;&#x4E1A;(&#x5305;&#x62EC;&#x5916;&#x8D44;)&#x4E2D;&#x7684;&#x8BA4;&#x53EF;&#x7A0B;&#x5EA6;&#x975E;&#x5E38;&#x9AD8;&#xFF0C;&#x62E5;&#x6709;ACCA&#x8BA4;&#x8BC1;&#x56E0;&#x4E3A;&#x5176;&#x77E5;&#x8BC6;&#x5168;&#x9762;&#xFF0C;&#x5982;&#x679C;&#x8981;&#x8DF3;&#x5165;&#x5916;&#x4F01;&#xFF0C;&#x7EDD;&#x5BF9;&#x662F;&#x518D;&#x597D;&#x4E0D;&#x8FC7;&#x7684;&#x8D44;&#x8D28;&#x4E86;&#xFF0C;&#x5728;&#x5176;&#x4E2D;&#x7684;&#x53D1;&#x5C55;&#x4E5F;&#x5C06;&#x987A;&#x5229;&#x4E0D;&#x5C11;&#x3002;</p><p>&#x8981;&#x60F3;&#x901A;&#x8FC7;&#x5173;&#x952E;&#x5728;&#x4E8E;&#x575A;&#x6301;&#xFF0C;&#x6CE8;&#x518C;&#x4F1A;&#x8BA1;&#x5E08;&#x8003;&#x8BD5;&#x7684;&#x901A;&#x8FC7;&#x7387;&#x4F4E;&#x662F;&#x51FA;&#x4E86;&#x540D;&#x7684;&#x3002;&#x5B83;&#x5BF9;&#x6BCF;&#x79D1;(&#x300A;&#x4F1A;&#x8BA1;&#x300B;&#x3001;&#x300A;&#x8D22;&#x52A1;&#x6210;&#x672C;&#x7BA1;&#x7406;&#x300B;&#x3001;&#x300A;&#x5BA1;&#x8BA1;&#x300B;&#x3001;&#x300A;&#x7A0E;&#x6CD5;&#x300B;&#x3001;&#x300A;&#x7ECF;&#x6D4E;&#x6CD5;&#x300B;)&#x7684;&#x77E5;&#x8BC6;&#x70B9;&#x8003;&#x67E5;&#x7684;&#x7279;&#x522B;&#x7EC6;&#xFF0C;ACCA&#x7684;&#x57F9;&#x8BAD;&#x5168;&#x7403;&#x901A;&#x8FC7;&#x7387;&#x5728;50%&#x5DE6;&#x53F3;&#xFF0C;&#x6210;&#x4E3A;&#x4F1A;&#x5458;&#x9700;&#x8981;&#x901A;&#x8FC7;&#x8003;&#x8BD5;&#x540E;&#x9700;3&#x5E74;&#x5DE5;&#x4F5C;&#x7ECF;&#x9A8C;&#x3002;</p><p><img src=\"http://p3-tt.bytecdn.cn/large/19f90001d3b34601fcce\" fingerprint\": \"7981896164186496092\", \"hash_id\": 14130635617518503234, \"height\": 300, \"hit_group_count\": 0, \"image_type\": 1, \"md5\": \"c41a1a3a10ac454259563a91c434a448\", \"mimetype\": \"image jpeg\", \"near_dup_id\": \"9002540875427748553\", \"ocr_text\": \"\", \"web_uri\": \"19f90001d3b34601fcce\", \"width\": 450}\" height=\"300\" width=\"450\"></p><p><strong>&#x4E8C;</strong><strong>&#x3001;</strong><strong>&#x5916;&#x8D44;&#x4F01;&#x4E1A;</strong></p><p><strong> &#x804C;&#x4E1A;&#x7279;&#x70B9;&#xFF1A;</strong><span>&#x5F85;&#x9047;&#x597D;&#xFF0C;&#x5B66;&#x5F97;&#x4E13;&#x4E1A;&#x3002;</span></p><p><strong>&#x804C;&#x4E1A;&#x72B6;&#x51B5;&#xFF1A;</strong></p><p>&#x5927;&#x90E8;&#x5206;&#x5916;&#x8D44;&#x4F01;&#x4E1A;&#x7684;&#x540C;&#x7B49;&#x5C97;&#x4F4D;&#x5F85;&#x9047;&#x90FD;&#x8FDC;&#x5728;&#x5185;&#x8D44;&#x4F01;&#x4E1A;&#x4E4B;&#x4E0A;&#x3002;&#x66F4;&#x91CD;&#x8981;&#x7684;&#x662F;&#xFF0C;&#x5916;&#x8D44;&#x4F01;&#x4E1A;&#x8D22;&#x52A1;&#x7BA1;&#x7406;&#x4F53;&#x7CFB;&#x548C;&#x65B9;&#x6CD5;&#x90FD;&#x6210;&#x719F;&#xFF0C;&#x5BF9;&#x65B0;&#x5458;&#x5DE5;&#x4E00;&#x822C;&#x90FD;&#x4F1A;&#x8FDB;&#x884C;&#x4E00;&#x6BB5;&#x65F6;&#x95F4;&#x7684;&#x4E13;&#x4E1A;&#x57F9;&#x8BAD;&#x3002;&#x5DE5;&#x4F5C;&#x6548;&#x7387;&#x9AD8;&#x7684;&#x5176;&#x4E2D;&#x4E00;&#x4E2A;&#x539F;&#x56E0;&#x662F;&#x5206;&#x5DE5;&#x7EC6;&#x81F4;&#xFF0C;&#x800C;&#x5206;&#x5DE5;&#x7684;&#x7EC6;&#x81F4;&#x4F7F;&#x6211;&#x4EEC;&#x5728;&#x6240;&#x8D1F;&#x8D23;&#x5C97;&#x4F4D;&#x4E0A;&#x53EA;&#x80FD;&#x5B66;&#x5230;&#x67D0;&#x4E00;&#x65B9;&#x9762;&#x7684;&#x77E5;&#x8BC6;&#xFF0C;&#x5C3D;&#x7BA1;&#x8FD9;&#x79CD;&#x6280;&#x80FD;&#x975E;&#x5E38;&#x4E13;&#x4E1A;&#xFF0C;&#x4F46;&#x5BF9;&#x6574;&#x4E2A;&#x804C;&#x4E1A;&#x53D1;&#x5C55;&#x8FC7;&#x7A0B;&#x4E0D;&#x5229;&#xFF0C;&#x56E0;&#x4E3A;&#x4F60;&#x96BE;&#x4EE5;&#x83B7;&#x5F97;&#x5168;&#x9762;&#x7684;&#x8D22;&#x52A1;&#x63A7;&#x5236;&#x3001;&#x5206;&#x6790;&#x7B49;&#x7ECF;&#x9A8C;&#x3002;&#x540E;&#x7EED;&#x57F9;&#x8BAD;&#x673A;&#x4F1A;&#x591A;&#x662F;&#x5916;&#x4F01;&#x6781;&#x5177;&#x8BF1;&#x60D1;&#x529B;&#x7684;&#x53E6;&#x4E00;&#x4E2A;&#x539F;&#x56E0;&#x3002;&#x8D22;&#x52A1;&#x7BA1;&#x7406;&#x4E5F;&#x662F;&#x4E00;&#x4E2A;&#x7ECF;&#x9A8C;&#x4E0E;&#x77E5;&#x8BC6;&#x8D8A;&#x591A;&#x8D8A;&#x503C;&#x94B1;&#x7684;&#x804C;&#x4E1A;&#xFF0C;&#x800C;&#x4F01;&#x4E1A;&#x63D0;&#x4F9B;&#x7684;&#x57F9;&#x8BAD;&#x673A;&#x4F1A;&#x4E0D;&#x540C;&#x4E8E;&#x5728;&#x5B66;&#x6821;&#x542C;&#x8001;&#x5E08;&#x8BB2;&#x8BFE;&#xFF0C;&#x5B83;&#x66F4;&#x8D34;&#x8FDB;&#x5B9E;&#x9645;&#x5DE5;&#x4F5C;&#xFF0C;&#x4E5F;&#x66F4;&#x9002;&#x7528;&#x3002;</p><p><strong>&#x5C31;&#x4E1A;</strong><strong>&#x5EFA;&#x8BAE;&#xFF1A;</strong></p><p>&#x8981;&#x8FDB;&#x5916;&#x4F01;&#xFF0C;&#x82F1;&#x8BED;&#x597D;&#x662F;&#x524D;&#x63D0;&#x3002;&#x7136;&#x540E;&#x5982;&#x679C;&#x80FD;&#x901A;&#x8FC7;CBRA&#x6216;ACCA&#x8003;&#x8BD5;&#x7684;&#x51E0;&#x95E8;&#x8BFE;&#x7A0B;&#xFF0C;&#x4E5F;&#x80FD;&#x589E;&#x52A0;&#x4E00;&#x4E9B;&#x781D;&#x7801;&#x3002;</p><p>&#x591A;&#x770B;&#x9762;&#x8BD5;&#x7ECF;&#x9A8C;&#x8C08;&#x3002;&#x5916;&#x4F01;&#x7684;&#x9762;&#x8BD5;&#x5927;&#x90FD;&#x662F;&#x52A8;&#x771F;&#x683C;&#x7684;&#xFF0C;&#x800C;&#x4E14;&#x65B9;&#x5F0F;&#x5947;&#x602A;(&#x501F;&#x7528;&#x67D0;&#x540C;&#x5B66;&#x7684;&#x8BDD;)&#x3002;&#x5F88;&#x591A;&#x540C;&#x5B66;&#x7684;&#x4E13;&#x4E1A;&#x529F;&#x5E95;&#x548C;&#x82F1;&#x6587;&#x6C34;&#x5E73;&#x90FD;&#x5F88;&#x4E0D;&#x9519;&#xFF0C;&#x6700;&#x540E;&#x5374;&#x62FF;&#x4E0D;&#x5230;Offer&#x7684;&#x539F;&#x56E0;&#x5C31;&#x5728;&#x4E8E;&#x4E0D;&#x9002;&#x5E94;&#x4ED6;&#x4EEC;&#x7684;&#x9762;&#x8BD5;&#x98CE;&#x683C;&#x3002;&#x5EFA;&#x8BAE;&#x5927;&#x5BB6;&#x5728;&#x7F51;&#x4E0A;&#x4E0B;&#x8F7D;&#x6216;&#x4E66;&#x5E97;&#x8D2D;&#x4E70;&#x4E00;&#x4E9B;&#x76EE;&#x6807;&#x5355;&#x4F4D;&#x7684;&#x9762;&#x8BD5;&#x8D44;&#x6599;&#xFF0C;&#x63D0;&#x524D;&#x6F14;&#x7EC3;&#x548C;&#x719F;&#x6089;&#xFF0C;&#x987A;&#x4FBF;&#x4E5F;&#x6CE8;&#x610F;&#x4E00;&#x4E0B;&#x5E94;&#x8058;&#x5176;&#x4ED6;&#x73AF;&#x8282;&#x7684;&#x4E8B;&#x9879;&#xFF0C;&#x4F8B;&#x5982;&#x7740;&#x88C5;&#x548C;&#x8868;&#x8FBE;&#x7B49;&#x7B49;&#x3002;</p><p>&#x6700;&#x8FD1;&#xFF0C;&#x6CD5;&#x5F8B;+&#x8D22;&#x4F1A;&#x7684;&#x6CD5;&#x52A1;&#x4F1A;&#x8BA1;&#x4E5F;&#x662F;&#x5F88;&#x53D7;&#x4E0A;&#x5E02;&#x516C;&#x53F8;&#x548C;&#x5916;&#x8D44;&#x4F01;&#x4E1A;&#x6B22;&#x8FCE;&#x7684;&#x4EBA;&#x624D;&#x3002;&#x9009;&#x4FEE;&#x4E86;&#x6CD5;&#x5F8B;&#x4E13;&#x4E1A;&#x5E76;&#x6709;&#x6240;&#x6210;&#x5C31;&#x6216;&#x62FF;&#x5230;&#x6CD5;&#x5B66;&#x7B2C;&#x4E8C;&#x5B66;&#x4F4D;&#x7684;&#x540C;&#x5B66;&#xFF0C;&#x5176;&#x53D1;&#x5C55;&#x524D;&#x9014;&#x4E5F;&#x5F88;&#x5149;&#x660E;&#x3002;</p><p><img src=\"http://p3-tt.bytecdn.cn/large/19f2000032a86e16e158\" fingerprint\": \"11927340044629988968\", \"hash_id\": 12827567803597969906, \"height\": 300, \"hit_group_count\": 0, \"image_type\": 1, \"md5\": \"b204acf439b1d9f2b7a0dfe88034a87a\", \"mimetype\": \"image jpeg\", \"near_dup_id\": \"13307689406874358433\", \"ocr_text\": \"\", \"web_uri\": \"19f2000032a86e16e158\", \"width\": 460}\" height=\"300\" width=\"460\"></p></div></body></html>";
        [_webView loadHTMLString:[head stringByAppendingString:htmlString] baseURL: [NSURL URLWithString:@"http://p3-tt.bytecdn.cn/large"]];
        [_webView.scrollView setScrollEnabled: NO];
        // 监听webview, 实现高度自适应
        [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}


@end


