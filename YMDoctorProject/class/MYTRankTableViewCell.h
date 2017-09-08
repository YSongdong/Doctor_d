//
//  MYTRankTableViewCell.h
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTRankTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *rankLab;


@property (weak, nonatomic) IBOutlet UILabel *diseaseLab;


@property (weak, nonatomic) IBOutlet UILabel *doctorLab;

@property (weak, nonatomic) IBOutlet UILabel *hospitalLab;

@property (weak, nonatomic) IBOutlet UILabel *scoreLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;


- (void)setContentData:(NSDictionary *)dic;


@end
