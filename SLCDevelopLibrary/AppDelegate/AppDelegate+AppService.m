//
//  AppDelegate+AppService.m
//  SLCDevelopLibrary
//
//  Created by 宋林城 on 2018/6/27.
//  Copyright © 2018年 宋林城. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "MainTabBarController.h"
#import "LCGuideView.h"

@implementation AppDelegate (AppService)

/** 初始化 window */
- (void)initWindow {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    MainTabBarController *tabBarController = [[MainTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    if ([self isFirstLauch]) {
        LCGuideView *guideView = [[LCGuideView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) imageNamesGroup:@[@"1.jpg", @"1.jpg", @"1.jpg", @"1.jpg"]];
        [self.window addSubview:guideView];
    }
    [self addLaunchAnimation];
    
    [[UIButton appearance] setExclusiveTouch:YES];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    //设置全局cell分割线与屏幕等宽
    [[UITableView appearance] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [[UITableView appearance] setSeparatorInset:UIEdgeInsetsZero];
    [[UITableViewCell appearance] setSeparatorInset:UIEdgeInsetsZero];
    
    if ([UITableView instancesRespondToSelector:@selector(setLayoutMargins:)]) {
        [[UITableView appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
        [[UITableViewCell appearance] setPreservesSuperviewLayoutMargins:NO];
    }
}

- (BOOL)isFirstLauch {
    
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    //版本升级或首次登录
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:@"version"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}

/** 添加启动动画(此方法要在rootviewcontroller之后添加) */
- (void)addLaunchAnimation {
    
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [mainWindow addSubview:viewController.view];
    [self.window bringSubviewToFront:viewController.view];
    //添加广告图
    /*
     UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDHT, 300)];
     NSString *str = @"http://upload-images.jianshu.io/upload_images/746057-6e83c64b3e1ec4d2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
     [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default1.jpg"]];
     [viewController.view addSubview:imageV];
     */
    [UIView animateWithDuration:0.6f delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        viewController.view.alpha = 0.0f;
        viewController.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
    } completion:^(BOOL finished) {
        [viewController.view removeFromSuperview];
    }];
    
}

@end
