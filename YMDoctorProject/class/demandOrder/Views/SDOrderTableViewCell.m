//
//  SDOrderTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SDOrderTableViewCell.h"

#import "UILabel+WLKit.h"

@interface SDOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *demandSnLab; //需求编号
@property (weak, nonatomic) IBOutlet UILabel *moneyLab; //价格

@property (weak, nonatomic) IBOutlet UILabel *titleLab; //title
@property (weak, nonatomic) IBOutlet UILabel *statusLab;

@property (weak, nonatomic) IBOutlet UILabel *demandTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLab; //类型

@property (weak, nonatomic) IBOutlet UIView *orderBackgrounView; //大背景view

@property (weak, nonatomic) IBOutlet UIView *typeBackgroundView; //状态背景view

@property (nonatomic,strong)  UILabel *label;  //状态

@end



@implementation SDOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor =Global_mainBackgroundColor;
    
    [self initUI];
    
    self.label= [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 12.0, 60.0)];
    _label.numberOfLines =0;
    _label.font = [UIFont systemFontOfSize:12];
    _label.textColor =[UIColor whiteColor];
    [_typeBackgroundView addSubview:_label];
}

-(void)initUI
{
   
    //title
    self.titleLab.textColor = [UIColor colorWithHexString:@"#4CA6FF"];
    //需求编号
    self.demandSnLab.textColor = [UIColor colorWithHexString:@"#666666"];
    //需求时间
    self.demandTimeLab.textColor = [UIColor colorWithHexString:@"#666666"];
    //价格
    self.moneyLab.textColor = [UIColor colorWithHexString:@"#FF4C4C"];
    //类型
    self.orderTypeLab.textColor = [UIColor colorWithHexString:@"#666666"];
    //大背景
    self.orderBackgrounView.layer.masksToBounds = YES;
    self.orderBackgrounView.layer.cornerRadius = 5;
}

- (void)setModel:(DemandModel *)model {
    
    _model = model ;
    
    
    NSString *contractSignedStr = model.contract_signed;
    
    if ([contractSignedStr isEqualToString:@"0"]) {
        
        _demandSnLab.text = model.demand_sn;
        
    }else{
        
       _demandSnLab.text = model.order_sn;
        
    }
    
    _moneyLab.text = [@"¥:" stringByAppendingString:model.money];
    
    //标题
    _titleLab.text = model.title;
    //需求时间
    _demandTimeLab.text = model.demand_time ;
   
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
        _orderTypeLab.textColor = [UIColor colorWithRed:252/255.0 green:154/255.0 blue:0/255.0 alpha:1];
    }
    _orderTypeLab.text = orderTypeStr ;
    
    //显示状态
    if ([model.status_number integerValue] == 0) {
         //0未选标
        _typeBackgroundView.backgroundColor =[UIColor colorWithHexString:@"#4CA6FF"];
    }else if ([model.status_number integerValue] == 1){
         //1已选标
        
         _typeBackgroundView.backgroundColor =[UIColor colorWithHexString:@"#C1C1C1"];
        
    }else if ([model.status_number integerValue] == 2){
        // 2已完成订单
        _typeBackgroundView.backgroundColor =[UIColor colorWithHexString:@"#FF9A0D"];
        
    }
    _label.text = model.status_desc;
   
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
