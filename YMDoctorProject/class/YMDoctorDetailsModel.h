//
//  YMDoctorDetailsModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/20.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMDoctorTimeModel.h"

@interface YMDoctorDetailsModel : NSObject

@property(nonatomic,copy)NSString *store_id;//医生店铺id
@property(nonatomic,copy)NSString *member_id; //医生id
@property(nonatomic,copy)NSString *member_names;//医生名字
@property(nonatomic,copy)NSString *grade_id;//等级
@property(nonatomic,copy)NSString *member_aptitude;//职称
@property(nonatomic,copy)NSString *member_bm;//科室
@property(nonatomic,copy)NSString *member_ks;//科室
@property(nonatomic,copy)NSString *member_occupation;//医院
@property(nonatomic,copy)NSString *member_Personal;//个人介绍
@property(nonatomic,copy)NSString *member_service;//擅长描述
@property(nonatomic,copy)NSString *specialty_tags; //擅长标签
@property(nonatomic,copy)NSString *store_sales;//成交量
@property(nonatomic,copy)NSString *stoer_browse; //浏览量
@property(nonatomic,copy)NSString *member_avatar;//头像
@property(nonatomic,copy)NSString *follow_num;//关注数量
@property(nonatomic,copy)NSString *avg_score;//评分
@property(nonatomic,copy)NSString *is_follow;//当前用户是否关注此医生：1-已关注 0-未关注
@property(nonatomic,copy)NSString *member_education;//学历

@property(nonatomic,strong)NSArray *doctor_time;

@property(nonatomic,strong)NSMutableArray<YMDoctorTimeModel *> *doctorTimeArry;

@end


