//
//  YMCaseDetailsModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMDoctorDetailsModel.h"
#import "YMCaseDetailsMonthInformationModel.h"

@interface YMCaseDetailsModel : NSObject

@property(nonatomic,copy)NSString *case_id;//案例ID
@property(nonatomic,copy)NSString *store_id;//店铺ID
@property(nonatomic,copy)NSString *member_id;//会员ID
@property(nonatomic,copy)NSString *case_title;//案例标题
@property(nonatomic,copy)NSString *case_time;//案例时间
@property(nonatomic,copy)NSString *case_desc;//案例描述
@property(nonatomic,copy)NSString *case_thumb;//案例图片
@property(nonatomic,copy)NSString *create_time;//创建时间
@property(nonatomic,copy)NSString *page_view;//浏览量
@property(nonatomic,copy)NSString *status;//案例状态：1-显示 2-隐藏
@property(nonatomic,copy)NSString *on_shelf;//上架状态：1-已上架 0-已下架
@property(nonatomic,copy)NSMutableArray *case_detail;
@property(nonatomic,strong)NSDictionary *doctor_info;

-(YMDoctorDetailsModel *)doctronInfo;

-(NSMutableArray<YMCaseDetailsMonthInformationModel *>*)caseDetail;

@end
