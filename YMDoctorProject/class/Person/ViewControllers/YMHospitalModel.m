//
//  YMHospitalModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHospitalModel.h"

@implementation YMHospitalModel

-(NSString *)hospital_id{
    if ([NSString isEmpty:_hospital_id]) {
        return @"";
    }
    return _hospital_id;
}

@end
