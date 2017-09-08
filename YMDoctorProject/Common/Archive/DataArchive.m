//
//  DataArchive.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DataArchive.h"

@implementation DataArchive


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        
        self = [aDecoder decodeObjectForKey:@"users"];
        
    }return self ;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:[self getArray] forKey:@"users"];
}


- (NSArray *)getArray {
    
    return nil ;
}


- (void)archiveWithArray:(NSArray *)array {
    
    
    
    
}
@end
