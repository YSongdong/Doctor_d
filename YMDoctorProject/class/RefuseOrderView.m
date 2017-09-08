//
//  refuseOrderView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/6/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RefuseOrderView.h"

@implementation RefuseOrderView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    
    [self addGestureRecognizer:pan];
}


-(void)panfunction:(UIGestureRecognizer*)pan{
    [self  endEditing:YES];
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
    [window addSubview:self];
}


//消失
-(void)miss{
    
    [self removeFromSuperview];
}


@end
