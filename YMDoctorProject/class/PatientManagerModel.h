//
//  PatientManagerModel.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PatientManagerModel : NSObject

@property (nonatomic,copy) NSString *demand_id; //id
@property (nonatomic,copy) NSString *instructions_content; //医生医嘱内容
@property (nonatomic,copy) NSString *member_id;  //用户id
@property (nonatomic,copy) NSString *member_avatar; //图片
@property (nonatomic,copy) NSString *mealth_name;  //用户名
@property (nonatomic,copy) NSString *member_sex;  //用户性别
@property (nonatomic,copy) NSString *orders;    //就诊详情
@property (nonatomic,copy) NSString *time;  //就诊时间
@property (nonatomic,copy) NSString *health_id; //健康ID
@property (nonatomic,copy) NSString *mealth_mobile; //电话
@property (nonatomic,copy) NSString *huanxinid; //融云id
@property (nonatomic,copy) NSString *huanxinpew; //融云。。
@end
