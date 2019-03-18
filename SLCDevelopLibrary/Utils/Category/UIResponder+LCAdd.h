//
//  UIResponder+LCAdd.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (LCAdd)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
- (NSInvocation *)createInvocationWithSelector:(SEL)selector;

@end
