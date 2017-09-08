//
//  YMDoctorDetailsCaseModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMDoctorDetailsCaseModel : NSObject

@property(nonatomic,copy)NSString *case_id;//案例ID
@property(nonatomic,copy)NSString *case_title;//案例标题

@property(nonatomic,copy)NSString *case_time;//案例时间
@property(nonatomic,copy)NSString *case_desc;//案例描述"
@property(nonatomic,copy)NSString *case_thumb;//缩略图
@property(nonatomic,copy)NSString *page_view;//浏览量
@property(nonatomic,copy)NSString *status;//案例状态：1-显示 2-隐藏
@property(nonatomic,copy)NSString *on_shelf;//上架状态：1-已上架 0-已下架


@end
