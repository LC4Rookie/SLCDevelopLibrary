//
//  UIImage+LCAdd.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "UIImage+LCAdd.h"
#import <AVKit/AVKit.h>

@implementation UIImage (LCAdd)

/** 根据颜色创建图片 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    
    if (!color) {
        return nil;
    }
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 根据色值和渐变层结构创建渐变色图片 */
+ (UIImage *)imageWithGradientData:(NSMutableArray <UIColor *>*)gradientArray
                gradientLayerFrame:(CGRect)frame {
    
    //创建一个渐变色的view
    UIView *gradientView = [[UIView alloc] initWithFrame:frame];
    //创建渐变色数组，需要转换为CGColor颜色
    NSMutableArray *colorsArray = [NSMutableArray array];
    //创建颜色变化点数组 0-1.0
    NSMutableArray *locationsArray = [NSMutableArray array];
    //颜色变化间距
    CGFloat intervalSpace = (1 / (gradientArray.count - 1));
    [gradientArray enumerateObjectsUsingBlock:^(UIColor *color, NSUInteger idx, BOOL * _Nonnull stop) {
        [colorsArray addObject:(__bridge id)color.CGColor];
        if (idx == 0) {
            [locationsArray addObject:@0];
        }else if (idx == gradientArray.count - 1) {
            [locationsArray addObject:@1];
        }else {
            [locationsArray addObject:@(intervalSpace)];
        }
    }];
    //CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.colors = colorsArray;
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = locationsArray;
    [gradientView.layer addSublayer:gradientLayer];
    CGSize size = frame.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [gradientView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 根据view创建图片 */
+ (UIImage *)imageWithView:(UIView *)view {
    
    if (view == nil) {
        return nil;
    }
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需  要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 根据图片名返回一张能够自由拉伸的图片 */
+ (UIImage*)imageWithResizing:(NSString*)name {
    
    UIImage *img = [UIImage imageNamed:name];
    CGFloat w =img.size.width * 0.5;
    CGFloat h =img.size.height * 0.5;
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
    return img;
}

/** 图片裁剪*/
+ (UIImage *)compressImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth {
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIImage *newImage = [self compressImage:sourceImage targetWidth:targetWidth targetHeight:targetHeight];
    return newImage;
}

/** 图片裁剪*/
+ (UIImage *)compressImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth targetHeight:(CGFloat)targetHeight {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(targetWidth, targetHeight), NO, [UIScreen mainScreen].scale);
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/** 获取视频缩略图 */
+ (UIImage *)videoThumbnail:(NSURL *)Url {
    
    UIImage *shotImage;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:Url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [generator copyCGImageAtTime:time actualTime:&actualTime error:&error];
    shotImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return shotImage;
}

@end
