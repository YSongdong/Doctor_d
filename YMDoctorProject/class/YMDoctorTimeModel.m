//
//  YMDoctorTimeModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorTimeModel.h"

@implementation YMDoctorTimeModel

-(NSString *)week{
    if ([NSString isEmpty:_week]) {
        return @"";
    }else{
        switch ([_week integerValue]) {
            case 0:
                return @"周日";
                break;
            case 1:
                return @"周一";
                break;
            case 2:
                return @"周二";
                break;
            case 3:
                return @"周三";
                break;
            case 4:
                return @"周四";
                break;
            case 5:
                return @"周五";
                break;
            case 6:
                return @"周六";
                break;
            default:
                return @"";
                break;
        }
    }
}

-(NSString *)period{
    if ([NSString isEmpty:_period]) {
        return @"";
    }else{
        switch ([_period integerValue]) {
            case 1:
                return @"上午";
                break;
            case 2:
                return @"下午";
                break;
            case 3:
                return @"全天";
                break;
            default:
                return @"";
                break;
        }
    }
}

@end
