//
//  VIPPatientTableViewCell.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PatientManagerModel.h"


@protocol VIPPatientTableViewCellDelegate <NSObject>

-(void)selectdPatientCellIndexPath:(NSIndexPath *)indexPath;

@end

@interface VIPPatientTableViewCell : UITableViewCell

@property (nonatomic,strong)PatientManagerModel *model;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,weak) id <VIPPatientTableViewCellDelegate> delegate;

@end
