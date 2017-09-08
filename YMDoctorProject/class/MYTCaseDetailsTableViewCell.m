//
//  MYTCaseDetailsTableViewCell.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTCaseDetailsTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MYTCaseDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.blueCircleLab.clipsToBounds = YES;
    self.blueCircleLab.layer.cornerRadius = self.blueCircleLab.bounds.size.height/2.0;
    
    self.imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [self.imgView addGestureRecognizer:tapGestureRecognizer];
    [self.imgView setUserInteractionEnabled:YES];
}
#pragma mark - 浏览大图点击事件
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

-(void)addCaseDetailsDataWithDictionary:(NSMutableDictionary *)dic{
        
    NSString *daysString = dic[@"d_time"];
    daysString = [daysString substringFromIndex:8];
    self.daysLab.text = daysString;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"d_imgs"][0]]];
    self.titleLab.text = dic[@"d_con"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
