//
//  LCNavigationControllerIntercepter.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/26.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "LCNavigationControllerIntercepter.h"
#import <Aspects/Aspects.h>

@interface LCNavigationControllerIntercepter ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation LCNavigationControllerIntercepter

+ (void)load {
    /* + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵” */
    [super load];
    [LCNavigationControllerIntercepter sharedInstance];
}

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static LCNavigationControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LCNavigationControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        /* 在这里做好方法拦截 */
        [UINavigationController aspect_hookSelector:@selector(initialize) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            [self initialize];
        } error:NULL];
        
        [UINavigationController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewDidLoad:[aspectInfo instance]];
        } error:NULL];
        
        [UINavigationController aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewDidLoad:[aspectInfo instance]];
        } error:NULL];
        
        [UINavigationController aspect_hookSelector:@selector(gestureRecognizerShouldBegin:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            [self viewDidLoad:[aspectInfo instance]];
        } error:NULL];
    }
    return self;
}

#pragma mark - fake methods
- (void)initialize {
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置导航栏背景颜色
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KWhiteColor] forBarMetrics:UIBarMetricsDefault];
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:KBlackColor];
    //设置状态栏+标题栏颜色
    navigationBar.barStyle = UIStatusBarStyleDefault;
    [navigationBar setShadowImage:[UIImage new]];//去掉阴影线
}

- (void)viewDidLoad:(UINavigationController *)navigationController {
    
    //默认开启系统右划返回
    navigationController.interactivePopGestureRecognizer.enabled = YES;
    navigationController.interactivePopGestureRecognizer.delegate = self;
}

//拦截所有的要pushd的控制器
- (void)pushViewController:(UIViewController *)viewController navigationController:(UINavigationController *)navigationController animated:(BOOL)animated {
    
    if (navigationController.viewControllers.count > 0) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [navigationController pushViewController:viewController animated:animated];
}

//根视图禁用右划返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer navigationController:(UINavigationController *)navigationController {
    
    return navigationController.childViewControllers.count == 1 ? NO : YES;
}

@end
