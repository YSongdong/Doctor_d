//
//  UILabel+CommonLabel.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "UILabel+CommonLabel.h"
#import "UIColor+LSFoundation.h"
#import "UIColor+CustomColor.h"
@implementation UILabel (CommonLabel)

+ (UILabel *)labelWithFont:(CGFloat)fontSize {
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}


- (void)color:(UInt32)hex {
    self.textColor = [UIColor colorWithRGBHex:hex];
}


@end
