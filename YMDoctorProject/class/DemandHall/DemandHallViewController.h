//
//  DemandHallViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface DemandHallViewController : UIViewController



@property (nonatomic,assign)NSInteger ways ;

@property (nonatomic,strong)NSString *searchContent ;


- (void)clickEvent:(UIBarButtonItem *)searchBtn ;

@end
