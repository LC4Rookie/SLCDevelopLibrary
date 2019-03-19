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
@property (nonatomic, strong) NSString *title;
/** 用于取dataArray中字典对应显示 不传代表dataArray直接由字符串组成 */
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic) UIDatePickerMode datePickerMode;
/** 设置日期显示的最大时间 */
@property (nonatomic, strong) NSDate *maxDate;
/** 设置日期显示的最小时间 */
@property (nonatomic, strong) NSDate *minDate;

- (instancetype)initWithPickerViewType:(LCPickerViewType)type;
- (void)showPickerView;
@end

NS_ASSUME_NONNULL_END
