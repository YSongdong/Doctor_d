//
//  YMCaseDetailsDayInformationModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseDetailsDayInformationModel.h"

@implementation YMCaseDetailsDayInformationModel

-(NSString *)year{
    if (![NSString isEmpty:_d_time]) {
        return [_d_time substringWithRange:NSMakeRange(0,5)];
    }
    return @"";
}

-(NSString *)month{
    if (![NSString isEmpty:_d_time]) {
        return [_d_time substringWithRange:NSMakeRange(5,3)];
    }
    return @"";
}
-(NSString *)day{
    if (![NSString isEmpty:_d_time]) {
        return [_d_time substringWithRange:NSMakeRange(_d_time.length-3,3)];
    }
    return @"";
}

@end
