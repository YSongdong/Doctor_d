//
//  MYTOfficialTableViewCell.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTOfficialTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@property (strong, nonatomic) UILabel *startTimeLab;
@property (strong, nonatomic) UILabel *endTimeLab;


@property (weak, nonatomic) IBOutlet UILabel *conditionLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;


- (void)setContentData:(NSDictionary *)dic;


@end
