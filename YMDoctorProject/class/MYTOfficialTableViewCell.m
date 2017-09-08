//
//  MYTOfficialTableViewCell.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOfficialTableViewCell.h"

@implementation MYTOfficialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setContentData:(NSDictionary *)dic {
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@"暂无消息"]];
    
    self.titleLab.text = dic[@"title"];
    
//    self.startTimeLab.text = dic[@"start_time"];
//    self.endTimeLab.text = dic[@"end_time"];
    
    self.timeLab.text = [NSString stringWithFormat:@"活动时间: %@ -- %@",dic[@"start_time"],dic[@"end_time"]];
    
    self.conditionLab.text = [NSString stringWithFormat:@"参与条件: %@",dic[@"conditions"]];
    self.contentLab.text = dic[@"intro"];
 }






@end
