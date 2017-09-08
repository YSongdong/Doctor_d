//
//  HomeListTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DemandModel.h"

typedef void(^SelectedBlock)(NSInteger type);

@interface HomeListTableViewCell : UITableViewCell

@property (nonatomic,strong)DemandModel *model ;

@property (nonatomic,copy)SelectedBlock block ;

@property (nonatomic,assign)NSInteger type ;


@end
