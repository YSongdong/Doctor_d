//
//  URL.h
//  FenYouShopping
//
//  Created by fenyou on 16/2/29.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#ifndef URL_h
#define URL_h

#define FT_INLINE static inline
FT_INLINE  NSString  *getRequestPath(NSString *act,NSString *op) ;
FT_INLINE NSString *imageAddress();


//接口域名
//#define PUBLISH_DIMAIN_URL @"https://ys9958.com/"

//测试域名
#define PUBLISH_DIMAIN_URL @"http://test.ys9958.com/"

//测试域名
//#define PUBLISH_DIMAIN_URL @"http://test2.ys9958.com/"

//接口域名
#define PUBLISH_DIMAIN_NEW_URL @"http://weixin.ys9958.com/index.php/api/"


#define PUBLISH_ADDRESS_FILE_URL @"api/index.php?"
#define SET_Domain 1
#define  WeChatPARTNER_ID @""


//广告页
#define  AdPage_URL getRequestPath(@"users_page",@"adPage")
//启动页
#define  StartPage_URL getRequestPath(@"users_page",@"startPage")


//基本信息
#define  Doctor_personal_URL getRequestPath(@"doctor_personal",@"info")
//基本信息  保存
#define  Doctor_personal_Save getRequestPath(@"doctor_personal",@"saveInfo")
//擅长疾病
#define  Doctor_personal_Disease getRequestPath(@"doctor_personal",@"diseaseList")

//医院搜索  列表
#define  SearchHospital_URL getRequestPath(@"hospital",@"searchHospital")
//医院  列表
#define  Hospital_URL getRequestPath(@"hospital",@"index")


//帮助中心  列表
#define  HelpCenter_URL getRequestPath(@"users_account",@"helpCenter")
//帮助中心  详情
#define  HelpContent_URL getRequestPath(@"users_account",@"helpContent")



//我的主页
#define  DoctorInfo_URL getRequestPath(@"doctor",@"doctorInfo")

//实名认证   查看
#define  RealnameAuth_URL getRequestPath(@"doctor_personal",@"realnameAuth")

//实名认证   提交
#define  RealnameAuth_Save getRequestPath(@"doctor_personal",@"saveRealnameAuth")



//资质提交   查看
#define  Qualification_URL getRequestPath(@"doctor_personal",@"qualification")

//资质提交   提交
#define  Qualification_Save getRequestPath(@"doctor_personal",@"saveQualification")



//排行榜
#define  Rank_URL getRequestPath(@"users_hire",@"doctorRank")



//案例 列表
#define  Case_URL getRequestPath(@"case",@"index")

//案例 编辑页面详情
#define  Case_Detail getRequestPath(@"case",@"caseDetail")

//案例 保存 新增 修改  
#define  Case_Save getRequestPath(@"case",@"saveCase")

//案例 删除
#define  Case_Del getRequestPath(@"case",@"delCase")

//案例 更改状态
#define  Case_ChangeStatus getRequestPath(@"case",@"changeStatus")

//案例 库
#define  Case_Lib getRequestPath(@"case",@"caseLib")

//案例 详情
#define  Case_FullDetail getRequestPath(@"case",@"caseFullDetail")





//荣誉 列表
#define  Honor_URL getRequestPath(@"honor",@"getHonorList")

//荣誉 详情
#define  Honor_Detail getRequestPath(@"honor",@"honorDetail")

//荣誉  保存  新增  编辑
#define  Honor_Save getRequestPath(@"honor",@"saveHonor")

//荣誉 修改状态
#define  Honor_ChangeStatus getRequestPath(@"honor",@"changeHonorStatus")

//荣誉  删除
#define  Honor_Del getRequestPath(@"honor",@"delHonor")


//服务评价
#define  Comment_URL getRequestPath(@"doctor",@"getDoctorComments")



//活动 列表
#define  Activities_URL getRequestPath(@"activities",@"index")

//活动 详情
#define  Activities_Detail getRequestPath(@"activities",@"activityDetail")

//活动 报名提交
#define  Activities_Submit getRequestPath(@"activities",@"applySubmit")

//活动 我参与的
#define  Activities_ApplyList getRequestPath(@"activities",@"applyList")




//demand hall
#define  Demand_Hall_URL2 getRequestPath(@"demand",@"demand_hal")
//新 需求大厅
#define  Demand_Hall_URL getRequestPath(@"new_order",@"demandHall")



//user login
#define Login_URL getRequestPath(@"login",@"login2")

//修改密码短信接口
#define CHANGE_VERTIFICATION_URL getRequestPath(@"doctor_page",@"password_send")

//修改密码
#define CHANGE_PASS_URL getRequestPath(@"doctor_page",@"forgetpas")
//user register
#define register_URL getRequestPath(@"register",@"register_user2")

//get vertification code
#define vertification_URL getRequestPath(@"register",@"regist")


//登录获取验证码

#define Login_vertification_URL getRequestPath(@"register",@"entry")

// find pass
#define Find_Pass_URL getRequestPath(@"register",@"forgetpas")

//getVertification code ----忘记密码找回密码
#define Vertification_When_Find_URL getRequestPath(@"register",@"password_send")

//get area
#define GET_AREA_URL getRequestPath(@"demand",@"area")


//demand hall detail
#define CET_DemandHall_Detail_URl getRequestPath(@"demand",@"details")

// submit a tender
#define SUBMIT_ORDER_URL getRequestPath(@"demand",@"reveal")


//接受雇佣
#define RECEIVE_EMPLOYER getRequestPath(@"demand_hire",@"reveal")

//home list
#define HOME_LIST_URL2 getRequestPath(@"dispatch",@"index")
//新的   首页  home list
#define HOME_LIST_URL getRequestPath(@"new_order",@"doctorIndex")
// 首页热点
//#define HOME_

//home pics
#define HOME_PIC_URL getRequestPath(@"demand",@"images")




//order list
#define DMAND_ORDER_URL2 getRequestPath(@"demand",@"demand")
//新的  订单列表
#define DMAND_ORDER_URL getRequestPath(@"new_order",@"doctorOrderList")


//employer list
#define EMPLOYER_ORDER_URL getRequestPath(@"demand",@"employ")

//diseases list 疑难杂症列表
#define INCRUABLE_ORDER_URL getRequestPath(@"diseases",@"demand")




//订单列表详情，进度
#define Demand_Order_Detail_URL2 getRequestPath(@"demand",@"schedule1")
//新  订单详情
#define Demand_Order_Detail_URL getRequestPath(@"new_order",@"demandDetail")

//新  订单流程
#define Demand_Order_Process_URL getRequestPath(@"new_order",@"doctorOrderProcess")

//新 立即参与  合同
#define Doctor_Contract_URL getRequestPath(@"new_order",@"doctorContract")

//新 上传  合同
#define Doctor_Bid_URL getRequestPath(@"new_order",@"doctorBid")

// 新  再约时间
#define Update_ServiceTime_URL getRequestPath(@"new_order",@"updateServiceTime")


//雇佣订单详情，进度
#define Employer_order_Detail_URL getRequestPath(@"demand_hire",@"schedule1")
//疑难杂症订单详情 进度

#define Incruable_Detail_URL getRequestPath(@"diseases",@"schedule1")

//renzheng
#define Person_Certification_URL  getRequestPath(@"doctor_personal",@"doctor_authentication")

//需求订单洽谈成功
#define CONTACT_APPROPRITE getRequestPath(@"demands",@"json_details1")
//需求订单洽谈失败
#define CONTACT_FAILURE_URL getRequestPath(@"demands",@"json_details2")

//雇佣订单洽谈成功
#define EMPLOY_CONTACT_APPROPRITE getRequestPath(@"demand_hire",@"json_details1")
//雇佣订单洽谈失败
#define EMPLOY_CONTACT_FAILURE_URL getRequestPath(@"demand_hire",@"json_details2")

//疑难杂症订单洽谈成功
#define Incruable_CONTACT_APPROPRITE getRequestPath(@"cancer",@"json_details1")
//疑难杂症订单洽谈失败
#define Incruable_CONTACT_FAILURE_URL getRequestPath(@"cancer",@"json_details2")

//申请付款
#define APPLY_PAY_URL getRequestPath(@"demands",@"json_details4")

//申请仲裁
#define APPLY_ZHONGCAI_URL2 getRequestPath(@"demands",@"json_zhongcai4")
//新   申请仲裁
#define APPLY_ZHONGCAI_URL getRequestPath(@"new_order",@"arbitrate")


//通知开始工作
#define START_WORK_URL getRequestPath(@"demands",@"json_ht3")

//查看评价
#define SHOW_EVALUATE_URL2 getRequestPath(@"doctor_comment",nil)
//新     查看评价
#define SHOW_EVALUATE_URL getRequestPath(@"new_order",@"checkPing")



//评价
#define EVALUATE_URL2 getRequestPath(@"demands",@"json_details6")
//新    评价
#define EVALUATE_URL getRequestPath(@"new_order",@"doctorSubPing")


//新    医嘱
#define SubInstructions_URL getRequestPath(@"new_order",@"subInstructions")

//新    拒绝  预约
#define RejectYuyue_URL getRequestPath(@"new_order",@"rejectYuyue")




//个人资料
#define PERSON_INTRODUCE_URL getRequestPath(@"doctor_personal",@"indexs")
//修改个人简介
#define CHANGE_INTROODUCE_URL getRequestPath(@"doctor_personal",nil)



//就职医院，科室选择
#define HOSPITAL_DEPARTMENT_URL getRequestPath(@"doctor_personal",@"sys_enum")

//我的账户
#define ACCOUNT_URL getRequestPath(@"doctor_account",@"index")

//账单记录
#define BILL_ACCOUNT_URL getRequestPath(@"doctor_account",@"demand")

//新  账单记录
#define NewBILL_ACCOUNT_URL getRequestPath(@"users_account",@"doctorNewBill")


//雇佣账单记录
#define EMPLOY_BILL_ACCOUNT_URL getRequestPath(@"doctor_account",@"guyong")



//银行卡列表
#define BANK_LIST_URL getRequestPath(@"doctor_account",@"cards_list")
//添加银行卡
#define ADD_BANK_URL getRequestPath(@"doctor_account",@"cards")

//绑定支付宝
#define BIND_ALIPAY getRequestPath(@"doctor_account",@"cardz")

//获取支付宝账号
#define Get_Alipay_URL getRequestPath(@"doctor_account",@"cards_listz")

//合同协议
#define Contract_Protocal_Url getRequestPath(@"demand",@"document")

//制定疑难杂症合同
#define MAKE_IncruableContract_URL getRequestPath(@"cancer",@"json_agree3")
//制定需求订单合同
#define MAKE_DemandOrder_Contract_Url getRequestPath(@"demands",@"json_agree3")

//制定合同

#define Contract_Info_Url getRequestPath(@"demands",@"json_details3")



//医生二维码
#define doctorQrcode_URL getRequestPath(@"doctor_page",@"doctorQrcode")




//设置铃声
#define SOUND_URL getRequestPath(@"doctor_page",@"sound")

//设置震动
#define ALERT_URL getRequestPath(@"doctor_page",@"vibrates")

//删除银行卡
#define DELETE_BANK_LIST_URL getRequestPath(@"doctor_account",@"card")

//person Info 个人中心
#define Person_Info_Url getRequestPath(@"doctor_page",@"index2")
//Person_complateStatus  资料完善状况
#define Person_complateStatus getRequestPath(@"doctor_personal",@"complateStatus")


//上传头像
#define HEAD_AVATAR_URL getRequestPath(@"doctor_page",@"avatar")

//修改支付密码
#define CHANGE_PAY_PASS_URL getRequestPath(@"doctor_account",@"account_zfmm")

// tianjia zhi fu mima

#define ADD_PAY_PASS_URL getRequestPath(@"doctor_account",@"account_zfmms")

//短信提现
#define MESSAGE_DRAW_URL getRequestPath(@"doctor_account",@"cash")

//zhang hao tixian
#define ACCOUNT_DRAW_URL getRequestPath(@"doctor_account",@"cashs")


//settting
#define Setting_Url getRequestPath(@"doctor_page",@"set")

//审核状态
#define Certification_Status_Url getRequestPath(@"doctor_personal",@"doctor_authenticationd")

//资质
#define Authen_Info_URL getRequestPath(@"doctor_personal",@"doctor_aptitudes")


//资质管理
#define Authen_Info_QualifPic getRequestPath(@"doctor_personal",@"qualifPic")

//资质管理提交
#define Authen_Info_SavequalifPic getRequestPath(@"doctor_personal",@"savequalifPic")




//认证资料
#define Certification_Info_Url getRequestPath(@"doctor_personal",@"doctor_authentications")

//上传处方
#define UploadPrescription_Url getRequestPath(@"demands",@"json_details5")


//系统消息首页
#define System_message_url getRequestPath(@"message",@"indexa")

#define Messages_url getRequestPath(@"message",@"message")

//短信提现验证码
#define Tixian_VeiTi_Url getRequestPath(@"register",@"send_auth_code")


//token
#define Get_Token_Url getRequestPath(@"demand",@"rongyun")


//用户消息

#define Get_userInfo_URl  getRequestPath(@"users_personal",@"liaos")


//yi sheng duan


//回复评价
#define Repy_Url2  getRequestPath(@"doctor_comment",@"comms")
//新  回复评价
#define Repy_Url  getRequestPath(@"new_order",@"subHuifu")



#define Refuse_Url  getRequestPath(@"demand_hire",@"reject")

#pragma mark  ----新接口 --------------------
FT_INLINE  NSString  * getNewRequestPath(NSString *act) {
    return [PUBLISH_DIMAIN_NEW_URL stringByAppendingFormat:@"%@",
            act];
}
//热点
#define Hotspot_Url getNewRequestPath(@"Hotspot/index")


//患者列表
#define Patient_Url   getNewRequestPath(@"Patient/index")
//患者详情
#define PatientDetail_Url  getNewRequestPath(@"Patient/Patient")
//患者就医提醒
#define PatientWarn_Url   getNewRequestPath(@"Patient/warn")


//错误的参数
  FT_INLINE void setUserDefaut(NSError *error) {
    
//    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:networkErrorStatus];
//    [[NSUserDefaults standardUserDefaults]setObject:error.localizedDescription forKey:netWorkConnectError];
}

//返回正确的参数
FT_INLINE void setRightUserDefault() {
  //  [[NSUserDefaults standardUserDefaults]setBool:NO
                                   //        forKey:netWorkConnectError];
}
FT_INLINE BOOL isWrongStatus() {
     return 0;
}

//FT_INLINE NSString *getNetWorkStatus () {
//    return [[NSUserDefaults standardUserDefaults]objectForKey:netWorkConnectError];
//}
FT_INLINE NSString *appenImageUrl(NSString *url) {
//    if (url){
//        
//        return [IMAGE_URL stringByAppendingString:url ];
//    }
    return nil ;
}
FT_INLINE NSString *deliverImageUrl(NSString *url) {
    return url;
}
FT_INLINE NSURL *getPictureUrl(NSString *string) {    
    return  [NSURL URLWithString:appenImageUrl(string)];
}

FT_INLINE  NSString  * getRequestPath(NSString *act,NSString *op) {
        return [PUBLISH_DIMAIN_URL stringByAppendingFormat:@"%@act=%@&op=%@",
                PUBLISH_ADDRESS_FILE_URL,act,op];
}





//图片路径
FT_INLINE NSString *imageAddress()
{
    return [PUBLISH_DIMAIN_URL stringByAppendingFormat:@"Manment/Public/Uploads/"];
}
//获取域名
FT_INLINE NSString *getDomainName(){
    return PUBLISH_DIMAIN_URL ;
}



#endif /* URL_h */
