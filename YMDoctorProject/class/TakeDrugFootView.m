//
//  TakeDrugFootView.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TakeDrugFootView.h"

@interface TakeDrugFootView ()

@property (weak, nonatomic) IBOutlet UIButton *addDrugBtn; //添加药品
@property (weak, nonatomic) IBOutlet UIView *backGrouView;//背景view
@property (weak, nonatomic) IBOutlet UITextField *doctorFootTF;

- (IBAction)FootSwitchAction:(UISwitch *)sender;

- (IBAction)addDrugBtnAction:(UIButton *)sender;

@end




@implementation TakeDrugFootView

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self updataUI];

}
-(void)updataUI{

    self.addDrugBtn.layer.borderWidth = 1;
    self.addDrugBtn.layer.borderColor = [UIColor btnBroungColor].CGColor;
    self.addDrugBtn.layer.cornerRadius = 5;
    self.addDrugBtn.layer.masksToBounds = YES;
    
    //背景view
    self.backGrouView.layer.borderWidth = 1;
    self.backGrouView.layer.borderColor = [UIColor lineColor].CGColor;
    self.backGrouView.layer.cornerRadius = 5;
    self.backGrouView.layer.masksToBounds = YES;
    
    
}

//是否开启通知
- (IBAction)FootSwitchAction:(UISwitch *)sender {
    
}
//添加药品
- (IBAction)addDrugBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdAddTakeDrugBtn)]) {
        [self.delegate selectdAddTakeDrugBtn];
    }
    
}
@end
