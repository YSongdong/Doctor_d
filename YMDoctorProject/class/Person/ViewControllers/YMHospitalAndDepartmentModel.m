//
//  YMHospitalAndDepartmentModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHospitalAndDepartmentModel.h"

@implementation YMHospitalAndDepartmentModel

-(NSMutableArray<YMHospitalModel *> *)hospitallArry{
    _hospitallArry = [NSMutableArray array];
    for (NSDictionary *dic in _hospital_type) {
        [_hospitallArry addObject:[YMHospitalModel yy_modelWithDictionary:dic]];
    }
    return _hospitallArry;
}



@end
