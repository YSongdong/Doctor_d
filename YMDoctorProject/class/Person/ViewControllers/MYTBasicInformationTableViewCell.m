//
//  MYTBasicInformationTableViewCell.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTBasicInformationTableViewCell.h"

@implementation MYTBasicInformationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (IBAction)returnClick:(UITextField *)sender {
//    NSLog(@"3453245234");
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)hostButtonclick:(id)sender {
    NSDictionary *dic = @{@"type":@(ClickHospitalType)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MYTBasicInformationTableViewCellClick" object:nil userInfo:dic];
    
}
- (IBAction)goodDiseaseButtonClick:(id)sender {
    NSDictionary *dic = @{@"type":@(ClickDiseaseType)};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MYTBasicInformationTableViewCellClick" object:nil userInfo:dic];

}

@end
