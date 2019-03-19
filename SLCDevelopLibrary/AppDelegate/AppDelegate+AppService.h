//
//  AppDelegate+AppService.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/3/19.
//  Copyright © 2019 宋林城. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppService)

/** 单例 */
+ (AppDelegate *)shareAppDelegate;

/** 初始化 window */
- (void)initWindow;

/** 当前顶层控制器 */
- (UIViewController*)getCurrentVC;
/** 当前顶层UI控制器 */
- (UIViewController*)getCurrentUIVC;
@end

NS_ASSUME_NONNULL_END
