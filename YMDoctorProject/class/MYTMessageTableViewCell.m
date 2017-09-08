//
//  MYTMessageTableViewCell.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTMessageTableViewCell.h"

@implementation MYTMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.countLab.layer.cornerRadius = 10;
//    self.messageImageView.layer.cornerRadius = 30;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
