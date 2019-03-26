//
//  UtilsMacros.h
//  SLCDevelopLibrary
//
//  Created by 宋林城 on 2018/6/27.
//  Copyright © 2018年 宋林城. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h


#define kAppDelegate [AppDelegate shareAppDelegate]

//偏好设置
#define NSUSERDEFAULTS [NSUserDefaults standardUserDefaults]

//获取屏幕宽高
#define KScreenWidth [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height

//状态栏高度
#define KStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNavBarHeight 44
//tabbar高度
#define KTabBarHeight (KStatusBarHeight > 20) ? 83 : 49
//整个导航栏高度
#define KNavTopHeight (KStatusBarHeight + KNavBarHeight)
#define KSafeAreaBottomHeight (KStatusBarHeight > 20 ? 34 : 0)

//控件tag(0~100为苹果预留字段，去较大值自用防止根据tag去控件出现其他控件)
#define KControlTag 10000
//获取控件原始tag
#define KOriginalTag(tag) (tag - KControlTag)

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//app自用颜色
#define KAppBlueColor UIColorFromHex(0x5d9ffa)
#define KAppGrayColor UIColorFromHex(0x999999)
#define KAppShallowGrayColor UIColorFromHex(0xdee1eb)
//颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorFromHex(hex) [UIColor colorWithRed:(((hex & 0xFF0000) >> 16)) / 255.0 green:(((hex & 0xFF00) >> 8)) / 255.0 blue:((hex & 0xFF)) / 255.0 alpha:1.0]
#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)        //随机色生成

//字体
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//弱引用
#define QDAWeakSelf __weak __typeof(self) weakSelf = self

/** 自定义NSLog **/
#ifdef DEBUG
# define DebugLog(fmt, ...) NSLog((@"[文件名:%@]""[行号:%d]\n" fmt), [self class], __LINE__, ##__VA_ARGS__);
#else
# define DebugLog(...);
#endif

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif /* UtilsMacros_h */
