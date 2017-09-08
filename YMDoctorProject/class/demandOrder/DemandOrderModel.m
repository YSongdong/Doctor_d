//
//  DemandOrderModel.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandOrderModel.h"
#import "DemandModel.h"

@implementation DemandOrderModel

//制定合同
- (void)makeContractWithUrl:(NSString *)url
                  andParams:(id)params
                    andView:(UIView *)view {
    
    [self senRequestDataWithUrl:url andParams:params andView:view
      andCommpleteBlock:^(id data, NSString *error) {
          if (!error) {
              if (self.delegate && [self.delegate respondsToSelector:@selector(operatorSuccessWithReason:)]) {
                  [self.delegate operatorSuccessWithReason:@"合同签订成功"];
              }
              
          }else {
              
              [self.delegate operatorFailureWithReason:error];
          }
    }];
}

//合同
- (void)requestContractWithView:(UIView *)view
                    ReturnBlock:(void(^)(id value))returnBlock {
    
    [self senRequestDataWithUrl:Contract_Protocal_Url andParams:nil andView:view
      andCommpleteBlock:^(id data, NSString *error) {
          
        returnBlock(data[@"doc_content"]);
    }];
}

//签订合同人信息
- (void)reuquestContractInfoWithParams:(id)params
                             commplete:(void(^)(id value))returnBlock{
     [self senRequestDataWithUrl:Contract_Info_Url andParams:params andView:nil andCommpleteBlock:^(id data, NSString *error){
      if (data) {
          returnBlock(data[@"_demand"]);
      }
      else {
          if (self.delegate) {
              [self.delegate requestDataFailureWithReason:error];
              
          }
      }
      }];
}

//查看评论
- (void)showCommentsWithParams:(id)params
              commomPleteBlock:(void(^)(id status))commompleteBlock{
    
    [self senRequestDataWithUrl:SHOW_EVALUATE_URL
                      andParams:params
                andView:nil
              andCommpleteBlock:^(id data, NSString *error) {
                  commompleteBlock(data);
    }];
}

//洽谈成功，上传处方
- (void)centerBtnOperatorWithUrl:(NSString *)url
                          params:(id)parms
                       andImages:(NSArray *)images
                         andView:(UIView *)view  {
    
    
    KRMainNetTool *tool = [KRMainNetTool new];
    if (images) {
        [tool upLoadData:url params:parms
                 andData:images
                waitView:view complateHandle:^(id showdata, NSString *error) {
                    
        }];
    }else {
        
        [tool sendRequstWith:url
                      params:parms withModel:nil
                    waitView:view complateHandle:^(id showdata, NSString *error) {
        
            //表示操作成功
            if (showdata) {
                
                NSString *reason ;
                if (self.type == contactApproprite) {
                    reason = @"洽谈成功";
                }
                if (self.type == contactFailure) {
                    reason = @"洽谈失败";
                }
                if (self.type == makeConstract) {
                    reason = @"制定合同成功";
                }
                if (self.type == applyPayment) {
                    reason = @"成功提醒对方付款";
                }
                if (self.type == applyArbitrate) {
                    reason = @"已成功提交申请";
                }
                [self.delegate operatorSuccessWithReason:reason];
            }
            else {
                [self.delegate operatorFailureWithReason:error];
            }
        }];
    }
}


//评价
- (void)evaluateWithParams:(id)params andView:(UIView *)view {
    
    [self senRequestDataWithUrl:EVALUATE_URL andParams:params andView:view
      andCommpleteBlock:^(id data, NSString *error) {
          if (!error) {
              [self.delegate operatorSuccessWithReason:@"已成功提交评价"];
          }else{
              [self.delegate operatorFailureWithReason:error];
          }
      }];
}

//request demand order data
- (void)requestDataWithUrl:(NSString *)url
                 andParams:(id)params view:(UIView *)view {
   
    [self senRequestDataWithUrl:url
                      andParams:params
                        andView:view
              andCommpleteBlock:^(id data, NSString *error) {
                         
        if (error == nil) {
            [self paramsDataWithArray:data];
        }
        
        if (error) {
            
            [self.delegate requestDataFailureWithReason:error];
        }
    }];
}

//订单详情 .雇佣订单详情 . 疑难杂症订单
- (void)requestOrderDetailWithParams:(id)params
                                 url:(NSString *)url
                            andModel:(id)model{

    [self senRequestDataWithUrl:url andParams:params andView:nil
      andCommpleteBlock:^(id data, NSString *error) {
          if (data) {
             [self paramsOrderDetailInfoWithParmas:data andModel:model];
          }
      }];
}

- (void)senRequestDataWithUrl:(NSString *)url
                    andParams:(id)params
                      andView:(UIView *)view
            andCommpleteBlock:(void(^)(id data ,NSString *error ))commplete {
    
    KRMainNetTool *tool = [KRMainNetTool new];
    
    [tool sendRequstWith:url params:params
               withModel:nil waitView:view
          complateHandle:^(id showdata, NSString *error) {
         commplete(showdata,error);
   
    }];
}

// save data
- (void)paramsDataWithArray:(id)array {
 
    NSArray *data = array;
    self.dataList = nil ;
    if ([data isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutaArray = [NSMutableArray array];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        DemandModel *model = [DemandModel new];
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [model setValuesForKeysWithDictionary:obj];
                [mutaArray addObject:model];
            }
        }];
        self.dataList = [mutaArray mutableCopy];
    }
}

//解析订单详情
- (void)paramsOrderDetailInfoWithParmas:(id)params
                               andModel:(id)model{
    
    if ([params isKindOfClass:[NSDictionary class]]) {
        if ([params[@"_demand"] isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:params[@"_demand"]];
        }
        if ([params[@"_order"] isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:params[@"_order"]];
        }
        if ([params[@"_contract"]isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:params[@"_contract"]];
        }
          if ([params[@"_contract"] isKindOfClass:[NSArray class]]
              && [params[@"_contract"] count] == 0) {
          }
        else {
            [model setValuesForKeysWithDictionary:params];
        }
        self.dataList = @[model] ;
    }
}

- (NSArray *)talkArrays {
    return @[@"雇主已详细描述需求",@"酬金已洽谈妥当",@"已联系好具体时间"];
}

- (NSArray *)talkFailureArray {
    return @[@"酬金无法达成一致",@"疑难杂症需要会诊",@"不擅长该类"];
}

@end
