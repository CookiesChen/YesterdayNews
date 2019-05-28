//
//  NewsTableViewCell.m
//  YesterdayNews
//
//  Created by 陈统盼 on 2019/5/28.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Colours.h>

@interface NewsTableViewCell()

@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *author;
@property(nonatomic, strong) UILabel *comment;
@property(nonatomic, strong) UILabel *time;
@property(nonatomic, strong) UIImageView *headImg;
@property(nonatomic, strong) UIImageView *newsImg;
@property(nonatomic, strong) UIView *gray;

@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

#pragma mark 初始化视图
-(void) initSubView {
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.author];
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.headImg];
    [self.contentView addSubview:self.gray];
}

#pragma mark 设置
- (void) setNewsItem:(News *)newsItem {
    _newsItem = newsItem;
    [self.title setText:newsItem.title];
    [self.author setText:newsItem.author];
    [self.time setText:[TimeUtils getTimeDifference:newsItem.time]];
    
    CGRect frame = [self frame];
    
    if(newsItem.tag == 0) {
        [self.title setFrame:CGRectMake(60, 55, self.contentView.frame.size.width - 120, 50)];
        [self.gray setFrame:CGRectMake(0, 100, self.contentView.frame.size.width, 5)];
        frame.size.height = 105;
    }
    else if(newsItem.tag == 1) {
        [self.title setFrame:CGRectMake(60, 55, self.contentView.frame.size.width - 200, 50)];
        [self.gray setFrame:CGRectMake(0, 140, self.contentView.frame.size.width, 5)];
        [self.newsImg sd_setImageWithURL:[NSURL URLWithString:newsItem.images[0]] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        [self.contentView addSubview:self.newsImg];
        frame.size.height = 145;
    }
    
    self.frame = frame;
    [super setFrame:frame];
    
}

- (void)setFrameWidth:(CGFloat) width {
    CGRect frame = [self frame];
    frame.size.width = width;
    self.contentView.frame = frame;
    [super setFrame:frame];
}

- (UILabel *)title {
    if(_title == nil) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(60, 55, self.contentView.frame.size.width, 50)];
        _title.textColor = [UIColor blackColor];
        [_title setFont: [UIFont systemFontOfSize: 16]];
        _title.numberOfLines = 0;
    }
    return _title;
}

- (UILabel *)author {
    if(_author == nil) {
        _author = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, self.frame.size.width, 20)];
        _author.textColor = [UIColor blackColor];
        [_author setFont: [UIFont systemFontOfSize: 15]];
    }
    return _author;
}

- (UILabel *)comment {
    if(_comment == nil) {
        
    }
    return _comment;
}

- (UILabel *)time {
    if(_time == nil) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, self.frame.size.width, 10)];
        _time.textColor = [UIColor grayColor];
        [_time setFont: [UIFont systemFontOfSize: 12]];
    }
    return _time;
}

- (UIView *)gray {
    if(_gray == nil) {
        _gray = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 5)];
        [_gray setBackgroundColor:[UIColor colorFromHexString:@"#efeff4"]];
    }
    return _gray;
}

- (UIImageView *)headImg {
    if(_headImg == nil) {
        _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
        [_headImg setImage:[UIImage imageNamed:@"headImg"]];
    }
    return _headImg;
}

- (UIImageView *)newsImg {
    if(_newsImg == nil) {
        _newsImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 120, 55, 100, 70)];
        _newsImg.contentMode = UIViewContentModeScaleAspectFill;
        _newsImg.clipsToBounds = YES;
    }
    return _newsImg;
}

@end
