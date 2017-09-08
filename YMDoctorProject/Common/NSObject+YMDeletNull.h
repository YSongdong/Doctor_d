//
//  NSObject+YMDeletNull.h
//  doctor_user
//
//  Created by kupurui on 17/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YMDeletNull)
- (NSDictionary *)deleteNull:(NSDictionary *)dic;
- (void)whriteToFielWith:(NSDictionary *)dic;
- (NSDictionary *)readDic;

- (void)writeContactsWithArray:(NSArray *)array ;

- (NSArray  *)readArray ;

@end
