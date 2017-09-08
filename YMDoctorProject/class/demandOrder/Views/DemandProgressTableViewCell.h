//
//  DemandProgressTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemandModel.h"


@protocol DemandProgressTableViewCellDelegate <NSObject>


- (void)didClickCellRightBtnEvent:(NSInteger)type ;


@end

@interface DemandProgressTableViewCell : UITableViewCell

@property (nonatomic,strong)DemandModel *model ;

@property (nonatomic,strong)NSDictionary *dataList ;
@property (nonatomic,weak)id <DemandProgressTableViewCellDelegate>delegate ;




@end
