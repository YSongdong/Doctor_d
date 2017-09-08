//
//  CertificationView.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}

+ (instancetype)initWithXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0];
}

- (IBAction)cancelBtnClick:(UIButton *)sender {
    
    [self miss];
}


//展示
-(void)show{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    self.frame = window.frame;
    [window addSubview:self];
}

//消失
-(void)miss{
    
    [self removeFromSuperview];
}




@end
