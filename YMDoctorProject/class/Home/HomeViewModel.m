//
//  HomeViewModel.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeViewModel.h"
#import "DemandModel.h"


@implementation HomeViewModel
- (void)requestHomePageDataWithView:(UIView *)view
                          andParams:(id )params{
    
    [self requestHomeListWithView:view andParams:params];

}

- (void)requestHomeListWithView:(UIView *)view
                      andParams:(id )params {
    
    if (![self getStore_id]) {
        return ;
    }
    
    [self senRequestDataWithUrl:HOME_LIST_URL
                      andParams:params
                       andClass:nil andView:view
              andCommpleteBlock:^(id data, NSString *error) {
                  dispatch_async(dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT), ^{
                      NSLog(@"%@",data);
                      [self paramsHomeDataListWithParams:data];
                  });
              }];
}

- (void)getHeadImage {
    [self senRequestDataWithUrl:HOME_PIC_URL
                      andParams:nil andClass:nil andView:nil
              andCommpleteBlock:^(id data, NSString *error) {
                  NSLog(@"=====>%@",error);
                                    
                  if (data ) {
                      
                      self.pics = data ;
                  }
              }];
}

- (void)requestOrderWithParmas:(id)params
                       andView:(UIView *)view
                andReturnBlock:(void(^)(id status))statusBlock {
    
    
    [self senRequestDataWithUrl:Demand_Order_Detail_URL
                      andParams:params
                       andClass:nil
                        andView:view
              andCommpleteBlock:^(id data, NSString *error) {
                  if (data) {
                      statusBlock([self paramsDataWithData:data]);
                  }
    }];
}

- (DemandModel *)paramsDataWithData:(id)data{
    
    DemandModel *model = [DemandModel new];
    if ([data isKindOfClass:[NSDictionary class]]) {
        if ([data[@"_demand"] isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:data[@"_demand"]];
        }
        if ([data[@"_order"] isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:data[@"_order"]];
        }
        if ([data[@"_contract"]isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:data[@"_contract"]];
        }
        
    }
        return model ;
}

- (void)senRequestDataWithUrl:(NSString *)url
                    andParams:(id)params
                     andClass:(Class)class
                      andView:(UIView *)view
            andCommpleteBlock:(void(^)(id data,NSString *error))commpletw {
    
    KRMainNetTool *tool = [KRMainNetTool new];
    
    [tool sendRequstWith:url params:params withModel:class waitView:view complateHandle:^(id showdata, NSString *error) {
        commpletw(showdata,error);
    }];
}
- (void)paramsHomeDataListWithParams:(id)params {
    
    if ([params[@"_order"] isKindOfClass:[NSArray class]]) {
         NSArray *array = params[@"_order"];
         NSMutableArray  *mutArray =  [NSMutableArray array];
         [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DemandModel *model = [DemandModel new];
            [model setValuesForKeysWithDictionary:obj];
            [mutArray addObject:model];
        }];
        self.dataList = [mutArray mutableCopy];
    }
}
@end
