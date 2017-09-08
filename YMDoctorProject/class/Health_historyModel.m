//
//  Health_historyModel.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Health_historyModel.h"

@implementation Health_historyModel
-(NSString *)year{
    if (![NSString isEmpty:_history_time]) {
        return [_history_time substringWithRange:NSMakeRange(0,3)];
    }
    return @"";
}

-(NSString *)month{
    if (![NSString isEmpty:_history_time]) {
        return [_history_time substringWithRange:NSMakeRange(5,2)];
    }
    return @"";
}
-(NSString *)day{
    if (![NSString isEmpty:_history_time]) {
        return [_history_time substringWithRange:NSMakeRange(8,2)];
    }
    return @"";
}

@end
