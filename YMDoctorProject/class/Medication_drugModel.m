//
//  Medication_drugModel.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Medication_drugModel.h"

@implementation Medication_drugModel


-(NSMutableArray<MedicationDrugDetailModel *> *)drugDetail
{  
    NSMutableArray<MedicationDrugDetailModel *> *returnDetail = [NSMutableArray array];
    for (NSDictionary *dic in _detail) {
        [returnDetail addObject:[MedicationDrugDetailModel yy_modelWithDictionary:dic]];
    }
    return returnDetail;

}


@end
