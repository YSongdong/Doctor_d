//
//  TakeDrugTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TakeDrugTableViewCell.h"

@interface TakeDrugTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *drugBackgrounView; //背景view

@property (weak, nonatomic) IBOutlet UITextField *drugNameTF; //药名TF

@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel; //时间次数label

@property (weak, nonatomic) IBOutlet UITextField *drugDayTF;//用药天数TF
- (IBAction)selectdTimeCountBtnAction:(UIButton *)sender; //选择时间和天数

@property (weak, nonatomic) IBOutlet UIButton *drugEditBtn; //编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *saveBtn; //保存

- (IBAction)saveBtnAction:(UIButton *)sender;


@end



@implementation TakeDrugTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self updateUI];
    
    

}

-(void)updateUI{
    //背景view
    self.drugBackgrounView.layer.borderWidth = 1;
    self.drugBackgrounView.layer.borderColor = [UIColor lineColor].CGColor;
    self.drugBackgrounView.layer.cornerRadius = 5;
    self.drugBackgrounView.layer.masksToBounds = YES;
   
    [self.drugEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.drugEditBtn setTitle:@"删除" forState:UIControlStateSelected];
    [self.drugEditBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
    [self.drugEditBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateSelected];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//编辑和删除按钮
- (IBAction)selectdTimeCountBtnAction:(UIButton *)sender {
    
}
//保存按钮
- (IBAction)saveBtnAction:(UIButton *)sender {
}
@end
