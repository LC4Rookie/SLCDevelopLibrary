//
//  UIViewController+LCAdd.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "UIViewController+LCAdd.h"

@implementation UIViewController (LCAdd)

- (void)addBackButton:(NSString *)buttonName {
    
    NSInteger VCCount = self.navigationController.viewControllers.count;
    //当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
    if ( VCCount > 1 || self.navigationController.presentingViewController != nil) {
        [self addNavigationItemWithImageNames:@[buttonName] isLeft:YES target:self action:@selector(backButtonClicked) tags:nil];
    }
}

- (void)hideBackButton {
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *NULLBar = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.leftBarButtonItem = NULLBar;
}

/** 返回点击 */
- (void)backButtonClicked {
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/** 导航栏添加文字按钮 */
- (void)addNavigationItemWithTitles:(NSArray *)titles textColor:(UIColor *)color isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags {
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50 * titles.count, KNavBarHeight)];
    NSInteger i = 0;
    for (NSString *title in titles) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = SYSTEMFONT(16);
        [btn setTitleColor:color forState:UIControlStateNormal];
        [btn sizeToFit];
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}];
        CGFloat width = (size.width < 40) ? 40 : 50;
        if (isLeft) {
            btn.frame = CGRectMake(width * i - 10, 0, width, 44);
            [btn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:10];
        }else{
            btn.frame = CGRectMake(width * i + 10, 0, width, 44);
            [btn setEnlargeEdgeWithTop:0 right:10 bottom:0 left:0];
        }
        btn.tag = [tags[i++] integerValue];
        [customView addSubview:btn];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

/** 导航栏添加图标按钮 */
- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags {
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40 * imageNames.count, KNavBarHeight)];
    NSInteger i = 0;
    for (NSString *imageName in imageNames) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        btn.userInteractionEnabled = (action);
        if (isLeft) {
            btn.frame = CGRectMake(40 * i - 10, 0, 40, 44);
            [btn setEnlargeEdgeWithTop:0 right:0 bottom:0 left:10];
        }else{
            btn.frame = CGRectMake(40 * i + 10, 0, 40, 44);
            [btn setEnlargeEdgeWithTop:0 right:10 bottom:0 left:0];
        }
        btn.tag = [tags[i++] integerValue];
        [customView addSubview:btn];
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:customView];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

@end
