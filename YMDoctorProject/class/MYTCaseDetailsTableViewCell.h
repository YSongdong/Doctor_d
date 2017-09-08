//
//  MYTCaseDetailsTableViewCell.h
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTCaseDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *yearsAndMonthLab;

@property (weak, nonatomic) IBOutlet UILabel *daysLab;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *blueCircleLab;

-(void)addCaseDetailsDataWithDictionary:(NSDictionary *)dic;

@end
