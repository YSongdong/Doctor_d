//
//  DetailHomePageInfoTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DetailHomePageInfoTableViewCell.h"

@interface DetailHomePageInfoTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView; //头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//名字

@property (weak, nonatomic) IBOutlet UILabel *sexLabel; //性别

@property (weak, nonatomic) IBOutlet UILabel *agelabel;//年龄

@property (weak, nonatomic) IBOutlet UILabel *showTimeLabel; //显示复诊时间

@property (weak, nonatomic) IBOutlet UILabel *timeLabel; //时间
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel; //上次就诊时间


@end


@implementation DetailHomePageInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //显示时间
    self.showTimeLabel.textColor = [UIColor btnTextColor];
    
    //复诊时间
    self.timeLabel.textColor = [UIColor btnTextColor];
    
    //上次复诊时间
    self.lastTimeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    
    self.headerImageView.layer.cornerRadius = CGRectGetHeight(self.headerImageView.frame)/2;
    self.headerImageView.layer.masksToBounds = YES;
    
    // Initialization code
}

-(void)setModel:(PatienDetailModel *)model
{
    _model = model;
    //头像
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.mealth.mealth_img] placeholderImage:[UIImage imageNamed:@"Image-11"]];
    //名字
    self.nameLabel.text = model.mealth.mealth_name;
    
    //性别
    if ([model.mealth.mealth_age integerValue] == 0) {
        self.sexLabel.text = @"女";
    }else if ([model.mealth.mealth_age integerValue] == 0) {
        self.sexLabel.text = @"男";
    }
    
    //年龄
    self.agelabel.text = [NSString stringWithFormat:@"%@岁",model.mealth.mealth_age];
    
    //复诊时间
    self.timeLabel.text = model.mealth.fuzhen_time;
    
    //上次复诊时间
    self.lastTimeLabel.text =[NSString stringWithFormat:@"上次就诊:%@",model.mealth.create_time];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
