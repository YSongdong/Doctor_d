//
//  MYTAccountRecordTableViewCell.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTAccountRecordTableViewCell.h"

@implementation MYTAccountRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setDataWithDictionary:(NSMutableDictionary *)dic{
    
    self.timeLab.text = dic[@"finnshed_time"];
    
    self.titleLab.text = dic[@"member_names"];
    self.contentLab.text = dic[@"demand_sketch"];
    
    self.moneyLab.text = dic[@"order_amount"];
    
    NSString *symbolStr = dic[@"symbol"];
    if ([symbolStr isEqualToString:@"+"]) {
        
        self.moneyLab.textColor = [UIColor colorWithRed:255/255.0 green:160/255.0 blue:30/255.0 alpha:1];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
