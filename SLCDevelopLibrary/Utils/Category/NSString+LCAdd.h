//
//  NSString+LCAdd.h
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LCAdd)

/** 多语言转换 */
+ (NSString *)stringMultilingualConvert:(NSString *)string;

/** 中划线 */
+ (NSMutableAttributedString *)centerLine:(NSString *)string;

/** 获取制定长度随机字符串 */
+ (NSString *)randomStringWithLength:(NSInteger)length;

/** 根据日期获取工作日（周几） */
+ (NSString *)weekdayForDate:(NSDate *)date;

/** 去除字符串括号数据 */
+ (NSString *)stringByRemoverBracketDataOfString:(NSString *)string;

/** 获取文字尺寸 */
+ (CGSize)rectOfString:(NSString *)string stringFont:(UIFont *)font;

@end
