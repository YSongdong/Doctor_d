//
//  MYTCertificationTableViewCell.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTCertificationTableViewCell.h"

@implementation MYTCertificationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.headBtn.clipsToBounds = YES;
    self.headBtn.layer.cornerRadius = 40;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


//真实姓名  return
- (IBAction)realNameTFClick:(UITextField *)sender {
}


//身份证号  return
- (IBAction)numTextFieldClick:(UITextField *)sender {
}




//真实姓名
- (IBAction)realNameTF:(UITextField *)sender {
    if (self.CallBack) {
        self.CallBack(sender.text,0);
    }
}

//身份证号
- (IBAction)numTextField:(UITextField *)sender {
    
    if (self.CallBack) {
        self.CallBack(sender.text,1);
    }
}

@end
