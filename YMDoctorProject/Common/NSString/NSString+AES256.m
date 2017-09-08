//
//  NSString+AES256.m
//  Encode
//
//  Created by fenyounet on 16/6/17.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "NSString+AES256.h"
#import "NSData+AES_256_.h"
#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (AES256)

- (NSString *)aes256_encript:(NSString *)key {
    
    const char *cstr =[self cStringUsingEncoding:NSUTF8StringEncoding];

    
    
    
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    NSData *result = [data aes256_encript:key];
    
    
    if (result &&result.length > 0) {
        Byte *datas = (Byte *)[result bytes];
        NSMutableString *outPut = [NSMutableString stringWithCapacity:result.length *2];
        for (int i = 0; i< result.length; i ++) {
            [outPut appendFormat:@"%02x",datas[i]];
        }
        return [outPut uppercaseString];
        
    }
    return nil;
}

-(NSString *) aes256_decrypt:(NSString *)key
{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data aes256_decript:key];
    if (result && result.length > 0) {

        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

//MD5加密
-(NSString *)signString:(NSString*)origString
{
    const char *original_str = [origString UTF8String];
    unsigned char result[32];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);//调用md5
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

@end
