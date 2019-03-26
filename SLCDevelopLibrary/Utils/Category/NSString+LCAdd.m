//
//  NSString+LCAdd.m
//  SLCDevelopLibrary
//
//  Created by LCSong on 2019/2/25.
//  Copyright © 2019年 宋林城. All rights reserved.
//

#import "NSString+LCAdd.h"

@implementation NSString (LCAdd)

/** 多语言转换 */
+ (NSString *)stringMultilingualConvert:(NSString *)string {
    
    NSString *languageNumber = [NSUSERDEFAULTS objectForKey:@"languageNumber"];
    if (kStringIsEmpty(languageNumber)) {
        languageNumber = @"0";
    }
    NSString *stringTable;
    switch (languageNumber.integerValue) {
        case 0:
            stringTable = @"ChineseLanguage";
            break;
        case 1:
            stringTable = @"EnglishLanguage";
            break;
        case 2:
            stringTable = @"JapaneseLanguage";
            break;
        default:
            stringTable = @"ChineseLanguage";
            break;
    }
    NSString *test = NSLocalizedStringFromTable(string, stringTable, nil);
    return test;
}

/** 中划线 */
+ (NSMutableAttributedString *)centerLine:(NSString *)string {
    
    NSDictionary *attribtDic =@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attribtDic];
    return attribtStr;
}

/** 获取制定长度随机字符串 */
+ (NSString *)randomStringWithLength:(NSInteger)length {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (NSInteger i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

/** 根据日期获取工作日（周几） */
+ (NSString *)weekdayForDate:(NSDate *)date {
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay) fromDate:date];
    NSString *weekday;
    switch ([components weekday]) {
        case 1:
            weekday = @"周日";
            break;
        case 2:
            weekday = @"周一";
            break;
        case 3:
            weekday = @"周二";
            break;
        case 4:
            weekday = @"周三";
            break;
        case 5:
            weekday = @"周四";
            break;
        case 6:
            weekday = @"周五";
            break;
        case 7:
            weekday = @"周六";
            break;
        default:
            break;
    }
    return weekday;
}

/** 去除字符串括号数据 */
+ (NSString *)stringByRemoverBracketDataOfString:(NSString *)string {
    
    NSMutableString *mutableString = [NSMutableString stringWithString:string];
    while (1) {
        NSRange range = [mutableString rangeOfString:@"("];
        NSRange range1 = [mutableString rangeOfString:@")"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [mutableString deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }
    return mutableString;
}

/** 获取文字尺寸 */
+ (CGSize)rectOfString:(NSString *)string stringFont:(UIFont *)font {
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(2000, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return size;
}

@end
