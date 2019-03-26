//
//  LCBannerView.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCBannerView;

@protocol LCBannerViewDelegate <NSObject>

@optional
- (void)bannerView:(LCBannerView *)view didSelectAtIndex:(NSInteger)index;

@end

@interface LCBannerView : UIView

@property (nonatomic, weak) id<LCBannerViewDelegate> delegate;

/** 占位图 */
@property (nonatomic, copy) NSString *placeholderImageName;
/** 网络图片url数组 */
@property (nonatomic, copy) NSArray *imageUrlArray;
/** 本地图片数组 */
@property (nonatomic, copy) NSArray *localizationImageNamesGroup;

#pragma mark - bezier
/** 贝塞尔弧线高度 默认15 */
@property (nonatomic, assign) NSInteger bezierRadianHeight;
/** 弧线是否向上 默认YES */
@property (nonatomic, assign) BOOL isUp;
/** 填充颜色 默认白色 */
@property (nonatomic, strong) UIColor *radianFillColor;
/** 画弧线 */
- (void)drawRadian;
@end
