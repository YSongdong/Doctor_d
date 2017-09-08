//
//  YMDoctorDetailsEvaluationModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDoctorDetailsEvaluationModel : NSObject
@property(nonatomic,copy)NSString *geval_id;//评价ID
@property(nonatomic,copy)NSString *geval_scores;//评分
@property(nonatomic,copy)NSString *geval_tags;//标签
@property(nonatomic,copy)NSString *geval_addtime;//时间
@property(nonatomic,copy)NSString *geval_frommemberid;//会员ID
@property(nonatomic,copy)NSString *geval_frommembername;//昵称
@property(nonatomic,copy)NSString *member_avatar;//头像

@end
