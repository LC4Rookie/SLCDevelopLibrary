//
//  LCSortView.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCSortView;
@class LCSortDataModel;

@protocol LCSortViewDelegate <NSObject>

@optional
- (void)sortView:(LCSortView *)view didSelectItemAtIndex:(NSInteger)index;

@end

@interface LCSortView : UIView

@property (nonatomic, weak) id<LCSortViewDelegate> delegate;

/** 每行显示的数量 */
@property (nonatomic, assign) NSInteger row;
/** 显示的行数 */
@property (nonatomic, assign) NSInteger section;
/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;
/** 分类的model数组 */
@property (nonatomic, copy) NSArray <LCSortDataModel *>*sortDataArray;

/** 更新布局 */
- (void)updateSortViewLayout;
@end
