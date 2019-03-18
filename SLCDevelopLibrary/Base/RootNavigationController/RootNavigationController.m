//
//  RootNavigationController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/26.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation RootNavigationController

#pragma mark - life cyclic
+ (void)initialize {
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置导航栏背景颜色
    [navigationBar setBackgroundImage:[UIImage imageWithColor:KWhiteColor] forBarMetrics:UIBarMetricsDefault];
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:KBlackColor];
    //设置状态栏+标题栏颜色
    navigationBar.barStyle = UIStatusBarStyleDefault;
    [navigationBar setShadowImage:[UIImage new]];//去掉阴影线
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认开启系统右划返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

//拦截所有的要pushd的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//根视图禁用右划返回
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return self.childViewControllers.count == 1 ? NO : YES;
}

@end
