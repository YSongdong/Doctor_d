//
//  NSObject+YMDeletNull.m
//  doctor_user
//
//  Created by kupurui on 17/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "NSObject+YMDeletNull.h"

@implementation NSObject (YMDeletNull)
- (NSDictionary *)deleteNull:(NSDictionary *)dic{
    
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in dic) {
        
        if ([[dic objectForKey:keyStr] isEqual:[NSNull null]]) {
            
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            
            [mutableDic setObject:[dic objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}

- (void)whriteToFielWith:(NSDictionary *)dic {
    //需求一：创建xxx/Documents/test文件夹
    //1.拼接文件夹的路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *testDirPath = [documentsPath stringByAppendingPathComponent:@"test.plist"];
    //2.获取NSFileManager单例对象(shared/default/standard)
    if ([dic writeToFile:testDirPath atomically:YES]) {
        NSLog(@"写入成功");
    }
   
}
- (NSDictionary *)readDic {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *testDirPath = [documentsPath stringByAppendingPathComponent:@"test.plist"];
    return [NSDictionary dictionaryWithContentsOfFile:testDirPath];
}

- (void)writeContactsWithArray:(NSArray *)array {
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *testDirPath = [documentsPath stringByAppendingPathComponent:@"friend"];
    //2.获取NSFileManager单例对象(shared/default/standard)
    if ([array writeToFile:testDirPath atomically:YES]) {
        NSLog(@"写入成功");
    }
}

- (NSArray  *)readArray {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *testDirPath = [documentsPath stringByAppendingPathComponent:@"friend"];
    return [NSArray arrayWithContentsOfFile:testDirPath];
    
}
@end
