//
//  MessageTableViewCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()

@end

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImg.layer.cornerRadius = 30 ;
    self.headImg.layer.masksToBounds = YES ;
    self.timeLabel.alpha = 0.5 ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setDataModel:(id)model {
    
    
    }

- (void)setCellBackgroundColor:(UIColor *)color {
    
}

@end
