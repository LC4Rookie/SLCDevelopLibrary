//
//  UIViewController+LCAdd.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LCAdd)

- (void)addBackButton:(NSString *)buttonName;
- (void)hideBackButton;
/** 返回点击 */
- (void)backButtonClicked;
/** 导航栏添加文字按钮 */
- (void)addNavigationItemWithTitles:(NSArray *)titles textColor:(UIColor *)color isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;
/** 导航栏添加图标按钮 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;

@end
