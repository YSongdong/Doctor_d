//
//  YMHospitalSelectModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHospitalSelectModel.h"
#import "NSString+BitusStringUtils.h"

@implementation YMHospitalSelectModel

-(NSString *)content{
    if ([NSString isEmpty:_content]) {
        return @"";
    }
    return _content;
}

-(NSString *)type{
    if ([NSString isEmpty:_type]) {
        return @"";
    }
    return _type;
}

@end
