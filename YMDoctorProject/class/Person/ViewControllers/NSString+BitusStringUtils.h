//
//  NSString+BitusStringUtils.h
//  Kartor
//
//  Created by cluries on 14-4-2.
//  Copyright (c) 2014年 cn.cstonline. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BitusStringUtils)

- (NSString *)trim;
+ (NSString *)trim:(NSString *)str;
+ (BOOL)isEmpty:(id)obj;

@end
