//
//  LCGuideView.m
//  SLCDevelopLibrary
//
//  Created by boy on 2018/7/6.
//  Copyright © 2018年 宋林城. All rights reserved.
//

#import "LCGuideView.h"
#import "UIImageView+WebCache.h"

@interface LCGuideView()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *page;
@property (strong, nonatomic) UIButton *enterButton;
@property (copy, nonatomic) NSArray *localImageNameArray;
@property (copy, nonatomic) NSArray *imageUrlStringsArray;
@property (strong, nonatomic) UIImage *placeholderImage;
@end

@implementation LCGuideView

#pragma mark - life cyclic
- (instancetype)initWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup {
    
    self = [[LCGuideView alloc] initWithFrame:frame];
    self.localImageNameArray = imageNamesGroup;
    self.isShowPageView = YES;
    self.isShowEnterButton = YES;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageUrlStringsGroup placeholderImage:(UIImage *)placeholderImage {
    
    self = [[LCGuideView alloc] initWithFrame:frame];
    self.placeholderImage = placeholderImage;
    self.imageUrlStringsArray = imageUrlStringsGroup;
    self.isShowPageView = YES;
    self.isShowEnterButton = YES;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        
        [self addSubview:self.scrollView];
        [self addSubview:self.page];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.page mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - scrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    int cuttentIndex = (int)(scrollView.contentOffset.x + KScreenWidth / 2) / KScreenWidth;
    //如果是最后一页左滑
    if (cuttentIndex == self.page.numberOfPages - 1) {
        BOOL isScrollToLeft = [self isScrollToLeft:scrollView];
        BOOL isHiddenEnterButton = self.isShowEnterButton == NO;
        BOOL isHideGuideView = isScrollToLeft && isHiddenEnterButton;
        if (isHideGuideView) {
            [self hideGuideView];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //修改page的显示
    if (scrollView == self.scrollView) {
        int cuttentIndex = (int)(scrollView.contentOffset.x + KScreenWidth / 2) / KScreenWidth;
        self.page.currentPage = cuttentIndex;
    }
}

#pragma mark - event response
- (void)enterButtonClick:(UIButton *)sender {
    
    [self hideGuideView];
}

#pragma mark - private method
/** 隐藏引导页 */
- (void)hideGuideView {
    //动画隐藏
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        //延迟0.5秒移除
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
    }];
}

/** 是否向左滑动 */
- (BOOL)isScrollToLeft:(UIScrollView *)scrollView {
    
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        return YES;
    }else{
        return NO;
    }
}

- (void)layoutEnterButton:(UIImageView *)imageView {
    
    [imageView addSubview:self.enterButton];
    imageView.userInteractionEnabled = YES;
    [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.bottom.mas_equalTo(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)page {
    
    if (!_page) {
        _page = [[UIPageControl alloc] init];
        _page.currentPage = 0;
        _page.backgroundColor = [UIColor clearColor];
        _page.defersCurrentPageDisplay = YES;
    }
    return _page;
}

- (UIButton *)enterButton {
    
    if (!_enterButton) {
        _enterButton = [[UIButton alloc] init];
        [_enterButton setTitle:@"点击进入" forState:UIControlStateNormal];
        [_enterButton addTarget:self action:@selector(enterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}

- (void)setIsShowPageView:(BOOL)isShowPageView {
    
    self.page.hidden = !isShowPageView;
}

- (void)setIsShowEnterButton:(BOOL)isShowEnterButton {
    
    self.enterButton.hidden = !isShowEnterButton;
}

- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor {
    
    self.page.currentPageIndicatorTintColor = currentPageDotColor;
}

- (void)setPageDotColor:(UIColor *)pageDotColor {
    
    self.page.pageIndicatorTintColor = pageDotColor;
}

- (void)setLocalImageNameArray:(NSArray *)localImageNameArray {
    
    _localImageNameArray = localImageNameArray;
    self.scrollView.contentSize = CGSizeMake(KScreenWidth * localImageNameArray.count, KScreenHeight);
    self.page.numberOfPages = localImageNameArray.count;
    for (int i = 0; i < localImageNameArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KScreenWidth, 0, KScreenWidth, KScreenHeight)];
        imageView.image = [UIImage imageNamed:[localImageNameArray objectAtIndex:i]];
        [self.scrollView addSubview:imageView];
        if (i == localImageNameArray.count - 1) {
            [self layoutEnterButton:imageView];
        }
    }
}

- (void)setImageUrlStringsArray:(NSArray *)imageUrlStringsArray {
    
    _imageUrlStringsArray = imageUrlStringsArray;
    self.scrollView.contentSize = CGSizeMake(KScreenWidth * imageUrlStringsArray.count, KScreenHeight);
    self.page.numberOfPages = imageUrlStringsArray.count;
    for (int i = 0; i < imageUrlStringsArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KScreenWidth, 0, KScreenWidth, KScreenHeight)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[imageUrlStringsArray objectAtIndex:i]] placeholderImage:self.placeholderImage];
        [self.scrollView addSubview:imageView];
        if (i == imageUrlStringsArray.count - 1) {
            [self layoutEnterButton:imageView];
        }
    }
}

@end
