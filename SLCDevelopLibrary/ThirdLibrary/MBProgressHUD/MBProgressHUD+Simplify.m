//
//  MBProgressHUD+Simplify.m
//  FarmManager
//
//  Created by 宋林城 on 2017/6/16.
//  Copyright © 2017年 Sinocode. All rights reserved.
//

#import "MBProgressHUD+Simplify.h"

@implementation MBProgressHUD (Simplify)

/** 普通hud展示 */
+ (void)showHud {
    
    [self showWithStatus:@"" ToView:nil afterDelay:0];
}

/** 普通hud展示 */
+ (void)showHudToView:(UIView *)view {
    
    [self showWithStatus:@"" ToView:view afterDelay:0];
}

/** 带文字hud展示 */
+ (void)showWithStatus:(NSString *)status ToView:(UIView *)view {
    
    [self showWithStatus:status ToView:view afterDelay:0];
}

/** 提示hud展示 */
+ (void)showAlertHud:(NSString *)status ToView:(UIView *)view {
    
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:status ToView:view];
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:1.5];
}

/** 带文字+延时消失hud展示 */
+ (void)showWithStatus:(NSString *)status
                ToView:(UIView *)view
            afterDelay:(NSTimeInterval)delay {
    
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:status ToView:view];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (delay > 0) {
        [hud hideAnimated:YES afterDelay:delay];
    }else {
        [hud hideAnimated:YES afterDelay:20];
    }
}

/** hud创建 */
+ (MBProgressHUD *)createMBProgressHUDviewWithMessage:(NSString*)message ToView:(UIView *)view {
    
    if (view == nil) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }else{
        [hud showAnimated:YES];
    }
    //是否设置黑色背景，这两句配合使用
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = message;
    hud.label.font = [UIFont systemFontOfSize:13.0];
    [hud setMinSize:CGSizeMake(100.0, 100.0)];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

/** 带文字+图片+延时消失hud展示 */
+ (void)showWithStatus:(NSString *)status
                  icon:(NSString *)icon
                ToView:(UIView *)view
            afterDelay:(NSTimeInterval)delay {
    
    if (view == nil) {
        view = (UIView *)[UIApplication sharedApplication].delegate.window;
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }else{
        [hud showAnimated:YES];
    }
    //是否设置黑色背景，这两句配合使用
    hud.bezelView.color = KAppGrayColor;
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = status;
    hud.label.font = [UIFont systemFontOfSize:13.0];
    [hud setMinSize:CGSizeMake(150.0, 150.0)];
    hud.removeFromSuperViewOnHide = YES;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    [hud hideAnimated:YES afterDelay:delay];
}

/** hud隐藏 */
+ (void)hideHud {
    
    UIView *winView = (UIView *)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[kAppDelegate getCurrentUIVC].view animated:YES];
}

/** 指定view隐藏 */
+ (void)hideHudForView:(UIView *)view {
    
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view animated:YES];
}

@end
