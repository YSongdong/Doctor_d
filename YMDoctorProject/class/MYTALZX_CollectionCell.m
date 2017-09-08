//
//  MYTYSZYAL_CollectionCell.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTALZX_CollectionCell.h"

@implementation MYTALZX_CollectionCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
//    self.caseImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
//    [_caseImageView addGestureRecognizer:tapGestureRecognizer];
//    [_caseImageView setUserInteractionEnabled:YES];
    
}


- (void)addCaseData:(NSDictionary *)dic{
   
    [self.caseImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"case_thumb"]] placeholderImage:[UIImage imageNamed:@"方形图片"]];
    
    self.caseTitleLab.text = dic[@"case_title"];
    
    self.caseTimeLab.text = dic[@"case_time"];
    
    self.caseCountLab.text = [NSString stringWithFormat:@"%@次",dic[@"page_view"]];
}

#pragma mark - 浏览大图点击事件
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}


@end

