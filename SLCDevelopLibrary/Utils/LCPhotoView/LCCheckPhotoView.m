//
//  LCCheckPhotoView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCCheckPhotoView.h"
#import "UIImageView+WebCache.h"

@interface LCCheckPhotoView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LCCheckPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.imageView];
        
        [self addGesture];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    self.imageView.center = [self centerOfScrollViewContent:scrollView];
}

#pragma mark - event response
- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer {
    
    CGPoint touchPoint = [recognizer locationInView:self];
    if (self.scrollView.zoomScale <= 1.0) {
        CGFloat scaleX = touchPoint.x + self.scrollView.contentOffset.x;//需要放大的图片的X点
        CGFloat sacleY = touchPoint.y + self.scrollView.contentOffset.y;//需要放大的图片的Y点
        [self.scrollView zoomToRect:CGRectMake(scaleX, sacleY, 10, 10) animated:YES];
    } else {
        [self.scrollView setZoomScale:1.0 animated:YES]; //还原
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [self removeFromSuperview];
}

#pragma mark - private method
- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
    
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}

/** 添加手势 */
- (void)addGesture {
    
    //    //添加双击手势
    //    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    //    doubleTapGesture.numberOfTapsRequired = 2;
    //    doubleTapGesture.numberOfTouchesRequired = 1;
    //    [self addGestureRecognizer:doubleTapGesture];
    //添加单击空白返回手势
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTapGesture];
    
    //    //只有当doubleTapGesture识别失败的时候(即识别出这不是双击操作)，singleTapGesture才能开始识别
    //    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
}

/** 添加图片 */
- (void)setImageData:(id)imageData {
    
    [self setImageData:imageData placeholderImageName:nil];
}

/** 添加带占位图的图片 */
- (void)setImageData:(id)imageData placeholderImageName:(NSString * __nullable)imageName {
    
    if ([imageData isKindOfClass:[NSData class]]) {
        //data
        self.imageView.image = [UIImage imageWithData:imageData];
    }else if ([imageData isKindOfClass:[UIImage class]]){
        self.imageView.image = imageData;
    }else if ([imageData isKindOfClass:[NSString class]]) {
        UIImage *placeholderImage = kStringIsEmpty(imageName) ? [UIImage imageWithColor:KGrayColor] : [UIImage imageNamed:imageName];
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
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.clipsToBounds = YES;
        [_scrollView setMaximumZoomScale:2.0];
        [_scrollView setMinimumZoomScale:0.5];
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

@end
