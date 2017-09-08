//
//  DemandHallDetailViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "DemandModel.h"

@interface DemandHallDetailViewController : BaseViewController
@property (nonatomic,strong)NSString *buttonTitle ;
@property (nonatomic,assign)NSInteger buttonType ;
@property (nonatomic,strong)DemandModel * model  ;
@property (nonatomic,assign)NSInteger type ;

@end
