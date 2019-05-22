//
//  ImageCell.m
//  YesterdayNews
//
//  Created by Cookieschen on 2019/5/13.
//  Copyright © 2019 Cookieschen. All rights reserved.
//

#import "ImageCell.h"
#import <SDWebImage/SDWebImage.h>

static const CGFloat MAXPIXEL = 4096.0;

@interface ImageCell()

@end

@implementation ImageCell

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self setupView];
    }
    return self;
}

- (void) setupView {
    [self setBackgroundColor:[UIColor whiteColor]];
    self.mainImageView = [[UIImageView alloc] init];
    [self.mainImageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview: self.mainImageView];
}

# pragma setter
- (void)setData:(id)data {
    _data = data;
    self.mainImageView.image = nil;
    CGFloat padding = 5, imageViewLength = ([UIScreen mainScreen].bounds.size.width - padding * 2) / 3 - 10, scale = [UIScreen mainScreen].scale;
    CGSize imageViewSize = CGSizeMake(imageViewLength * scale, imageViewLength * scale);
    if ([data isKindOfClass:NSString.class]) {
        
        NSString *imageStr = (NSString *)data;
        __block BOOL isBigImage = NO;
        // web url
        if ([imageStr hasPrefix:@"http"]) {
            [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
        } else { // file url
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *type = imageStr.pathExtension;
                NSString *resource = imageStr.stringByDeletingPathExtension;
                NSString *filePath = [[NSBundle mainBundle] pathForResource:resource ofType:type];
                NSData *nsData = [NSData dataWithContentsOfFile:filePath];
                UIImage *image = [UIImage imageWithData:nsData];
                
                if (image.size.width * image.scale * image.size.height * image.scale > MAXPIXEL * MAXPIXEL)
                    isBigImage = YES;
                
                if (isBigImage) {
                    CGSize size = CGSizeMake(imageViewSize.width, image.size.height / image.size.width * imageViewSize.width);
                    UIGraphicsBeginImageContext(size);
                    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
                    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.data == data) self.mainImageView.image = scaledImage;
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.data == data) self.mainImageView.image = image;
                    });
                }
            });
        }
    } else {
        self.mainImageView.image = nil;
    }
}

@end
