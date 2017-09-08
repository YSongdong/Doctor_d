//
//  PatienDetailModel.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PatienDetailModel.h"

@implementation PatienDetailModel

-(NSMutableArray<Health_historyModel *> *)historyDetail{
    NSMutableArray<Health_historyModel *> *returnDetail = [NSMutableArray array];
    for (NSDictionary *dic in _health_history) {
        [returnDetail addObject:[Health_historyModel yy_modelWithDictionary:dic]];
    }
    return returnDetail;
}

//-(Medication_drugModel *)medicationDrug
//{
//    if (_medication_drug) {
//       return  [Medication_drugModel yy_modelWithDictionary:_medication_drug];
//    }else{
//        return [[Medication_drugModel alloc]init];
//    }
//
//}



@end
@implementation DetailMealthModel



@end

@implementation MedicationDurgModel

-(NSMutableArray<MedicationDrugDetailModel *> *)drugDetail
{
    NSMutableArray<MedicationDrugDetailModel *> *returnDetail = [NSMutableArray array];
    for (NSDictionary *dic in _detail) {
        [returnDetail addObject:[MedicationDrugDetailModel yy_modelWithDictionary:dic]];
    }
    return returnDetail;
    
}


@end

