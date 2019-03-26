//
//  LCViewControllerIntercepter.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/26.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "LCViewControllerIntercepter.h"
#import <Aspects/Aspects.h>

@interface LCViewControllerIntercepter ()<UIGestureRecognizerDelegate>

@end

@implementation LCViewControllerIntercepter

+ (void)load {
    /* + (void)load 会在应用启动的时候自动被runtime调用，通过重载这个方法来实现最小的对业务方的“代码入侵” */
    [super load];
    [LCViewControllerIntercepter sharedInstance];
}

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static LCViewControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LCViewControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        /* 在这里做好方法拦截 */
        [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            NSString *className = NSStringFromClass([aspectInfo.instance class]);
            if ([self isValidClass:className]) {
                [self loadView:[aspectInfo instance]];
            }
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            NSString *className = NSStringFromClass([aspectInfo.instance class]);
            if ([self isValidClass:className]) {
                [self viewWillAppear:animated viewController:[aspectInfo instance]];
            }
        } error:NULL];
    }
    return self;
}

#pragma mark - private method
- (BOOL)isValidClass:(NSString *)className {
    
    if ([className isEqualToString:@"UIAlertController"] || [className isEqualToString:@"UIInputWindowController"]) {
        return NO;
    }
    return YES;
}

#pragma mark - fake methods
- (void)loadView:(UIViewController *)viewController {
    
    viewController.view.backgroundColor = KWhiteColor;
    [viewController addBackButton:@"icon_back"];
    viewController.edgesForExtendedLayout = UIRectEdgeNone;
    viewController.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated viewController:(UIViewController *)viewController {
    
    viewController.navigationController.navigationBar.translucent = NO;
    //默认开启系统右划返回
    viewController.navigationController.interactivePopGestureRecognizer.enabled = YES;
    viewController.navigationController.interactivePopGestureRecognizer.delegate = self;
}

@end
