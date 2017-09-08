//
//  DemandOrderTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "DemandModel.h"

@interface DemandOrderTableViewCell : UITableViewCell

@property (nonatomic,strong)DemandModel *model ;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger orderType;

@end
