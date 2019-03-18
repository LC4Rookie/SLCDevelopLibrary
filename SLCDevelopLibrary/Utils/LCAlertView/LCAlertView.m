//
//  LCAlertView.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/21.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "LCAlertView.h"

@implementation LCAlertView

/** 弹出提示框 */
+ (void)showSingleAlertViewWithMessage:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    //添加确定到UIAlertController中
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

/** 弹出单一响应按钮提示框，点击返回响应事件 */
+ (void)showSingleResponseAlertViewWithMessage:(NSString *)message
                                   actionTitle:(NSString *)actionTitle
                                 actionHandler:(LCActionHandler)actionHandler {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)  {
        actionHandler(0);
    }];
    [alertController addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

/** 弹出提示框，点击返回下标 */
+ (void)showAlertViewWithType:(UIAlertControllerStyle)type
                        title:(NSString *)title
                      message:(NSString *)message
                 actionTitles:(NSArray *)actionTitles
                actionHandler:(LCActionHandler)actionHandler{
    
    if (![actionTitles count]) {
        return;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:type];
    for (NSUInteger i = 0; i < actionTitles.count; i++) {
        NSString *actionTitle = [actionTitles objectAtIndex:i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)  {
            actionHandler(i);
        }];
        [alertController addAction:action];
    }
    if (type == UIAlertControllerStyleActionSheet) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action)  {
            actionHandler(actionTitles.count);
        }];
        [alertController addAction:action];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}

@end
