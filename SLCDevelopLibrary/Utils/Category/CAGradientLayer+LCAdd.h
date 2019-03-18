//
//  CAGradientLayer+LCAdd.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAGradientLayer (LCAdd)

/** 根据色值和frame创建CAGradientLayer */
+ (CAGradientLayer *)gradientLayerWithLayerFrame:(CGRect)frame
                                       colorData:(NSArray *)colorArray;

@end
