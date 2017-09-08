//
//  NewOrderTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NewOrderTableViewCell.h"

@interface NewOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *demandSnLab; //订单号
@property (weak, nonatomic) IBOutlet UILabel *moneyLab; //价格
@property (weak, nonatomic) IBOutlet UILabel *durgTitleLabel; //病标题
@property (weak, nonatomic) IBOutlet UILabel *statusLabel; //状态
@property (weak, nonatomic) IBOutlet UILabel *demandTimeLab; //需求时间
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab; //订单类型



@end



@implementation NewOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
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
    
    self.durgTitleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    
    if ([model.order_type isEqualToString:@"2"]) {
        
        self.statusLabel.text =  [NSString stringWithFormat:@"%@",model.yuyue_state_desc];
    }else{
        
        self.statusLabel.text =  [NSString stringWithFormat:@"%@",model.status_desc];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
