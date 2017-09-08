//
//  clinicRemindView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/6/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ClinicRemindView.h"
#import "AlphaView.h"
#import "UIColor+LSFoundation.h"
@interface ClinicRemindView ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *docotTimeView; //就医时间背景view

@property (weak, nonatomic) IBOutlet UIView *messageBrounGView; //提醒补充view

@end


@implementation ClinicRemindView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.contentTextView.delegate = self;
    
    //就医时间view
    self.docotTimeView.layer.borderWidth = 1;
    self.docotTimeView.layer.borderColor = [UIColor lineColor].CGColor;
    //提醒补充view
    self.messageBrounGView.layer.borderWidth = 1;
    self.messageBrounGView.layer.borderColor = [UIColor lineColor].CGColor;
    
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
    
    if ([self.delegate respondsToSelector:@selector(selectdCancelBtn)]) {
        [self.delegate selectdCancelBtn];
    }
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

