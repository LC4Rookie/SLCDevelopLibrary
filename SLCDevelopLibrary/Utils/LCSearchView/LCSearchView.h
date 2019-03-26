//
//  LCSearchView.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/25.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCSearchView;

NS_ASSUME_NONNULL_BEGIN

@protocol LCSearchViewDelegate <NSObject>

@optional
- (void)searchView:(LCSearchView *)view textShouldBeginEditing:(NSString *)searchText;
- (void)searchView:(LCSearchView *)view textDidChange:(NSString *)searchText;
- (void)searchView:(LCSearchView *)view textShouldReturn:(NSString *)searchText;

@end

@interface LCSearchView : UIView

@property (nonatomic, weak) id<LCSearchViewDelegate> delegate;
@property (nonatomic, copy) NSString *searchInfo;
@property (nonatomic, copy) NSString *placeholder;
/** 是否隐藏输入框左侧view */
@property (nonatomic, assign) BOOL hiddenLeftView;
/** 输入框背景 */
@property (nonatomic, strong) UIColor *inputControlBackground;

- (void)becomeFirstResponder;
- (void)resignFirstResponder;
/** 添加渐变背景layer */
- (void)addBackgroundLayer:(CAGradientLayer *)layer;
@end

NS_ASSUME_NONNULL_END
