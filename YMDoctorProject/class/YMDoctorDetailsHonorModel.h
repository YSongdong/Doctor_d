//
//  YMDoctorDetailsHonorModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDoctorDetailsHonorModel : NSObject
@property(nonatomic,copy)NSString *honor_id;//荣誉ID
@property(nonatomic,copy)NSString *honor_mid;//医生member_id
@property(nonatomic,copy)NSString *honor_name;//荣誉名称
@property(nonatomic,copy)NSString *honor_time;//获得时间
@property(nonatomic,copy)NSString *honor_image;//图片
@property(nonatomic,copy)NSString *honor_state;//状态：1-显示 2-隐藏
@end
