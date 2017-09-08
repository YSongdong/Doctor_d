//
//  LoginModel.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol LoginModelProtocal <NSObject>
-(void)getDataSuccess ;
- (void)requestDataFailureWithReason:(NSString *)reason ;
@end



@interface LoginModel : NSObject

@property (nonatomic,strong)NSArray *dataList ;

@property (nonatomic,strong)NSDictionary *params ;

@property (nonatomic,weak)id <LoginModelProtocal>delegate ;

//用户登录
- (void)userLogin:(UIView *)view ;
//用户注册
- (void)registerUser:(UIView *)view ;

//注册页面获取验证码
- (void)getVertification:(UIView *)view ;

//找回密码
- (void)findPass:(UIView *)view ;
//找回密码中获取验证码
- (void)getVeritificationCodeInFindViewController ;

//修改密码获取验证码
- (void)getVertificationchangePass ;

//修改密码
- (void)changePass:(UIView *)view ;

//修改支付密码
- (void)changePayPass:(UIView *)view  ;


//登录获取验证吗
- (void)loginGetVertification:(UIView *)view
            andCommpleteBlock:(void(^)(id data,NSString *error))commplete;


@end
