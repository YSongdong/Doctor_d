//
//  Medication_drugModel.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MedicationDrugDetailModel.h"

@interface Medication_drugModel : NSObject

@property(nonatomic,copy) NSString *medication_id; //提醒用药id
@property(nonatomic,copy) NSString *orders; //医嘱
@property(nonatomic,strong) NSArray *detail;

-(NSMutableArray<MedicationDrugDetailModel *> *)drugDetail;

@end
