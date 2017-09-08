//
//  YMCaseDetailsModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseDetailsModel.h"
//#import <NSObject+YYModel.h>

@implementation YMCaseDetailsModel

-(NSString*)case_title{
    if (![NSString isEmpty:_case_title]) {
        return _case_title;
    }else{
        return @"";
    }
}

-(NSString *)case_time{
    if (![NSString isEmpty:_case_time]) {
        return _case_time;
    }else{
        return @"";
    }
}

-(NSString *)case_desc{
    if (![NSString isEmpty:_case_desc]) {
        return _case_desc;
    }else{
        return @"";
    }
}


-(YMDoctorDetailsModel *)doctronInfo{
    if (_doctor_info) {
      return [YMDoctorDetailsModel yy_modelWithDictionary:_doctor_info];
    }else{
       return [[YMDoctorDetailsModel alloc]init];
    }
}


-(NSMutableArray<YMCaseDetailsMonthInformationModel *>*)caseDetail{
    NSMutableArray<YMCaseDetailsMonthInformationModel *> *returnCase_datail = [NSMutableArray array];
    for (NSDictionary *dic in _case_detail) {
        [returnCase_datail addObject:[YMCaseDetailsMonthInformationModel yy_modelWithDictionary:dic]];
    }
    return returnCase_datail;
}


@end
