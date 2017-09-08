//
//  YMHospitalAndDepartmentModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMHospitalModel.h"


@interface YMHospitalAndDepartmentModel : NSObject
@property(nonatomic,strong)NSArray *departments;//部门
@property(nonatomic,strong)NSArray *hospital_type;//医院

@property(nonatomic,strong)NSMutableArray<YMHospitalModel *> *hospitallArry;


@end
