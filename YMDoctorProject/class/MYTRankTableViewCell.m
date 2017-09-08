//
//  MYTRankTableViewCell.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTRankTableViewCell.h"

@implementation MYTRankTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImgView.clipsToBounds = YES;
    self.headImgView.layer.cornerRadius = 35;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setContentData:(NSDictionary *)dic {
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:dic[@"member_avatar"]] placeholderImage:[UIImage imageNamed:@"暂无消息"]] ;
    
    self.nameLab.text = dic[@"member_names"] ;
    
    self.rankLab.text =  [NSString stringWithFormat:@"NO.%@",dic[@"no"]];
    
    self.doctorLab.text = dic[@"member_aptitude"] ;
    self.hospitalLab.text = [NSString stringWithFormat:@"%@ %@", dic[@"member_occupation"],dic[@"member_ks"]] ;
    
    self.scoreLab.text = [NSString stringWithFormat:@"总评分:%@", dic[@"avg_score"]] ;
    
    self.amountLab.text =  [NSString stringWithFormat:@"上周成交量:%@", dic[@"week_store_sales"]] ;
    
    self.moneyLab.text = [NSString stringWithFormat:@"成交量%@笔",  dic[@"store_sales"]];
}

@end
