//
//  RemindTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RemindTableViewCell.h"

@interface RemindTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *remindBackgrouView;


@end



@implementation RemindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateUI];
    
    
    
}

-(void)updateUI{
    //背景view
    self.remindBackgrouView.layer.borderWidth = 1;
    self.remindBackgrouView.layer.borderColor = [UIColor lineColor].CGColor;
    self.remindBackgrouView.layer.cornerRadius = 5;
    self.remindBackgrouView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
