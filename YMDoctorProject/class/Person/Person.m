//
//  Person.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Person.h"

@implementation Person



+ (Person *)sharedPerosn {
    
   static Person *person = nil ;
    if (!person) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            person = [[Person alloc]init];
        });
    }
    return person ;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
