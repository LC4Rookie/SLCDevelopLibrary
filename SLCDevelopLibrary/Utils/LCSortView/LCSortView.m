//
//  LCSortView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "LCSortView.h"
#import "LCSortDataModel.h"
#import "UIButton+WebCache.h"

@interface LCSortView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation LCSortView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.row = 4;
        self.section = 2;
        self.showPageControl = YES;
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 0, 10, 0));
    }];
    [self.scrollView.superview layoutIfNeeded];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom);
    }];
}

#pragma mark - event response
- (void)buttonClick:(UIButton *)sender {
    
    NSInteger index = KOriginalTag(sender.tag);
    if ([self.delegate respondsToSelector:@selector(sortView:didSelectItemAtIndex:)]) {
        [self.delegate sortView:self didSelectItemAtIndex:index];
    }
}

#pragma mark - private method
- (void)layoutSortItem {
    
    CGFloat buttonWidth = self.scrollView.width / self.row;
    CGFloat buttonHeight = self.scrollView.height / self.section;
    for (int i = 0; i < self.sortDataArray.count; i++) {
        //先查找是否控件已存在
        id control = [self viewWithTag:i + KControlTag];
        BOOL isExistControl = [control isKindOfClass:[UIButton class]];
        //控件初始
        UIButton *button = isExistControl ? control : [[UIButton alloc] init];
        if (!isExistControl) {
            NSInteger page = i / (self.row * self.section);
            //左、上间距随行数累加
            CGFloat leftSpace = (i % self.row) * (buttonWidth) + self.width * page;
            CGFloat topSpace = (i / self.row % self.section) * buttonHeight;
            button.frame = CGRectMake(leftSpace, topSpace, buttonWidth, buttonHeight);
            button.tag = i + KControlTag;
            button.titleLabel.font = SYSTEMFONT(12);
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setTitleColor:KBlackColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
        }
        //创建赋值
        LCSortDataModel *dataModel = [self.sortDataArray objectAtIndex:i];
        [button setTitle:dataModel.sortName forState:UIControlStateNormal];
        NSString *imageData = dataModel.sortImageData;
        CGFloat imageSize = (buttonWidth > buttonHeight) ? (buttonWidth - 20) : (buttonHeight - 20);
        //字符串 判断是否为url
        if ([imageData rangeOfString:@"http"].location != NSNotFound) {
            //url
            [button sd_setImageWithURL:[NSURL URLWithString:imageData] forState:UIControlStateNormal placeholderImage:[UIImage imageWithColor:KGrayColor] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                image = [UIImage compressImage:image targetWidth:imageSize targetHeight:imageSize];
                [button setImage:image forState:UIControlStateNormal];
                [button layoutButtonWithEdgeInsetsStyle:LCButtonEdgeInsetsStyleTop imageTitleSpace:5];
            }];
        }else {
            //本地
            UIImage *image = [UIImage compressImage:[UIImage imageNamed:imageData] targetWidth:imageSize targetHeight:imageSize];
            [button setImage:image forState:UIControlStateNormal];
            [button layoutButtonWithEdgeInsetsStyle:LCButtonEdgeInsetsStyleTop imageTitleSpace:5];
        }
    }
}

- (void)updateSortViewLayout {
    
    //移除button
    for (id control in self.subviews) {
        if ([control isKindOfClass:[UIButton class]]) {
            UIButton *button = control;
            if (button.tag >= KControlTag) {
                [button removeFromSuperview];
            }
        }
    }
    //重新布局
    [self layoutSortItem];
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES; //使用翻页属性
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

- (void)setRow:(NSInteger)row {
    
    _row = row;
}

- (void)setSection:(NSInteger)section {
    
    _section = section;
}

- (void)setShowPageControl:(BOOL)showPageControl {
    
    _showPageControl = showPageControl;
    self.pageControl.hidden = !showPageControl;
}

- (void)setSortDataArray:(NSArray<LCSortDataModel *> *)sortDataArray {
    
    _sortDataArray = sortDataArray;
    //计算scrollView.contentSize
    NSInteger divideValue = (sortDataArray.count / (self.row * self.section));
    NSInteger page = (sortDataArray.count % (self.row * self.section)) ? (divideValue + 1) : divideValue;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * page, self.scrollView.height);
    //布局
    [self layoutSortItem];
}

@end
