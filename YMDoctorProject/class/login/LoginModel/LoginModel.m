//
//  LoginModel.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "LoginModel.h"
#import <RongIMKit/RongIMKit.h>
#import "JPUSHService.h"

@implementation LoginModel

//修改支付密码
- (void)changePayPass:(UIView *)view {
    
    [self requestDataWithUrl:CHANGE_PAY_PASS_URL andView:view
           andCommpleteBlock:^(id data, NSString *error) {

               if (!error) {
                   [self.delegate getDataSuccess];
                   [self setPayPass:YES];
               }
               else {
                   [self.delegate requestDataFailureWithReason:error];
               }
    }];
}

//修改密码
- (void)changePass:(UIView *)view {
 
    [self requestDataWithUrl:CHANGE_PASS_URL
                     andView:nil
           andCommpleteBlock:^(id data, NSString *error) {
               if (!error) {
                   [self.delegate getDataSuccess];
               }
               else {
                   [self.delegate requestDataFailureWithReason:error];
               }
    }];
}

//修改密码获取验证码
- (void)getVertificationchangePass {
    
    [self requestDataWithUrl:CHANGE_VERTIFICATION_URL andView:nil
       andCommpleteBlock:^(id data, NSString *error) {
       if (data) {
           [self.delegate getDataSuccess];
       }
       else {
           [self.delegate requestDataFailureWithReason:error];
   }
 }];
}

//登录
- (void)userLogin:(UIView *)view {
    
    [self requestDataWithUrl:Login_URL andView:view
           andCommpleteBlock:^(id data, NSString *error) {
               
       NSLog(@"data----------------%@",data);
       if (error == nil) {
           
           [self saveUserInfo:data] ;
           
           [self.delegate getDataSuccess];
           
       }else {
           
           [self.delegate requestDataFailureWithReason:error];
       }
   }];
}

- (void)saveUserInfo:(id)data {
    
    if (data[@"member_id"]) {
        
        [JPUSHService setTags:[NSSet setWithObject:data[@"member_id"]] aliasInbackground:nil];
        NSLog(@"member_id----------------%@",data[@"member_id"]);
    }
    
    
//     dispatch_async(dispatch_queue_create("com.save.data", DISPATCH_QUEUE_CONCURRENT), ^{
    
        [self setMember_id:data[@"member_id"]];
//        [self setDoctor_member_id:data[@"member_id"]];
         
        [self setAvatar:data[@"default_avatar"]];
         
         BOOL paypwd;
         if ([data[@"is_paypwd"] isEqualToString:@"0"]) {
             
             paypwd = NO;
         }else{
             paypwd = YES;
         }
        [self setPayPass:paypwd];
        [self setStore_id:data[@"store_id"]];
    
        [self setUserName:data[@"member_name"]];
        [self setUserPhone:data[@"member_name"]];
    
        [self setVibrates:data[@"vibrates"]];
    
        if (data[@"store_id"] &&
            ![data[@"store_id"] isEqual:[NSNull null]]) {
            [self setStore_id:data[@"store_id"]];
        }
        if ([data[@"sound"] isEqual:[NSNull null]]) {
            [self setAlert:@"1"];
        }else{
            [self setAlert:data[@"sound"]];
        }
         [self registerRongyun];
//    });
}


//注册
- (void)registerUser:(UIView *)view  {
    
    __weak typeof(self)weakSelf = self ;
    [self requestDataWithUrl:register_URL
                     andView:view
           andCommpleteBlock:^(id data, NSString *error) {
               
              // NSLog(@"data----------%@",data);
               
               if (error == nil) {
                   
                   [weakSelf saveUserInfo:data];
                   
                   [weakSelf.delegate getDataSuccess];
                   
               }
               else {
        
                   [weakSelf.delegate requestDataFailureWithReason:error];
               }
    }];
}

//get 验证码
- (void)getVertification:(UIView *)view{
    __weak typeof(self)weakSelf = self ;
   [self requestDataWithUrl:vertification_URL
                    andView:view
          andCommpleteBlock:^(id data, NSString *error) {
              if (weakSelf.delegate) {
                  if (error != nil) {
                      [weakSelf.delegate requestDataFailureWithReason:error];
           }
        }
   }];
}

- (void)loginGetVertification:(UIView *)view
            andCommpleteBlock:(void(^)(id data,NSString *error))commplete{
    
    [self requestDataWithUrl:Login_vertification_URL
                     andView:view
           andCommpleteBlock:^(id data, NSString *error) {
               commplete(data,error);
           }];
}

//找回密码
- (void)findPass:(UIView *)view {
    
    [self requestDataWithUrl:Find_Pass_URL
                     andView:view
           andCommpleteBlock:^(id data, NSString *error) {
               
               if (error == nil) {
                   if (self.delegate ) {
                       [self.delegate getDataSuccess];
                   }
               }
               else {
                   if (self.delegate ) {
                       [self.delegate requestDataFailureWithReason:error];
                   }
               }
    }];
}


- (void)getVeritificationCodeInFindViewController{

    [self requestDataWithUrl:Vertification_When_Find_URL andView:nil
           andCommpleteBlock:^(id data, NSString *error) {
        if (!error) {
            [self.delegate getDataSuccess];
        }else {
            [self.delegate requestDataFailureWithReason:error];
        }
    }];
}


- (void)requestDataWithUrl:(NSString *)url andView:(UIView *)view
         andCommpleteBlock:(void(^)(id data,NSString *error))commplete{
    
    KRMainNetTool *tool = [[KRMainNetTool alloc]init];
    [tool sendRequstWith:url
                  params:self.params
               withModel:nil
                waitView:view
          complateHandle:^(id showdata, NSString *error) {
              
              commplete(showdata,error);
    }];
}

- (void)setParams:(NSDictionary *)params {
    
 //   NSLog(@"params-------------------%@",params);
    
    _params = params ;
}

- (void)registerRongyun {
    KRMainNetTool *tool = [KRMainNetTool new];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
    
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    [tool sendRequstWith:Get_Token_Url params:dic
               withModel:nil complateHandle:^(id showdata, NSString *error) {
                   if (showdata) {
                       NSString *token = showdata[@"huanxinpew"];
                       [[RCIM sharedRCIM]connectWithToken:token success:^(NSString *userId) {
                   RCUserInfo *userInfo = [[RCUserInfo alloc]initWithUserId:userId name:[self getUserName] portrait:[self getAvatar]];
                           
                               [RCIM sharedRCIM].currentUserInfo = userInfo;
                           
                       } error:^(RCConnectErrorCode status) {
                           
                       } tokenIncorrect:^{
                           
               }];
         }
    }];
}

@end
