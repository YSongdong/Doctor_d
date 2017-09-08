//
//  MYTCaseTableViewCell.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "UIView+tool.h"
#import "UIColor+tool.h"
#import "MYTCaseTableViewCell.h"

@implementation MYTCaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.editBtn setCornerRadius:5 hexColor:@"EB7E00" borderWidth:1];
    
    [self.stateBtn setCornerRadius:5 hexColor:@"4BA6FF" borderWidth:1];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


@end

