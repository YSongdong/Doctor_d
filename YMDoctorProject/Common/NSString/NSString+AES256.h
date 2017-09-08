//
//  NSString+AES256.h
//  Encode
//
//  Created by fenyounet on 16/6/17.
//  Copyright © 2016年 fenyou. All rights reserved.
//


#import <Foundation/Foundation.h>
@interface NSString (AES256)
- (NSString *)aes256_encript:(NSString *)key ;
- (NSString *)aes256_decrypt:(NSString *)key ;
-(NSString *)signString:(NSString*)origString;
@end
