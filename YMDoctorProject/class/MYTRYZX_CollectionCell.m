//
//  MYTYSZYRYZX_CollectionCell.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTRYZX_CollectionCell.h"


@implementation MYTRYZX_CollectionCell

-(void)awakeFromNib{    
    [super awakeFromNib];
    self.honourImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [_honourImageView addGestureRecognizer:tapGestureRecognizer];
    [_honourImageView setUserInteractionEnabled:YES];
}


- (void)addHonourData:(NSDictionary *)dic {
    
    self.honourTitleLab.text = dic[@"honor_name"];
    
    [self.honourImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"honor_image"]] placeholderImage:[UIImage imageNamed:@"方形图片"]];
}

#pragma mark - 浏览大图点击事件
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}



@end
