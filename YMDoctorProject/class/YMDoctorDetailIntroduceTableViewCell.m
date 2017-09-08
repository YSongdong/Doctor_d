//
//  YMDoctorDetailIntroduceTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorDetailIntroduceTableViewCell.h"
@interface YMDoctorDetailIntroduceTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation YMDoctorDetailIntroduceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDetailWithDic:(NSDictionary *)dic {
    self.nameLabel.text = dic[@"name"];
    self.contentLabel.text = dic[@"content"];
}
@end
