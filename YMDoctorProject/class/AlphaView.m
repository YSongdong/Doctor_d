//
//  AlphaView.m
//  YMDoctorProject
//
//  Created by dong on 2017/7/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AlphaView.h"
#import "ClinicRemindView.h"
@implementation AlphaView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
       
    }
    return self;
}

-(void) createUI
{
    self.backgroundColor =[UIColor blackColor];
    self.alpha = 0.3;
    
}

-(void)panfunction:(UITapGestureRecognizer *) sender
{
    [self removeFromSuperview];
    
}



@end
