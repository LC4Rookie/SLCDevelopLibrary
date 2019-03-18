//
//  CAGradientLayer+LCAdd.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "CAGradientLayer+LCAdd.h"

@implementation CAGradientLayer (LCAdd)

/** 根据色值和frame创建CAGradientLayer */
+ (CAGradientLayer *)gradientLayerWithLayerFrame:(CGRect)frame
                                       colorData:(NSArray *)colorArray {
    
    //创建颜色变化点数组 0-1.0
    NSMutableArray *locationsArray = [NSMutableArray array];
    //颜色变化间距
    CGFloat intervalSpace = (1 / (colorArray.count - 1));
    [colorArray enumerateObjectsUsingBlock:^(id color, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            [locationsArray addObject:@0];
        }else if (idx == colorArray.count - 1) {
            [locationsArray addObject:@1];
        }else {
            [locationsArray addObject:@(intervalSpace)];
        }
    }];
    //CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.colors = colorArray;
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = locationsArray;
    return gradientLayer;
}

@end
