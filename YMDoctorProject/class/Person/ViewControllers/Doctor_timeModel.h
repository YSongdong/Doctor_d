//
//  Doctor_timeModel.h
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor_timeModel : NSObject
//"doctor_time": [//门诊时间
//                {
//                    "week": "1",//0-6表示周日到周六
//                    "period": "2",//1-上午 2-下午 3晚上
//                    "hospital": "sfsdfds医院",//医院名字
//                    "ks": "呼吸科"//科室名字
//                }
//                ]

///0-6表示周日到周六
@property (nonatomic,copy) NSString * week;
///1-上午 2-下午 3晚上
@property (nonatomic,copy) NSString * period;
///医院名字
@property (nonatomic,copy) NSString * hospital;
///科室名字
@property (nonatomic,copy) NSString * ks;

+(id)getModelWithIndex:(NSInteger)index
              modelArr:(NSMutableArray*)modelArr;

-(NSString* )getWeekStr;
///1-上午 2-下午 3晚上
-(NSString *)getPeriodStr;
-(NSString *)getHospitalAndKs;
+(void)addModelWithMutArr:(NSMutableArray*)MutArr;
+(void)jianHaoModelWithMutArr:(NSMutableArray*)MutArr index:(NSInteger)index;
/**
 根据索引来隐藏或显示加减按钮
 
 
 */
-(void)hiddenIndex:(NSInteger)index addBtn:(UIButton*)addBtn
        jianHaoBtn:(UIButton*)jainHaoBtn arrCount:(NSInteger)arrCount;


@end
