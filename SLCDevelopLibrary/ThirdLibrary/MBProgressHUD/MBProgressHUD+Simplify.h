//
//  MBProgressHUD+Simplify.h
//  FarmManager
//
//  Created by 宋林城 on 2017/6/16.
//  Copyright © 2017年 Sinocode. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Simplify)

/** 普通hud展示 */
+ (void)showHud;

/** 普通hud展示 */
+ (void)showHudToView:(UIView *)view;

/** 带文字hud展示 */
+ (void)showWithStatus:(NSString *)status ToView:(UIView *)view;

/** 提示hud展示 */
+ (void)showAlertHud:(NSString *)status ToView:(UIView *)view;

/** 带文字+延时消失hud展示 */
+ (void)showWithStatus:(NSString *)status
                ToView:(UIView *)view
            afterDelay:(NSTimeInterval)delay;

/** 带文字+图片+延时消失hud展示 */
+ (void)showWithStatus:(NSString *)status
                  icon:(NSString *)icon
                ToView:(UIView *)view
            afterDelay:(NSTimeInterval)delay;

/** hud隐藏 */
+ (void)hideHud;

/** hud隐藏 */
+ (void)hideHudForView:(UIView *)view;
@end
