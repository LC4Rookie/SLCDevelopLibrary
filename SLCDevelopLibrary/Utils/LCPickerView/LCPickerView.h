//
//  LCPickerView.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCPickerView;

typedef NS_ENUM(NSInteger, LCPickerViewType) {
    /** 数据类型 */
    LCPickerViewTypeData,
    /** 日期类型 */
    LCPickerViewTypeDate,
};

NS_ASSUME_NONNULL_BEGIN

@protocol LCPickerViewDelegate <NSObject>

@optional
- (void)pickerView:(LCPickerView *)pickerView didSelectRow:(NSInteger)row;
- (void)pickerView:(LCPickerView *)pickerView didChangeDate:(NSDate *)date;
@end

@interface LCPickerView : UIView

@property (nonatomic, weak) id<LCPickerViewDelegate> delegate;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 顶部view背景 （标题+取消按钮+确认按钮 父视图） */
@property (nonatomic, strong) UIColor *topViewBackgroundColor;
/** 取消按钮标题 默认“取消” 传空值隐藏 */
@property (nonatomic, copy) NSString *cancelTitle;
/** 确认按钮标题 默认“确定” 传空值隐藏 */
@property (nonatomic, copy) NSString *confirmTitle;
/** 取消按钮文字颜色 */
@property (nonatomic, strong) UIColor *cancelTextColor;
/** 确认按钮文字颜色 */
@property (nonatomic, strong) UIColor *confirmTextColor;
/** 用于取dataArray中字典对应显示 不传代表dataArray直接由字符串组成 */
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic) UIDatePickerMode datePickerMode;
/** 设置日期显示的最大时间 */
@property (nonatomic, strong) NSDate *maxDate;
/** 设置日期显示的最小时间 */
@property (nonatomic, strong) NSDate *minDate;

- (instancetype)initWithPickerViewType:(LCPickerViewType)type;
- (void)showPickerView;
@end

NS_ASSUME_NONNULL_END
