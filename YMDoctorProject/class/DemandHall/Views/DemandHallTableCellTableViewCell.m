//
//  DemandHallTableCellTableViewCell.m
//  YMDoctorProject
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//


#import "DemandHallTableCellTableViewCell.h"

@implementation DemandHallTableCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setDataList:(NSDictionary *)dataList{
    
    _dataList = dataList ;
    
    
    _orderNumLabel.text = dataList[@"demand_sn"];
    _moneyLabel.text = [@"¥" stringByAppendingString:dataList[@"money"]];

    
    _contentLabel.text = dataList [@"title"];
    _stateLabel.text = dataList[@"status_desc"];
    
    
    _needTimeLabel.text = dataList[@"demand_time"] ;
//    _orderTypeLabel.text = dataList[@"order_type"] ;
    
    NSString *orderTypeStr = dataList[@"order_type"];
    
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
    _orderTypeLabel.text = orderTypeStr ;

}


- (void)setModel:(DemandModel *)model {
    
    _model = model ;
    
    
    NSString *contractSignedStr = model.contract_signed;
    
    if ([contractSignedStr isEqualToString:@"0"]) {

        _orderNumLabel.text = model.demand_sn;
    
    }else{
        
        _orderNumLabel.text = model.order_sn;

    }
    
    
    _moneyLabel.text = [@"¥" stringByAppendingString:model.money];
    
    
    _contentLabel.text = model.title;
    _stateLabel.text = model.status_desc;
    
    
    _needTimeLabel.text = model.demand_time ;
//    _orderTypeLabel.text = model.order_type ;
    
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
        _orderTypeLabel.textColor = [UIColor colorWithRed:252/255.0 green:154/255.0 blue:0/255.0 alpha:1];
    }
    _orderTypeLabel.text = orderTypeStr ;
    
}




@end
