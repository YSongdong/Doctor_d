//
//  YMCaseDetailTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCaseDetailsDayInformationModel.h"

@interface YMCaseDetailViewTableViewCell : UITableViewCell


@property(nonatomic,copy)NSString *text;

@property(nonatomic,strong)YMCaseDetailsDayInformationModel *model;

@property(nonatomic,assign)BOOL showYearAndMonth;

@property(nonatomic,assign)BOOL showTitleLabel;

@property(nonatomic,copy)NSString *titleStr;

+(CGFloat)caseDetailViewHeight:(YMCaseDetailsDayInformationModel *)model;



@end
