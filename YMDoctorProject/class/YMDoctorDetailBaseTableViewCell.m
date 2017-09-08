//
//  YMDoctorDetailBaseTableViewCell.m
//  doctor_user
//
//  Created by kupurui on 17/2/7.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorDetailBaseTableViewCell.h"
@interface YMDoctorDetailBaseTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailslabel;

@end
@implementation YMDoctorDetailBaseTableViewCell

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
    self.detailslabel.text = [NSString stringWithFormat:@"%@",dic[@"detail"]];
}
@end
