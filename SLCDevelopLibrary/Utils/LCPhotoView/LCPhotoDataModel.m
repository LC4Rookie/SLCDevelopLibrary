//
//  LCPhotoDataModel.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "LCPhotoDataModel.h"

@implementation LCPhotoDataModel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.isAllowReadImageFromLibrary = YES;
        self.isOnlyAllowCheck = NO;
        self.fillet = NO;
        self.photoArray = [NSMutableArray array];
        self.maxShowPhotoCount = 3;
        self.numberForLine = 4;
        self.photoItemWidth = (KScreenWidth - 50) / self.numberForLine;
        self.placeholderImageName = @"icon_imageNil";
        self.operationImageName = @"icon_add";
    }
    return self;
}

/** 图片行数 */
- (CGFloat)LCPhotoViewNumberOfRow {
    
    NSInteger photoCount = self.photoArray.count;
    //    if (photoCount == 0) {
    //        //图片数组为空
    //        return 0;
    //    }
    if (photoCount > self.maxShowPhotoCount) {
        //超出最大数量取最大显示数
        photoCount = self.maxShowPhotoCount;
    }
    NSInteger row = photoCount / self.numberForLine;
    NSInteger remain = photoCount % self.numberForLine;
    if (self.isOnlyAllowCheck) {
        //如果只允许查看不需要设计拍照按钮计算
        row = (remain == 0) ? row : (row + 1);
        return row;
    }
    //小于最大显示数量
    if (photoCount < self.maxShowPhotoCount) {
        return row + 1;
    }
    //等于最大显示数量时
    row = (remain == 0) ? row : (row + 1);
    return row;
}
@end
