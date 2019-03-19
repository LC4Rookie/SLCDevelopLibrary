//
//  LCPhotoInfoCollectionViewCell.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCPhotoInfoCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface LCPhotoInfoCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LCPhotoInfoCollectionViewCell

#pragma mark - life cyclic
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
}

#pragma mark - private method
/** 添加图片 */
- (void)setImageData:(id)imageData {
    
    [self setImageData:imageData placeholderImageName:nil isFillet:NO];
}

/** 添加带占位图的图片 */
- (void)setImageData:(id)imageData placeholderImageName:(NSString * __nullable)imageName {
    
    [self setImageData:imageData placeholderImageName:imageName isFillet:NO];
}

/** 添加带占位图及是否圆角的图片 */
- (void)setImageData:(id)imageData placeholderImageName:(NSString * __nullable)placeholderImageName isFillet:(BOOL)fillet {
    
    if ([imageData isKindOfClass:[NSData class]]) {
        //data
        self.imageView.image = [UIImage imageWithData:imageData];
    }else if ([imageData isKindOfClass:[UIImage class]]){
        self.imageView.image = imageData;
    }else if ([imageData isKindOfClass:[NSString class]]) {
        UIImage *placeholderImage = kStringIsEmpty(placeholderImageName) ? [UIImage imageWithColor:KGrayColor] : [UIImage imageNamed:placeholderImageName];
        //字符串 判断是否为url
        if ([imageData rangeOfString:@"http"].location != NSNotFound || [imageData rangeOfString:@"ftp"].location != NSNotFound) {
            //url
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageData] placeholderImage:placeholderImage options:SDWebImageAllowInvalidSSLCertificates];
        }else {
            //本地
            self.imageView.image = [UIImage imageNamed:imageData];
        }
    }else {
        //暂无处理
    }
    //处理是否圆角
    if (fillet) {
        self.imageView.layer.cornerRadius = self.imageView.width / 2;
    }else {
        self.imageView.layer.cornerRadius = 0;
    }
}

#pragma mark - getters and setters
- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

@end
