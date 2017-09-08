//
//  PersonViewModel.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PersonViewModel.h"
#import "DemandModel.h"

@implementation PersonViewModel

//资质资料 认证资料
- (void)requestDoctorAuthenInfoWithParams:(id)params
                                   andUrl:(NSString *)url
                        andCommpleteBlock:(void(^)(id value))commpleteBlock{
    
    [self requestDateWithUrl:url
                   andParams:params
                   andImages:nil
                    andModel:nil view:nil
           andCommpleteBlock:^(id data, NSString *error) {
               if (!error) {
                 commpleteBlock([self getUserInfoWithParams:data]);
               }
               else {
                   commpleteBlock(error);
               }
    }];
}

- (DemandModel *)getUserInfoWithParams:(id)parmas  {
    
    DemandModel *person = [[DemandModel alloc]init];
    if ([parmas isKindOfClass:[NSDictionary class]]) {
        [person setValuesForKeysWithDictionary:parmas];
    }
    return person ;
}

//审核状态
- (void)authentificationStatusWithParams:(id)params
                          andReturnBlock:(void(^)(id value,NSString *reason))commpleteBlock{

    [self requestDateWithUrl:Certification_Status_Url
                   andParams:params
                   andImages:nil
                    andModel:nil view:nil andCommpleteBlock:^(id data, NSString *error){
                        
                        if (error) {
                            //参数错误
                            commpleteBlock(nil,error);
                        }
                        if (data[@"status"]) {
                            NSInteger status = [data[@"status"]integerValue] ;
                            if (status == 30) {
                                commpleteBlock(@(status),data[@"list_s"]);
                            }else {
                                commpleteBlock(@(status),nil);
                            }
                        }
                }];
}
//设置
- (void)settingWithParams:(id)params
           andReturnBlock:(void(^)(id value))commpleteBlock {
    [self requestDateWithUrl:Setting_Url andParams:params
                   andImages:nil andModel:nil view:nil
           andCommpleteBlock:^(id data, NSString *error) {
        if (!error) {
            
            NSLog(@"%@",data);
            if ([data isKindOfClass:[NSDictionary class]]) {
                DemandModel *model = [DemandModel new];
                [model setValuesForKeysWithDictionary:data];
                commpleteBlock(model);
                
            }
        }
                       
                       
        
        
    }];
    
    
}


//设置支付密码

- (void)setPayPassWithParams:(id)params
              andReturnBlock:(void(^)(id status))statusBlock {
    
    [self requestDateWithUrl:ADD_PAY_PASS_URL andParams:params
                   andImages:nil andModel:nil
                        view:nil andCommpleteBlock:^(id data, NSString *error) {
                            if (!error) {
                                statusBlock(@(1));
                            }else {
                                statusBlock(error);
                            }
    }];
}


//提现
- (void)drawMoneyWithParams:(id)params
                    andView:(UIView *)view
                     andUrl:(NSString *)url
          andCommpleteBlock:(void(^)(id status))statusBlock{

    [self requestDateWithUrl:url
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:view
           andCommpleteBlock:^(id data, NSString *error) {
               if (!error) {
                   statusBlock(@(1));
               }
               else {
                   statusBlock(error);
               }
               
           }];
}

//huo qu yanzheng ma
- (void)getVertificationWithParams:(id)params
                    andReturnBlock:(void(^)(id status))commpleteBlock {
    
    [self requestDateWithUrl:Tixian_VeiTi_Url
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:nil
           andCommpleteBlock:^(id data, NSString *error) {
                            if (!error) {
                                commpleteBlock(@"已发送验证码至您的手机");
                            }
                            else {
                                commpleteBlock(error);
                            }
    }];
}

//获取绑定的支付宝账号
- (void)getAlipayWithParams:(id)params
                    andView:(UIView *)view  {
    
    [self requestDateWithUrl:Get_Alipay_URL
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:view
           andCommpleteBlock:^(id data, NSString *error) {
       
               if (!error) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestDataSuccess:)]) {
                [self.delegate requestDataSuccess:data];
            }
        }
    }];
}
//绑定支付宝
- (void)bindAlipayWithParams:(id)params
                     andView:(UIView *)view{
    //bangding zhifubao
    [self requestDateWithUrl:BIND_ALIPAY andParams:params andImages:nil andModel:nil view:view andCommpleteBlock:^(id data, NSString *error) {
        
        NSLog(@"---->%@",data);
        
        if (error) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(operateFailure:)]) {
                [self.delegate operateFailure:error];
            }
        }
        else {
            [self.delegate operateSuccess:data];
        }
    }];
    
}

//shangchuan touxiang

- (void)uploadAvatarWithImages:(NSArray *)images andParamas:(id)params
                       andView:(UIView *)view {
  
    [self requestDateWithUrl:HEAD_AVATAR_URL andParams:params andImages:images andModel:nil view:view andCommpleteBlock:^(id data, NSString *error) {

        if (!error) {
            
            if (self.delegate &&
                [self.delegate respondsToSelector:@selector(operateSuccess:)]) {
                [self.delegate operateSuccess:nil];                
            }
            
        }else {

            [self.delegate operateFailure:error];
        }
    }];
}

//用户个人信心
- (void)personalInfoRequestWithParmas:(id)params
                    andCommpleteBlock:(void(^)(id model))commpleteBlock {
    
    [self requestDateWithUrl:Person_Info_Url andParams:params
                   andImages:nil andModel:nil view:nil
           andCommpleteBlock:^(id data, NSString *error) {
        
               commpleteBlock(data);

           }];
}

//设置铃声
- (void)openAlertWithParams:(id)params andUrl:(NSString *)url {
    
    [self requestDateWithUrl:url
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:nil
           andCommpleteBlock:^(id data, NSString *error) {
               if (data) {
                   if (self.delegate && [self.delegate respondsToSelector:@selector(operateSuccess:)]) {
                       [self.delegate operateSuccess:nil];
                   }
               }
    }];
    
}

- (void)deletedBankListWithParams:(id)params
                   andReturnBlock:(void(^)(id statue))commplete {
    
    [self requestDateWithUrl:DELETE_BANK_LIST_URL
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:nil
           andCommpleteBlock:^(id data, NSString *error) {
               NSLog(@"====>%@",data);
               if (!error) {
                   commplete(@(1));
               }
               else {
                   commplete(error);
               }
           }];    
}
//获取银行卡列表

- (void)getBankListWithParams:(id)params andView:(UIView *)view {
    
    
    [self requestDateWithUrl:BANK_LIST_URL
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:view
           andCommpleteBlock:^(id data, NSString *error) {

               if (error == nil) {
                   
                   
                   if ([data isKindOfClass:[NSArray class]]) {
                       NSMutableArray *array = [NSMutableArray array];
                       [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                           DemandModel *model = [DemandModel new];
                           [model setValuesForKeysWithDictionary:obj];
                           [array addObject:model];
                       }];
                       self.billLists = [array mutableCopy];
                   }
               }
    }];
}
//zhang hu yu e

//添加银行卡
- (void)addBankWithParams:(id)params andView:(UIView *)view{
    
    [self requestDateWithUrl:ADD_BANK_URL
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:view
           andCommpleteBlock:^(id data, NSString *error) {
               
               if (error == nil) {
                   [self.delegate operateSuccess:nil];
               }else{
                   [self.delegate operateFailure:error];
               }
    }];
}
//收入记录
- (void)requestBillListWithParams:(id)params
                              url:(NSString *)url view:(UIView *)view{
    
    
    [self requestDateWithUrl:url
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:view
           andCommpleteBlock:^(id data, NSString *error) {
               
               
               if (data) {
                   [self paramsArray:data];
               }
               if (error) {
                   [self.delegate operateFailure:error];
               }
    }];
}





//获取个人资料
- (void)requestPersonalInfo:(id)params view:(UIView *)view {
    
    [self requestDateWithUrl:PERSON_INTRODUCE_URL
                   andParams:params
                   andImages:nil
                    andModel:nil
                        view:view
           andCommpleteBlock:^(id data, NSString *error) {
               if (error == nil) {
                   [self.delegate requestDataSuccess:data];
               }
           }];
}

//需求账单记录  数据格式有问题
- (void)paramsArray:(id)data {
    
    
    NSMutableArray *mutaArray  = [NSMutableArray array];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                        NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj[@"zhangdan"]) {
            
            [mutaArray addObject:obj];
        }
    }];
    self.billLists = [mutaArray mutableCopy];
    
    
}


//zhang hu yu e
- (void)requestPersonalAccountWithParams:(id)params
                       andCommpleteBlock:(void(^)(id value))commplete{
    
    [self requestDateWithUrl:ACCOUNT_URL andParams:params
                   andImages:nil
                    andModel:nil
                        view:nil
           andCommpleteBlock:^(id data, NSString *error) {

               if (data[@"available_predeposit"]) {
                   commplete(data);
               }
               else {
                   commplete(nil);
               }
    }];
}

- (void)getDepartmentAndhospitalList {
    
    [self requestDateWithUrl:HOSPITAL_DEPARTMENT_URL andParams:nil andImages:nil andModel:nil view:nil andCommpleteBlock:^(id data, NSString *error) {
    if (data) {
        
            dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT), ^{
                [self paramsData:data[@"departments"]];
                [self paramsHospital:data[@"hospital_type"]];
                [self paramsDoctor:data[@"doctor_type"]];
            });
        }
    }];
}

//科室列表
- (void)paramsData:(NSArray *)data {
    
        NSMutableArray *mutaArray = [NSMutableArray array];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                               NSUInteger idx,
                                               BOOL * _Nonnull stop) {
            NSDictionary *dic = obj ;
            NSMutableDictionary *mutaDic = [NSMutableDictionary dictionary];
            if ([self juageExit:dic[@"disorder"]]) {
                [mutaDic setObject:dic[@"disorder"] forKey:@"disorder"];
            }
            if ([self juageExit:dic[@"ename"]]) {
                [mutaDic setObject:dic[@"ename"] forKey:@"ename"];
            }
            if ([self juageExit:dic[@"id"]]) {
                [mutaDic setObject:dic[@"id"] forKey:@"id"];
            }
            NSArray *child = dic[@"_child"];
            NSMutableArray *array = [NSMutableArray array];
            [child enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
        
                NSMutableDictionary *childDic = [NSMutableDictionary dictionary];
                if ([self juageExit:obj[@"disorder"]]) {
                    [childDic setObject:obj[@"disorder"] forKey:@"disorder"];
                }
                if ([self juageExit:obj[@"ename"]]) {
                    [childDic setObject:obj[@"ename"] forKey:@"ename"];
                }
                if ([self juageExit:obj[@"id"]]) {
                    [childDic setObject:obj[@"id"] forKey:@"id"];
                }
                    [array addObject:childDic];
            }];
        [mutaDic setObject:array forKey:@"child"];
        [mutaArray addObject:mutaDic];
        }];
    self.departments = [mutaArray mutableCopy];
}


//医院列表

- (void)paramsHospital:(NSArray *)hospitals  {
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    [hospitals enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:obj[@"hospital_name"] forKey:@"name"];
        [dic setObject:obj[@"hospital_id"] forKey:@"hospital_id"];
        [array addObject:dic];
    }];
    self.hospitals = array ;
}


- (void)paramsDoctor:(NSArray *)doctorQuality {
    
    NSMutableArray *array = [NSMutableArray array];
    [doctorQuality enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:obj[@"ename"] forKey:@"name"];
        [dic setObject:obj[@"id"] forKey:@"id"];
        dic[@"disorder"] = obj[@"disorder"];
        [array addObject:dic];
    }];
    self.doctorQulifications = array ;
}
//上传图片 认证
- (void)cetertificationAuthenWithParams:(id)params
                              andImages:(NSArray *)images
                                andView:(UIView *)view{
    [self requestDateWithUrl:Person_Certification_URL
                   andParams:params
                   andImages:images
                    andModel:nil
                        view:view
           andCommpleteBlock:^(id data, NSString *error) {
               
               
               if (!error) {
                   
                   if (self.delegate) {
                       [self.delegate uploadSucess];
                   }
               }
               else {
                   [self.delegate operateFailure:error];
                   
               }

    }];
}

//资质提交
- (void)saveCetertificationWithParams:(id)params
                              andView:(UIView *)view
                              complateHandle:(void(^)(id showdata,NSString *error))complet   {
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Qualification_Save
    params:params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
             complet(showdata,error);
                                                }];
   
}
//个人简介提交
- (void)changePersonalIntroduceWithParams:(id)params {
    
    NSLog(@"个人简介:%@",params);
    [self requestDateWithUrl:CHANGE_INTROODUCE_URL andParams:params
                   andImages:nil andModel:nil view:nil andCommpleteBlock:^(id data, NSString *error) {
        
                       if (error == nil) {
                           if (self.delegate) {
                               [self.delegate operateSuccess:@"资料完善成功"];
                           }
                       }else {
                           [self.delegate operateFailure:error];
                       }
    }];

}
- (void)requestDateWithUrl:(NSString *)url
                 andParams:(id)params
                 andImages:(NSArray *)images
                  andModel:(id)model
                      view:(UIView *)view
         andCommpleteBlock:(void(^)(id data,NSString *error))returnBlock {
            KRMainNetTool *tool = [KRMainNetTool new];
        if (images) {

            [tool upLoadData:url params:params
                     andData:images waitView:view
              complateHandle:^(id showdata, NSString *error) {
                  
                  
                
                  
                returnBlock(showdata,error);
            }];
        }
        else {
            [tool sendRequstWith:url params:params withModel:model waitView:view complateHandle:^(id showdata, NSString *error) {
                returnBlock(showdata,error);

                
            }];
        }
}
- (BOOL)juageExit:(id)obj {
    if (obj && ![obj isEqual:[NSNull null]])
    {
        return YES;
    }
    return NO ;
}

-(NSArray *)hightestEducational {
    
    return nil ;
}
@end
