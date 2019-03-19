//
//  LCNumberView.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/18.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCNumberView;

typedef NS_ENUM(NSInteger, LCNumberViewChangeType) {
    /** 加号按钮修改 */
    LCNumberViewChangeTypeAdd,
    /** 减号按钮修改 */
    LCNumberViewChangeTypeSubtract,
    /** 手动输入修改 */
    LCNumberViewChangeTypeInput,
};

NS_ASSUME_NONNULL_BEGIN

@protocol LCNumberViewDelegate <NSObject>

@optional
- (void)numberView:(LCNumberView *)view didChangeNumber:(NSString *)number changeType:(LCNumberViewChangeType)type;
@end

@interface LCNumberView : UIView

@property (nonatomic, weak) id<LCNumberViewDelegate> delegate;
/** 是否可以输入 */
@property (nonatomic, assign) BOOL isEditing;
/** 数量边框的颜色 */
@property (nonatomic, strong) UIColor *borderColor;
/** 加减按钮边框的颜色 */
@property (nonatomic, strong) UIColor *buttonBorderColor;
/** 加减按钮文字颜色 */
@property (nonatomic, strong) UIColor *buttonTitleColor;
/** 加减按钮背景色 */
@property (nonatomic, strong) UIColor *buttonBackgroundColor;
/** 当前数量 */
@property (nonatomic, copy) NSString *currentNumber;
@end

NS_ASSUME_NONNULL_END
