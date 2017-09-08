//
//  NSDictionary+Unicode.h
//  TestPlist
//
//  Created by archerzz on 15/7/28.
//  Copyright (c) 2015年 archerzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Unicode)

- (NSString*)my_description;

@end


@interface NSArray (Unicode)

- (NSString*)my_description;

@end

@interface NSString (UrlEncode)

// 将中文编码成url
- (NSString *)urlEncodeString;

@end