//
//  YMDoctorTimeModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDoctorTimeModel : NSObject
@property(nonatomic,strong)NSString *week;//0-6表示周日到周六
@property(nonatomic,strong)NSString *period;//1-上午 2-下午 3-晚上
@property(nonatomic,strong)NSString *hospital;//医院名称
@property(nonatomic,strong)NSString *ks;//科室名称

@end
