//
//  NSString+BitusStringUtils.m
//  Kartor
//
//  Created by cluries on 14-4-2.
//  Copyright (c) 2014年 cn.cstonline. All rights reserved.
//

#import "NSString+BitusStringUtils.h"

static NSDateFormatter *__dateFormatter;

@implementation NSString (BitusStringUtils)

+ (void)initialize
{
    if (self == [NSString class]) {
        if (__dateFormatter == nil) {
            __dateFormatter = [NSDateFormatter new];
            // http://www.skyfox.org/ios-formatter-daylight-saving-time.html
            // 夏令时导致某些时候时间解析返回nil问题
            [__dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:3600*8]];
        }
    }
}

- (NSString*) trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



/**
 *  如果自己为nil或者NSNull的话，方法不会执行，需要在外面判断nil
 *  只判断有值情况
 *  @return
 */
- (BOOL) isEmpty
{
    return self.length < 1;
}

/**
 *  判断是否为空，当obj为nil、NSNull或者空串时，判断为空，否则不为空（只针对字符串）
 *  @return 空返回YES，不为空返回NO
 */
+ (BOOL)isEmpty:(id)obj
{
    if(obj) {
        if([obj isKindOfClass:[NSString class]]) { // 只用于判断NSString
            NSString *temp = [(NSString *)obj trim];
            if(![temp isBlank] && ![temp isEqual:[NSNull null]]) { // 字符串不为空
                return NO;
            } else { // 字符串为空
                return YES;
            }
        } else {
            return YES;
        }
    } else {
        return YES;
    }
}



/**
 *  如果自己为nil或者NSNull的话，方法不会执行，需要在外面判断nil
 *  只判断有值情况，判断字符是否为空白符
 *  @return
 */
- (BOOL) isBlank
{
    //去掉空白符
    NSString *noBlankChar = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    noBlankChar = [noBlankChar stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return [noBlankChar isEmpty];
}


@end
