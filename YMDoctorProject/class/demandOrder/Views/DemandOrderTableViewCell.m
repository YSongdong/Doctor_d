//
//  DemandOrderTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandOrderTableViewCell.h"

@interface DemandOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *demandSnLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@property (weak, nonatomic) IBOutlet UILabel *demandTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab;


@end

@implementation DemandOrderTableViewCell


- (void)setModel:(DemandModel *)model {

    _model = model ;
    
    NSLog(@"model----------------%@",model);

    
    NSString *doctorSignedStr = model.doctor_signed;
    
    if ([doctorSignedStr isEqualToString:@"0"]) {

       self.demandSnLab.text = model.demand_sn;
    
    }else {
        
        self.demandSnLab.text = model.order_sn;
        
    }
    
    self.moneyLab.text = [NSString stringWithFormat:@"¥ %@",model.money];
    
    self.titleLab.text = [NSString stringWithFormat:@"%@",model.title];
    
    if ([model.order_type isEqualToString:@"2"]) {
        
        self.statusLab.text =  [NSString stringWithFormat:@"%@",model.yuyue_state_desc];
    }else{
        
        self.statusLab.text =  [NSString stringWithFormat:@"%@",model.status_desc];
    }
    
    
    self.demandTimeLab.text = model.demand_time;
//    self.orderTypeLab.text = model.order_type;
    
    
    NSString *orderTypeStr = model.order_type;
    
    if ([orderTypeStr isEqualToString:@"1"]) {
        
        orderTypeStr = @"鸣医订单";
        
    }else if ([orderTypeStr isEqualToString:@"2"]) {
        
        orderTypeStr = @"预约订单";
        
    }else if ([orderTypeStr isEqualToString:@"3"]) {
        
        orderTypeStr = @"服务购买";
        
    }else if ([orderTypeStr isEqualToString:@"4"]) {
        
        orderTypeStr = @"活动参与订单";
        
    }else if ([orderTypeStr isEqualToString:@"5"]) {
        
        orderTypeStr = @"提交报告";
        
    }else if ([orderTypeStr isEqualToString:@"6"]) {
        
        orderTypeStr = @"疑难杂症";

    }
    self.orderTypeLab.text = orderTypeStr ;

}


@end
