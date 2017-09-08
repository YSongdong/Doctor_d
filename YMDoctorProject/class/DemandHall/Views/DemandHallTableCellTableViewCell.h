//
//  DemandHallTableCellTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemandModel.h"

@interface DemandHallTableCellTableViewCell : UITableViewCell

//新
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@property (weak, nonatomic) IBOutlet UILabel *needTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;


@property (nonatomic,strong)NSDictionary *dataList ;
@property (nonatomic,strong)DemandModel *model ;


@end

