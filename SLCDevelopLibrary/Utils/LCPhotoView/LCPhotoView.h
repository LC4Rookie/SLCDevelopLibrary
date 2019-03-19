//
//  LCPhotoView.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCPhotoDataModel;
@class LCPhotoView;

NS_ASSUME_NONNULL_BEGIN

@protocol LCPhotoViewDelegate <NSObject>

@optional
/** 图片发生变化回调 */
- (void)LCPhotoView:(LCPhotoView *)view photosArrayDidChange:(NSArray *)photoArray;
- (void)LCPhotoView:(LCPhotoView *)view photoContainerView:(UICollectionView *)containerView didSelectAtIndex:(NSInteger)index;

@end

@interface LCPhotoView : UIView

@property (nonatomic, weak) id<LCPhotoViewDelegate> delegate;
@property (nonatomic, strong) LCPhotoDataModel *model;
@end

NS_ASSUME_NONNULL_END
