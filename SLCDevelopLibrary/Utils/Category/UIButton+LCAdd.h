//
//  UIButton+LCAdd.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LCButtonEdgeInsetsStyle) {
    /** image在上，label在下 */
    LCButtonEdgeInsetsStyleTop,
    /** image在左，label在右 */
    LCButtonEdgeInsetsStyleLeft,
    /** image在下，label在上 */
    LCButtonEdgeInsetsStyleBottom,
    /** image在右，label在左 */
    LCButtonEdgeInsetsStyleRight
};

@interface UIButton (EnlargeTouchArea)

/** 扩大button点击范围 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;
@end

@interface UIButton (LCAdd)

/** 设置button的titleLabel和imageView的布局样式及间距 */
- (void)layoutButtonWithEdgeInsetsStyle:(LCButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
