//
//  PatienDetailModel.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Health_historyModel.h"
#import "Medication_drugModel.h"
#import "MedicationDrugDetailModel.h"


@class DetailMealthModel,MedicationDurgModel;

@interface PatienDetailModel : NSObject
@property(nonatomic,strong) DetailMealthModel *mealth; //个人信息
@property(nonatomic,strong) MedicationDurgModel *medication_drug; //用药
@property(nonatomic,copy) NSMutableArray *health_history; //就医历史


//-(Medication_drugModel *)medicationDrug;

-(NSMutableArray<Health_historyModel *> *)historyDetail;



@end
@interface DetailMealthModel : NSObject

@property(nonatomic,copy) NSString *mealth_sex; //用户性别
@property(nonatomic,copy) NSString *mealth_img;  //用户头像
@property(nonatomic,copy) NSString *mealth_age;  //用户年龄
@property(nonatomic,copy) NSString *create_time;  //上次就诊时间
@property(nonatomic,copy) NSString *fuzhen_time;  //复诊时间
@property(nonatomic,copy) NSString *mealth_name; //姓名
@end

@interface MedicationDurgModel :NSObject

@property(nonatomic,copy) NSString *medication_id; //提醒用药id
@property(nonatomic,copy) NSString *orders; //医嘱
@property(nonatomic,strong) NSArray *detail;

-(NSMutableArray<MedicationDrugDetailModel *> *)drugDetail;


@end

