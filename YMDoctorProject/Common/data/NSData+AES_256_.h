//
//  NSData+AES_256_.h
//  Encode
//
//  Created by fenyounet on 16/6/17.
//  Copyright © 2016年 fenyou. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSData (AES_256_)

-(NSData *)aes256_encript:(NSString *)key ;

- (NSData *)aes256_decript:(NSString *)key;


- (NSData *)AES256EncryptWithKey:(NSData *)key;
- (NSData *)AES256DecryptWithKey:(NSData *)key;

@end
