//
//  MYTOrderProcess1TableViewCell.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOrderProcessTableViewCell.h"
#import <UIButton+WebCache.h>

@implementation MYTOrderProcessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

 #pragma mark - 鸣医订单
    //查看合同
    self.viewContractBtn.clipsToBounds = YES;
    self.viewContractBtn.layer.cornerRadius = 5;
    
     self.doctorSignTimeLab.hidden = YES;
    
    //确认提交
    self.sureCommitBtn.clipsToBounds = YES;
    self.sureCommitBtn.layer.cornerRadius = 5;
    
    //申请仲裁
    self.applyArbitrationBtn.clipsToBounds = YES;
    self.applyArbitrationBtn.layer.cornerRadius = 5;
    self.applyArbitrationBtn.layer.borderWidth = 1;
    self.applyArbitrationBtn.layer.borderColor = [UIColor colorWithRed:253/255.0 green:4/255.0 blue:0/255.0 alpha:1].CGColor;
    
    
    //确认提交
    self.sureCommitBtn2.clipsToBounds = YES;
    self.sureCommitBtn2.layer.cornerRadius = 5;
    self.sureCommitBtn2.layer.borderWidth = 1;
    self.sureCommitBtn2.layer.borderColor = [UIColor colorWithRed:223/255.0 green:225/255.0 blue:225/255.0 alpha:1].CGColor;
    
    //查看评价
    self.viewEvaluateBtn.clipsToBounds = YES;
    self.viewEvaluateBtn.layer.cornerRadius = 5;
    self.viewEvaluateBtn.layer.borderWidth = 1;
    self.viewEvaluateBtn.layer.borderColor = [UIColor colorWithRed:223/255.0 green:225/255.0 blue:225/255.0 alpha:1].CGColor;
    
#pragma mark - 预约订单
    
    //接受预约
    self.acceptOrderBtn.clipsToBounds = YES;
    self.acceptOrderBtn.layer.cornerRadius = 5;
    
    //拒绝预约
    self.refuseOrderBtn.clipsToBounds = YES;
    self.refuseOrderBtn.layer.cornerRadius = 5;
    self.refuseOrderBtn.layer.borderWidth = 1;
    self.refuseOrderBtn.layer.borderColor = [UIColor colorWithRed:223/255.0 green:225/255.0 blue:225/255.0 alpha:1].CGColor;
}

- (void)setDetailsWithDictionary:(NSDictionary *)dic{
    
    NSLog(@"dic----------%@",dic);
    
    self.orderSnLab.text = dic[@"order_sn"];
    self.moneyLab.text = [NSString stringWithFormat:@"¥ %@",dic[@"money"]];
    self.titleLab.text = dic[@"title"];
    self.demandTimeLab.text = dic[@"demand_time"];
    
//    self.doctorSignTimeLab.text = dic[@"doctor_sign_time"];
    
//    NSMutableArray *imgArr = dic[@"instructions_img"];
//    
//    NSMutableArray *imgBtnArr = [[NSMutableArray alloc]initWithObjects:self.instructionsBtn1, self.instructionsBtn2, self.instructionsBtn3, self.instructionsBtn4, nil];
//    if ([imgArr isKindOfClass:[NSMutableArray class]] && imgArr.count > 0) {
//        
//          NSMutableArray *instructionsImgArr = imgArr;
//        for (int i = 0; i < instructionsImgArr.count; i ++) {
//            
//            UIButton *imgBtn = [imgBtnArr objectAtIndex:i];
//            [imgBtn setImage:[UIImage imageNamed:instructionsImgArr[i]] forState:UIControlStateNormal];
//        }
//    }
    
    
    if ([dic[@"instructions_img"] count] == 4) {
        
        
        if (dic[@"instructions_img"][0]) {
            
            [self.instructionsBtn1 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][0]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
        
        if (dic[@"instructions_img"][1]) {
            
            [self.instructionsBtn2 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][1]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
        
        if (dic[@"instructions_img"][2]) {
            
            [self.instructionsBtn3 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][2]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
        
        if (dic[@"instructions_img"][3]) {
            
            [self.instructionsBtn4 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][3]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
    }
    
    if ([dic[@"instructions_img"] count] == 3) {
        
        
        if (dic[@"instructions_img"][0]) {
            
            [self.instructionsBtn1 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][0]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
        
        if (dic[@"instructions_img"][1]) {
            
            [self.instructionsBtn2 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][1]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
        
        if (dic[@"instructions_img"][2]) {
            
            [self.instructionsBtn3 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][2]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
    }
    
    
    if ([dic[@"instructions_img"] count] == 2) {
        
        
        if (dic[@"instructions_img"][0]) {
            
            [self.instructionsBtn1 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][0]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
        
        if (dic[@"instructions_img"][1]) {
            
            [self.instructionsBtn2 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][1]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
    }
    
    
    if ([dic[@"instructions_img"] count] == 1) {
        
        
        if (dic[@"instructions_img"][0]) {
            
            [self.instructionsBtn1 sd_setImageWithURL:[NSURL URLWithString:dic[@"instructions_img"][0]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
            
        }
    }
    
//    NSMutableArray *imgBtnArr = [[NSMutableArray alloc]initWithObjects:self.instructionsBtn1, self.instructionsBtn2, self.instructionsBtn3, self.instructionsBtn4, nil];
//    
//    NSMutableArray *imgArr = dic[@"instructions_img"];
//    
//    for (int i = 0; i < imgArr.count; i ++) {
//        
//        NSString *imgStr = dic[@"instructions_img"][i];
//        UIButton *btn = [imgBtnArr objectAtIndex:i];
//        [btn sd_setImageWithURL:[NSURL URLWithString:imgStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"方形图片"]];
//    }
    
    
    self.instructionsTextView.text = dic[@"instructions_content"];
    
    self.evaluateTextView.text = dic[@"doctor_ping"];
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end

