//
//  DemandOrderModel.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    
    contactUnkonw,
   contactApproprite, //洽谈妥当
    contactFailure, //洽谈失败
    makeConstract, //制定合同
    addContract ,//添加合同
    applyArbitrate, //申请仲裁
    applyPayment, //申请付款
    beginWork , //开始工作
    uploadPrescription //上传处方
}DemandType;

@protocol DemandOrderModelDelegate <NSObject>

- (void)requestDataSuccess:(id)data;

- (void)requestDataFailureWithReason:(NSString *)failure ;

- (void)operatorSuccessWithReason:(NSString *)reason  ;

- (void)operatorFailureWithReason:(NSString *)reason ;

@end


@interface DemandOrderModel : NSObject

@property (nonatomic,strong)NSArray *dataList ;

@property (nonatomic,weak)id <DemandOrderModelDelegate>delegate ;

@property (nonatomic,strong)NSArray *talkArrays;
@property (nonatomic,strong)NSArray *talkFailureArray ;

@property (nonatomic,assign)DemandType type ;


//需求订单列表
- (void)requestDataWithUrl:(NSString *)url
                 andParams:(id)params view:(UIView *)view;

//- (void)requestDataWithUrl:(NSString *)url  andParams:(id)params ;


//订单详情
- (void)requestOrderDetailWithParams:(id)params
                                 url:(NSString *)url
                            andModel:(id)model;


//评价对方
- (void)evaluateWithParams:(id)params
                   andView:(UIView *)view ;

////洽谈成功，上传处方
- (void)centerBtnOperatorWithUrl:(NSString *)url
                          params:(id)parms
                       andImages:(NSArray *)images
                         andView:(UIView *)view ;

//查看评论
- (void)showCommentsWithParams:(id)params
              commomPleteBlock:(void(^)(id status))commompleteBlock;


//请求合同内容
- (void)requestContractWithView:(UIView *)view
                    ReturnBlock:(void(^)(id value))returnBlock  ;

//签订合同人信息
- (void)reuquestContractInfoWithParams:(id)params
                             commplete:(void(^)(id value))returnBlock;

//制定合同
- (void)makeContractWithUrl:(NSString *)url
                  andParams:(id)params
                    andView:(UIView *)view;
@end
