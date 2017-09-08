//
//  UILabel+CommonLabel.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CommonLabel)

+ (UILabel *)labelWithFont:(CGFloat)fontSize ;

- (void)color:(UInt32)hex ;
@end
