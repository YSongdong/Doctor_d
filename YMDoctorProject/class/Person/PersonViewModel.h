//
//  PersonViewModel.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol PersonViewModelDelegate <NSObject>


- (void)operateSuccess:(NSString *)successTitle ;

- (void)operateFailure:(NSString *)failureReason ;

- (void)requestDataSuccess:(id)resultValue ;
- (void)uploadSucess ;
@end

@interface PersonViewModel : NSObject

@property (nonatomic,weak)id <PersonViewModelDelegate>delegate ;
@property (nonatomic,strong)NSArray *departments ;
@property (nonatomic,strong)NSArray *hospitals ;
@property (nonatomic,strong)NSArray *doctorQulifications;
@property (nonatomic,strong)NSArray *billLists ;



//获取验证码
- (void)getVertificationWithParams:(id)params
                    andReturnBlock:(void(^)(id status))commpleteBlock;

- (void)cetertificationAuthenWithParams:(id)params
                              andImages:(NSArray *)images
                                andView:(UIView *)view  ;


- (void)changePersonalIntroduceWithParams:(id)params ;

- (void)requestPersonalInfo:(id)params view:(UIView *)view ;


- (void)getDepartmentAndhospitalList  ;

//账户余额
- (void)requestPersonalAccountWithParams:(id)params
                       andCommpleteBlock:(void(^)(id value))commplete ;
//账户列表
- (void)requestBillListWithParams:(id)params
                              url:(NSString *)url view:(UIView *)view;

- (void)addBankWithParams:(id)params andView:(UIView *)view ;

- (void)deletedBankListWithParams:(id)params
                   andReturnBlock:(void(^)(id statue))commplete;


- (void)getBankListWithParams:(id)params andView:(UIView *)view  ;

//设置铃声
- (void)openAlertWithParams:(id)params andUrl:(NSString *)url;

//个人中心信息
- (void)personalInfoRequestWithParmas:(id)params andCommpleteBlock:(void(^)(id model))commpleteBlock;

//上传头像
- (void)uploadAvatarWithImages:(NSArray *)images andParamas:(id)params
                       andView:(UIView *)view  ;
 ;





//账户余额
- (void)requestAccountWithParams:(id)params
                  andReturnBlock:(void(^)(id value))commpleteBlock;

//绑定支付宝

- (void)bindAlipayWithParams:(id)params andView:(UIView *)view;

//get alipayAccount 
- (void)getAlipayWithParams:(id)params
                    andView:(UIView *)view;

//ti xian
- (void)drawMoneyWithParams:(id)params
                    andView:(UIView *)view
                     andUrl:(NSString *)url
          andCommpleteBlock:(void(^)(id status))statusBlock;


//设置支付密码
- (void)setPayPassWithParams:(id)params
              andReturnBlock:(void(^)(id status))statusBlock;

//设置
- (void)settingWithParams:(id)params
           andReturnBlock:(void(^)(id value))commpleteBlock;


//审核状态
- (void)authentificationStatusWithParams:(id)params
                          andReturnBlock:(void(^)(id value,NSString *reason))commpleteBlock;

//资质资料 认证资料
- (void)requestDoctorAuthenInfoWithParams:(id)params
                                   andUrl:(NSString *)url
                        andCommpleteBlock:(void(^)(id value))commpleteBlock;

///资质提交
- (void)saveCetertificationWithParams:(id)params
                              andView:(UIView *)view
                       complateHandle:(void(^)(id showdata,NSString *error))complet;


@end
