//
//  DemandHallModel.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandHallModel.h"
#import "DemandModel.h"
@interface DemandHallModel ()

@property (nonatomic,assign)dispatch_queue_t queue ;
@end
@implementation DemandHallModel
- (dispatch_queue_t)queue {
    
    return dispatch_queue_create("com.ymdoctordispatch.com", DISPATCH_QUEUE_SERIAL);
}
- (void)requetNetworkDataWithView:(UIView *)view {
    
    
    [self sendRequestDataWithUrl:Demand_Hall_URL
                       andParams:self.params andModel:nil
                            view:view andCommpleteHandle:^(id showData, NSString *error) {
                           
        if (showData ) {
            
            [self jaudgeDataWithParams:showData];
        }
        else {
            
            if (self.delegate) {
                [self.delegate getDataFailureWithReason:error];
            }
        }
    }];
}

- (void)requestArea {
 
    [self sendRequestDataWithUrl:GET_AREA_URL andParams:nil andModel:nil
                            view:nil
              andCommpleteHandle:^(id showData, NSString *error) {
                if (!error) {
            [self addressParams:showData];
        }
        
    }];
}


//toubiao
- (void)submitTenderWithParams:(id)params view:(UIView *)view{
    
    
    [self sendRequestDataWithUrl:SUBMIT_ORDER_URL andParams:params andModel:nil view:view
              andCommpleteHandle:^(id showData, NSString *error) {
                  
        if (error) {
            if (self.delegate) {
                [self.delegate getDataFailureWithReason:error];
            }
        }
        else {
            
            if (self.delegate) {
                [self.delegate requestDataSucess:@"投标成功"];
            }
        }
    }];
}

// detail order
-(void)getDemandHallDetailWithView:(UIView *)view
                          andModel:(id)model {
    
    
    [self sendRequestDataWithUrl:CET_DemandHall_Detail_URl
                       andParams:self.params
                        andModel:nil view:view
              andCommpleteHandle:^(id showData, NSString *error){
                  
                  NSLog(@"%@,%@",showData,error);
                  
                  if ([showData isKindOfClass:[NSDictionary class]]) {
                      NSDictionary *dic = (NSDictionary *)showData ;
                      [model setValuesForKeysWithDictionary:dic];
                      self.model = model ;
                    }
    }];
}
- (void)sendRequestDataWithUrl:(NSString *)url andParams:(id)params
                      andModel:(id )model view:(UIView *)view
            andCommpleteHandle:(void(^)(id showData,NSString *error)) commplete{
    
    KRMainNetTool *netTool = [[KRMainNetTool alloc]init];
    [netTool sendRequstWith:url params:params withModel:nil
                   waitView:view
             complateHandle:^(id showdata, NSString *error) {
          commplete(showdata,error) ;
                 
    }];
}

-(void)jaudgeDataWithParams:(id )reponse {
        //列表
        id demand_list = reponse[@"data"];
    
        if ([demand_list isKindOfClass:[NSArray class]]
            && [demand_list count] > 0){
            NSArray *array = [demand_list copy];
            NSMutableArray *mutaArray = [NSMutableArray array];
            dispatch_async(self.queue, ^{

                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                    NSUInteger idx, BOOL * _Nonnull stop){
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        DemandModel *model = [DemandModel new];
                        [model setValuesForKeysWithDictionary:obj];
                        [mutaArray addObject:model];
                    }
            }];
                self.demandLists = mutaArray ;
            });

            
            //医生资质
            dispatch_async(self.queue, ^{
              
                id forum_data = reponse[@"aptitude_list"];
                if ([forum_data isKindOfClass:[NSArray class]]
                    && [forum_data count]> 0) {
                    NSArray *forumArray = [forum_data copy];
                    NSMutableArray *array = [NSMutableArray array];
                    [forumArray enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                             NSUInteger idx,
                                                             BOOL * _Nonnull stop) {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        if ([obj isKindOfClass:[NSDictionary class]]) {
                            NSArray *keys = [obj allKeys];
                            [keys enumerateObjectsUsingBlock:^(id  _Nonnull object,
                                            NSUInteger idx, BOOL * _Nonnull stop) {
                                
                                if ([self juageExit:obj[object]]) {
                                    [dic setObject:obj[object] forKey:object];
                                }
                            }];
                            [array addObject:dic];
                        }
                    }];
                    self.forumDataList = array;
                }
            });
            
            //科室
            if ([reponse[@"ks"] isKindOfClass:[NSArray class]]
                && [reponse[@"ks"] count] > 0) {
                dispatch_async(self.queue, ^{
                    
                    NSArray *sys_enum = [reponse[@"ks"] copy];
                    
                    NSMutableArray *mutaArray = [NSMutableArray array];
                    
                    [sys_enum enumerateObjectsUsingBlock:^(id  _Nonnull obj,
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
                    self.departmentDic = [mutaArray mutableCopy];
                });
            }
        }
}

- (void)addressParams:(id)showData {
    
    if ([showData isKindOfClass:[NSDictionary class]]) {
        NSArray *array = showData[@"_area"];
        self.areas = array ;
        NSLog(@"self.areas-----------%@",self.areas);
    }
}

- (BOOL)juageExit:(id)obj {
    if (obj && ![obj isEqual:[NSNull null]])
    {
        return YES;
    }
    return NO ;
}

- (NSArray *)getsearchChoice {
    
    return @[@{@"ename":@"不限",@"key":@"0"},
             @{@"ename":@"价格由高到低",@"key":@"1"},
             @{@"ename":@"价格由低到高",@"key":@"2"}];
}

- (NSArray *)getsearchChoice2 {
    
    return @[@{@"ename":@"不限",@"key":@"0"},
             @{@"ename":@"1天内",@"key":@"1"},
             @{@"ename":@"3天内",@"key":@"2"},
             @{@"ename":@"一周内",@"key":@"3"}];
}


@end
