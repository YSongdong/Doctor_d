//
//  MYTOrderDetailsTableViewCell1.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOrderDetailsTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MYTOrderDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.headImgView.clipsToBounds = YES;
    self.headImgView.layer.cornerRadius = self.headImgView.bounds.size.height/2;
}

- (void)setDetailsWithDictionary:(NSDictionary *)dic{
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"leaguer_img"]]];
    self.nameLab.text = dic[@"leagure_name"];
    
    NSString *sexStr = dic[@"leagure_sex"];
    if ([sexStr isEqualToString:@"1"]) {
        
        sexStr = @"男";
        
    }else{
        
        sexStr = @"女";

    }
    self.sexLab.text = sexStr;

    self.ageLab.text = [NSString stringWithFormat:@"%@岁",dic[@"leagure_age"]];
    self.titleLab.text = dic[@"title"];
    //类型
    NSString *demandType = dic[@"demand_type"];
    if ([demandType integerValue] == 0) {
        //询医问诊
        self.demandTypeLabel.text = @"预约订单";
    }else if ([demandType integerValue] == 1) {
       //询医问诊
        self.demandTypeLabel.text = @"询医问诊";
    }else if([demandType integerValue] == 2) {
       //市内坐诊
        self.demandTypeLabel.text = @"市内坐诊";
    
    }else if([demandType integerValue] == 3) {
        //活动讲座
        self.demandTypeLabel.text = @"活动讲座";
        
    }
    
    //科室信息
    self.ksLabel.text = dic[@"small_ks"];
    //医师资格
    self.aptitudeLab.text = dic[@"aptitude"];
    //开始时间
    self.demandTimeLab.text = dic[@"demand_time"];
    //结束时间
    self.demandEndTimelab.text = dic[@"demand_time2"];
    //医院名字
    self.hospitalNameLab.text = dic[@"hospital_name"];
    //需求描述
    self.demandContentTextView.text = dic[@"demand_content"];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
