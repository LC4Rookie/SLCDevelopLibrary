//
//  NSDate+LCAdd.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCAdd)

/** 根据日期字符串及formatter获取日期 */
+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)dateFormat;
+ (NSDate *)dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;

/** 根据formatter转换为日期字符串 */
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale;
@end
