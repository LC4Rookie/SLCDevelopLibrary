//
//  LCPhotoDataModel.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCPhotoDataModel : NSObject

/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *photoArray;
/** 占位图片 */
@property (nonatomic, copy) NSString *placeholderImageName;
/** 进行添加或其他操作的按钮图片 */
@property (nonatomic, copy) NSString *operationImageName;
/** 最大图片数 默认3 */
@property (nonatomic, assign) NSInteger maxShowPhotoCount;
/** 每行图片数量 默认4 */
@property (nonatomic, assign) NSInteger numberForLine;
/** item宽度 */
@property (nonatomic, assign) NSInteger photoItemWidth;
/** 是否允许从相册读取图片 */
@property (nonatomic, assign) BOOL isAllowReadImageFromLibrary;
/** 是否只允许查看 */
@property (nonatomic, assign) BOOL isOnlyAllowCheck;
/** 图片是否圆角 */
@property (nonatomic, assign) BOOL fillet;

/** 图片行数 */
- (CGFloat)LCPhotoViewNumberOfRow;
@end

NS_ASSUME_NONNULL_END
