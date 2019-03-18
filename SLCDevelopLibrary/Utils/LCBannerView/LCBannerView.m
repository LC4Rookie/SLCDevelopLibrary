//
//  LCBannerView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "LCBannerView.h"
#import "SDCycleScrollView.h"

@interface LCBannerView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation LCBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = KWhiteColor;
        self.bezierRadianHeight = 15;
        self.isUp = YES;
        self.radianFillColor = KWhiteColor;
        
        [self addSubview:self.cycleScrollView];
        
        [self layoutPageSubviews];
    }
    return self;
}

- (void)layoutPageSubviews {
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(bannerViewDidSelectAtIndex:)]) {
        [self.delegate bannerViewDidSelectAtIndex:index];
    }
}

#pragma mark - private method
- (void)drawRadian {
    
    CGSize finalSize = CGSizeMake(self.cycleScrollView.width, self.cycleScrollView.height);
    CGFloat layerHeight = self.bezierRadianHeight;
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    UIBezierPath *bezier = [[UIBezierPath alloc] init];
    bezier.lineWidth = 0;
    //+1、-1是为了防止图片尺寸过于充满页面导致剪裁留底边
    if (self.isUp) {
        [bezier moveToPoint:(CGPointMake(-1, finalSize.height + 1))];
        [bezier addQuadCurveToPoint:CGPointMake(finalSize.width + 1, finalSize.height + 1) controlPoint:CGPointMake(finalSize.width / 2, finalSize.height - layerHeight)];
    }else {
        [bezier moveToPoint:(CGPointMake(-1, finalSize.height - layerHeight))];
        [bezier addLineToPoint:(CGPointMake(-1, finalSize.height + 1))];
        [bezier addLineToPoint:(CGPointMake(finalSize.width + 1, finalSize.height + 1))];
        [bezier addLineToPoint:(CGPointMake(finalSize.width + 1, finalSize.height - layerHeight))];
        [bezier addQuadCurveToPoint:CGPointMake(-1, finalSize.height - layerHeight) controlPoint:CGPointMake(finalSize.width / 2, finalSize.height)];
    }
    [self.radianFillColor set];
    [bezier stroke];
    layer.path = bezier.CGPath;
    layer.fillColor = self.radianFillColor.CGColor;
    [self.cycleScrollView.layer addSublayer:layer];
}

#pragma mark - getters and setters
- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
        _cycleScrollView = [[SDCycleScrollView alloc] init];
        _cycleScrollView.backgroundColor = KWhiteColor;
        _cycleScrollView.contentMode = UIViewContentModeScaleToFill;
        _cycleScrollView.clipsToBounds = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.hidesForSinglePage = YES;
        _cycleScrollView.autoScroll = YES;
        _cycleScrollView.autoScrollTimeInterval = 5.0f;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}

- (void)setPlaceholderImageName:(NSString *)placeholderImageName {
    
    _placeholderImageName = placeholderImageName;
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:placeholderImageName];
}

- (void)setLocalizationImageNamesGroup:(NSArray *)localizationImageNamesGroup {
    
    _localizationImageNamesGroup = localizationImageNamesGroup;
    self.cycleScrollView.localizationImageNamesGroup = localizationImageNamesGroup;
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray {
    
    _imageUrlArray = imageUrlArray;
    self.cycleScrollView.imageURLStringsGroup = imageUrlArray;
}

- (void)setBezierRadianHeight:(NSInteger)bezierRadianHeight {
    
    _bezierRadianHeight = bezierRadianHeight;
}

- (void)setIsUp:(BOOL)isUp {
    
    _isUp = isUp;
}

- (void)setRadianFillColor:(UIColor *)radianFillColor {
    
    _radianFillColor = radianFillColor;
}

@end
