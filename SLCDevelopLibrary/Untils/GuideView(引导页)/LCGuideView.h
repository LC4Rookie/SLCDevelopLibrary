//
//  LCGuideView.h
//  SLCDevelopLibrary
//
//  Created by boy on 2018/7/6.
//  Copyright © 2018年 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCGuideView : UIView

/** 是否显示分页控件 */
@property (assign, nonatomic) BOOL isShowPageView;
/** 是否显示结束按钮 */
@property (assign, nonatomic) BOOL isShowEnterButton;
/** 当前分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *currentPageDotColor;
/** 其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageDotColor;

- (instancetype)initWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageNamesGroup;
- (instancetype)initWithFrame:(CGRect)frame imageNamesGroup:(NSArray *)imageUrlStringsGroup placeholderImage:(UIImage *)placeholderImage;
@end
