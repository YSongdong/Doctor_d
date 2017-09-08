//
//  CDCaseDetailModel.h
//  YMDoctorProject
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



@class Case_detailModel,Case_detail_Model,Case_doctorModel,d_imgsModel;
@interface CDCaseDetailModel : NSObject<YYModel>

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
@property(nonatomic,strong)Case_detailModel *case_detail;
@property(nonatomic,strong)Case_doctorModel *doctor_info;

@end


@interface Case_detailModel : NSObject<YYModel>
@property(nonatomic,copy)NSString *month;//月份

@property(nonatomic,strong)Case_detail_Model *detail;//详情

@end

@interface Case_detail_Model : NSObject<YYModel>

@property(nonatomic,copy)NSString *d_time;//详情时间
@property(nonatomic,strong)d_imgsModel *d_imgs;//图片
@property(nonatomic,copy)NSString *d_con;//详情内容

@end
@interface d_imgsModel : NSObject



@end

@interface Case_doctorModel : NSObject

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
@end







