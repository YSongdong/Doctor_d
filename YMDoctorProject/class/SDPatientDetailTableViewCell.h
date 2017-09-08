//
//  SDPatientDetailTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Health_historyModel.h"
@interface SDPatientDetailTableViewCell : UITableViewCell
@property(nonatomic,copy)NSString *text;

@property(nonatomic,strong)Health_historyModel *model;

@property(nonatomic,assign)BOOL showYearAndMonth;

@property(nonatomic,assign)BOOL showTitleLabel;

@property(nonatomic,copy)NSString *titleStr;

+(CGFloat)caseDetailViewHeight:(Health_historyModel *)model;

@end
