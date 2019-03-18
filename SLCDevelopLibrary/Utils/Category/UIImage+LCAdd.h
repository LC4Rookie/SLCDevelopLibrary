//
//  UIImage+LCAdd.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LCAdd)

/** 根据颜色创建图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/** 根据色值和渐变层结构创建渐变色图片 */
+ (UIImage *)imageWithGradientData:(NSMutableArray <UIColor *>*)gradientArray
                gradientLayerFrame:(CGRect)frame;

/** 根据view创建图片 */
+ (UIImage *)imageWithView:(UIView *)view;

/** 根据图片名返回一张能够自由拉伸的图片 */
+ (UIImage *)imageWithResizing:(NSString*)name;

/** 图片裁剪*/
+ (UIImage *)compressImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth;

/** 图片裁剪*/
+ (UIImage *)compressImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth targetHeight:(CGFloat)targetHeight;

/** 获取视频缩略图 */
+ (UIImage *)videoThumbnail:(NSURL *)Url;

@end
