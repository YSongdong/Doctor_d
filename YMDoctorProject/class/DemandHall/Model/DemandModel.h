//
//  DemandModel.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemandModel : NSObject

@property (nonnull,nonatomic,strong)NSString *demand_id ; //需求id

//新[6]	(null)	@"doctor_ping" : @"Test"	
@property (nonnull,nonatomic,strong)NSString *demand_sn ;//需求编号
@property (nonnull,nonatomic,strong)NSString *order_sn ;//订单编号

@property (nonnull,nonatomic,strong)NSString *money ;//费用
@property (nonnull,nonatomic,strong)NSString *title ;//标题

@property (nonnull,nonatomic,strong)NSString *status_desc ;//状态
@property (nonnull,nonatomic,strong)NSString *yuyue_state_desc ;//预约状态

@property (nonnull,nonatomic,strong)NSString *demand_time ;//需求时间

@property (nonnull,nonatomic,strong)NSString *order_type ;//类型

@property (nonnull,nonatomic,strong)NSString *doctor_signed;//鸣医订单 判断
@property (nonnull,nonatomic,strong)NSString *contract_signed;//需求大厅 判断
@property (nonnull,nonatomic,strong)NSString *member_mobile;//用户 手机号
@property (nonnull,nonatomic,strong)NSString *status_number;// 0 未选标（蓝色）    1 已选标（灰色）    2已完成订单（黄色）


@property (nonnull,nonatomic,strong)NSString *tip ;//倒计时提示
@property (nonnull,nonatomic,strong)NSString *bid_num ;//投标人数

@property (nonnull,nonatomic,strong) NSString * current_docter_signed; //是否和自己签的单

@property (nonnull,nonatomic,strong)NSString *demand_sketch ; //需求描述
@property (nonnull,nonatomic,strong)NSString *demand_needs ;//描述
@property (nonnull,nonatomic,strong)NSString *ktimes ;//开始时间
@property (nonnull,nonatomic,strong)NSString *jtimes ;//结束时间
@property (nonnull,nonatomic,strong)NSString *price ;//价钱
@property (nonnull,nonatomic,strong)NSString *fbtime ; //发布时间
@property (nonnull,nonatomic,strong)NSString *demand_amount ;//招标人数
@property (nonatomic,strong,nonnull)NSString *demand_qb ;//qubie  1 需求 2 名医  3 疑难杂症



@property (nonnull,nonatomic,strong)NSString *demand_schedule ;////进程数//需求状态 1为选标中 2洽谈中3选标中4签订合同5完成工作付款6订单完

@property (nonatomic,nonnull,strong)NSString *order_apply ;//1 为选表中 2 选表成功 3 为选表失败

@property (nonatomic,nonnull,strong)NSString *store_id ;
@property (nonnull,nonatomic,strong)NSString *member_id ;

@property (nonatomic,nonnull,strong)NSString *demand_bh ;//需求编号

@property (nonatomic,nonnull,strong)NSString * seniority;//医生资格
@property (nonatomic,strong,nonnull)NSString *total ;

@property (nonatomic,strong,nonnull)NSString *tuoguan ;//托管


@property (nonatomic,assign)CGFloat cellHeight ;


@property (nonatomic,nonnull,strong)NSString *order_state ;//订单状态

//挂号信息 ------没有

@property (nonatomic,strong,nonnull)NSString *buyner_name ;

@property (nonatomic,strong,nonnull)NSString *demand_portrait ;

@property (nonnull,strong,nonatomic)NSString *demand_term ; //限时8小时

@property (nonatomic,strong,nonnull)NSString *demand_value ; //好评率
@property (nonnull,strong,nonatomic)NSString *demand_count ;//成交量
@property (nonatomic,strong,nonnull)NSString *demand_sex ;

@property (nonnull,strong,nonatomic)NSString *demand_name ; //发布需求者姓名

@property (nonatomic,strong,nonnull)NSString *area ; //区域

@property (nonatomic,strong,nonnull)NSString *demand_phone ; //发布需求人的电话

@property (nonatomic,strong,nonnull)NSString *demand_type ;

@property (nonatomic,strong,nonnull)NSString *finnshed_time ; //投标时间

@property (nonatomic,strong,nonnull)NSString *order_cpid ;//需求名字

@property (nonatomic,strong,nonnull)NSString *payment_time ; //支付时间

@property (nonatomic,strong,nonnull)NSString *order_amount ;//账单价格

//------银行卡
@property (nonatomic,strong,nonnull)NSString *card_id ; //银行卡编号
@property (nonatomic,strong,nonnull)NSString *member_name ;//持卡人

@property (nonatomic,strong,nonnull)NSString *card_num ;//卡号
@property (nonatomic,strong,nonnull)NSString *name ; //银行名称
@property (nonatomic,strong,nonnull)NSString *order_id ;

@property (nonatomic,strong,nonnull)NSString *demand_hire ;//雇佣类型
@property (nonatomic,strong,nonnull)NSString *order_member ;//判断是否自己发布的

//声音 震动 客服号码
@property (nonatomic,strong,nonnull)NSString  *sound ;
@property (nonatomic,strong,nonnull)NSString  *vibrates ;
@property (nonatomic,strong,nonnull)NSString  *mobile ;


@property (nonatomic,strong,nonnull)NSString  *member_aptitude ;//医生资质
@property (nonatomic,strong,nonnull)NSString  *authentication_name ; ////认证名字

@property (nonatomic,strong,nonnull)NSString  *authentication_sex ; ///性别

@property (nonatomic,strong,nonnull)NSString  *authentication_age ; // 出生年月
@property (nonatomic,strong,nonnull)NSString  *authentication_sid ; //身份证号码
@property (nonatomic,strong,nonnull)NSString  *effective ; // 身份证有效期
@property (nonatomic,strong,nonnull)NSString  *picture1 ; // 身份证正面
@property (nonatomic,strong,nonnull)NSString  *picture2 ; // 身份证背面

@property (nonatomic,strong,nonnull)NSString  *accession ; // 就职医院

@property (nonatomic,strong,nonnull)NSString  *authentication_education ; // 学历
@property (nonatomic,strong,nonnull)NSString  *authentication_bm ; // 部门
@property (nonatomic,strong,nonnull)NSString  *authentication_ks ; //科室
@property (nonatomic,strong,nonnull)NSString  *certificate_zy ; // 执业证书编号
@property (nonatomic,strong,nonnull)NSString  *certificate_zg ; // 资格证书编号


@property (nonnull,nonatomic,copy)NSString *order_time2 ; //洽谈时间
@property (nonnull,nonatomic,copy)NSString *ascertain_tj ;//签订合同时间
@property (nonnull,nonatomic,copy)NSString *geval_addtime ;//评价时间

@property (nonnull,nonatomic,copy)NSString *geval_frommembertime;//用户评价时间


@property (nonnull,nonatomic,copy)NSString *member_truename ;//乙方
@property (nonnull,nonatomic,copy)NSString *member_names ;//甲方
@property (nonnull,nonatomic,copy)NSString *contract_id ;//合同ID
@property (nonnull,nonatomic,copy)NSString *contract_time ;//就诊时间1
@property (nonnull,nonatomic,copy)NSString *contract_content ;//合同内容
@property (nonnull,nonatomic,copy)NSString *ascertain_agree1 ;//甲提交时间
@property (nonnull,nonatomic,copy)NSString *ascertain_agree2 ;//乙提交时间
@property (nonnull,nonatomic,copy)NSString *contract_time1 ;//就诊时间2
@property (nonnull,nonatomic,copy)NSString *ascertain_state ;//签订状态

//评价
//@property (nonnull,nonatomic,strong)NSString *mreply_time ; //他的评价时间
@property (nonnull,nonatomic,strong)NSString *geval_explain ; //医生评价内容
@property (nonnull,nonatomic,strong)NSString *geval_id ; //我的评价id
@property (nonnull,nonatomic,strong)NSString *geval_scores1 ; //我的评价等级
@property (nonnull,nonatomic,strong)NSString *geval_scores ; //他的评价等级

@property (nonnull,nonatomic,strong)NSString *geval_content ; //他的评价内容

//@property (nonnull,nonatomic,strong)NSString *geval_content ; //他的评价内容
//@property (nonnull,nonatomic,strong)NSString *geval_content ; //他的评价内容
//@property (nonnull,nonatomic,strong)NSString *geval_content ; //他的评价内容


@property (nonnull,nonatomic,strong)NSString *message_body ; //系统消息内容
@property (nonnull,nonatomic,strong)NSString *message_time ; //系统消息时间
@property (nonnull,nonatomic,strong)NSString *message_id ; //系统消息id
@property (nonnull,nonatomic,strong)NSString *from_member_id ; //来源对象
@property (nonnull,nonatomic,strong)NSString *message_state ; //消息状态
@property (nonnull,nonatomic,strong)NSString *message_type ; //系统消息类型
@property (nonnull,nonatomic,strong)NSString *message_count ; //纬度消息条数
@property (nonnull,nonatomic,strong)NSString * message_title ;//消息标题
@property (nonnull,nonatomic,strong)NSString * geval_sreply ;//商家回复
@property (nonnull,nonatomic,strong)NSString * geval_mreply ;//会员回复
@property (nonnull,nonatomic,strong)NSString * sreply_time ;//商家回复时间
@property (nonnull,nonatomic,strong)NSString * mreply_time ;//会员回复时间

@property (nonnull,nonatomic,strong)NSString * demand_tbs;//提示
@property (nonnull,nonatomic,strong)NSString *order_store ;//商家是否已投标

@property (nonnull,nonatomic,strong)NSString *demand_condition ; //订单状态
@property (nonnull,nonatomic,strong)NSString *_logo ; //系统消息图标

@property (nonatomic,strong)NSString *order_isEvaluate ; //是否评价
@property (nonatomic,strong)NSArray *img ;

@property (nonatomic,strong)NSString *ascertain1 ; //签订合同医生的签名





@property (nonnull,nonatomic,strong)NSString *average_value ;//好平率

@property (nonatomic,strong)NSString *ry_usid ;

- (CGFloat)getDemandDetailHeight ;

//需求内容高度
@property (nonatomic,assign)CGFloat contentCellHeight ;
@end
