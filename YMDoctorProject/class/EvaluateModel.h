//
//  EvaluateModel.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluateModel : NSObject
@property (nonatomic,copy) NSString *doctor_score; //医生评分
@property (nonatomic,copy)NSString *user_score;//用户评分
@property(nonatomic,strong)NSArray *user_ping;//评价标签
@property (nonatomic,copy)NSString *doctor_ping;//医生评价内容
@property (nonatomic,copy)NSString *user_hui ; //用户回复内容
@property (nonatomic,copy)NSString *doctor_hui;//医生回复内容
@property (nonatomic,copy)NSString *doctor_ping_time; //医生评价时间
@property (nonatomic,copy)NSString *user_ping_time;//用户评价时间
@end
