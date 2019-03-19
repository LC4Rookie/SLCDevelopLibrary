//
//  LCPhotoInfoCollectionViewCell.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCPhotoInfoCollectionViewCell : UICollectionViewCell

/** 添加图片 */
- (void)setImageData:(id)imageData;
/** 添加带占位图的图片 */
- (void)setImageData:(id)imageData placeholderImageName:(NSString * __nullable)imageName;

/**
 添加图片

 @param imageData 图片
 @param placeholderImageName 占位图片名称
 @param fillet 是否圆角
 */
- (void)setImageData:(id)imageData placeholderImageName:(NSString * __nullable)placeholderImageName isFillet:(BOOL)fillet;
@end

NS_ASSUME_NONNULL_END
