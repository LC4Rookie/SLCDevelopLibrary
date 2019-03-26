//
//  MainTabBarController.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/26.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "MainTabBarController.h"
#import "RootNavigationController.h"
#import "HomeViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

#pragma mark - life cyclic
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    //初始化tabbar
    [self setUpTabBar];
    //添加子控制器
    [self setUpAllChildViewController];
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

/** 初始化TabBar */
- (void)setUpTabBar {
    
    self.tabBar.translucent = NO;
    //设置背景色 去掉分割线
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundImage:[UIImage new]];
}

/** 初始化VC */
- (void)setUpAllChildViewController {
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    [self setupChildViewController:homeViewController title:@"首页" imageName:@"icon_mainNormal" seleceImageName:@"icon_mainSelect"];
    HomeViewController *homeViewController1 = [[HomeViewController alloc] init];
    [self setupChildViewController:homeViewController1 title:@"首页" imageName:@"icon_mainNormal" seleceImageName:@"icon_mainSelect"];
}

- (void)setupChildViewController:(UIViewController*)controller title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName {
    
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //未选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KGrayColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateNormal];
    //选中字体颜色
    [controller.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KBlackColor,NSFontAttributeName:SYSTEMFONT(10.0f)} forState:UIControlStateSelected];
    //包装导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

@end
