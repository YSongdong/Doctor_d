//
//  DetailDosageTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PatienDetailModel.h"


@protocol DetailDosageTableViewCellDelegate <NSObject>

-(void) dosageCellHeigh:(CGFloat)cellHeight;

@end

@interface DetailDosageTableViewCell : UITableViewCell

@property (nonatomic,weak) id <DetailDosageTableViewCellDelegate> delegate;

@property (nonatomic,strong) MedicationDurgModel *model; //数据


@end
