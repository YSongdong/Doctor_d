//
//  Doctor_timeModel.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Doctor_timeModel.h"

@implementation Doctor_timeModel


+(id)getModelWithIndex:(NSInteger)index
                          modelArr:(NSMutableArray*)modelArr{
   
    return  modelArr[index];
}
///1-上午 2-下午 3晚上
-(NSString *)getPeriodStr{
    NSString * PeriodStr = @"请选择";
    if ([self.period isEqualToString:@"1"]) {
        PeriodStr = @"上午";
    }
    if ([self.period isEqualToString:@"2"]) {
        PeriodStr = @"下午";
    }
    if ([self.period isEqualToString:@"3"]) {
        PeriodStr = @"晚上";
    }
    
    return PeriodStr;
}

-(NSString* )getWeekStr{
    NSString * weekStr =@"请选择";
    
    if ([self.week isEqualToString:@"0"]) {
        weekStr = @"星期日";
    }
    if ([self.week isEqualToString:@"1"]) {
        weekStr = @"星期一";
    }
    if ([self.week isEqualToString:@"2"]) {
        weekStr = @"星期二";
    }
    if ([self.week isEqualToString:@"3"]) {
        weekStr = @"星期三";
    }
    if ([self.week isEqualToString:@"4"]) {
        weekStr = @"星期四";
    }
    if ([self.week isEqualToString:@"5"]) {
        weekStr = @"星期五";
    }
    if ([self.week isEqualToString:@"6"]) {
        weekStr = @"星期六";
    }
    
    return weekStr;
}

+(instancetype)intModel{
    return [self new];
}

+(void)addModelWithMutArr:(NSMutableArray*)MutArr{
     id model = [self intModel];
    [MutArr addObject:model];
}
+(void)jianHaoModelWithMutArr:(NSMutableArray*)MutArr index:(NSInteger)index{
    
    [MutArr removeObjectAtIndex:index];
    
}

-(NSString *)getHospitalAndKs{
    return   [NSString stringWithFormat:@"%@%@", self.hospital==nil?@"":self.hospital  ,self.ks==nil?@"":self.ks];
}


/**
 根据索引来隐藏或显示加减按钮


 */
-(void)hiddenIndex:(NSInteger)index addBtn:(UIButton*)addBtn
        jianHaoBtn:(UIButton*)jainHaoBtn arrCount:(NSInteger)arrCount{
    addBtn.hidden = NO;
    jainHaoBtn.hidden = NO;
    if (arrCount==1) {
        jainHaoBtn.hidden = YES;
        addBtn.hidden = NO;

    }else{
//        如果是第一个
        if (index==0) {
            jainHaoBtn.hidden = YES;
            addBtn.hidden = YES;
        }
        
        
//        如果是最后一个
        if (index==arrCount-1) {
            addBtn.hidden = NO;
            jainHaoBtn.hidden = NO;
        }
//        中间的
        if ((index!=arrCount-1)&&(index!=0)) {
            addBtn.hidden = YES;
            jainHaoBtn.hidden = NO;
        }
        
    }
    
   
    
    
    
}



@end
