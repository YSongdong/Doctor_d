//
//  DemandProgressViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "DemandModel.h"

typedef enum : NSUInteger {
    demandOrderType,
    employType,
    incruableType,
    
} Ordertype;

@interface DemandProgressViewController : BaseViewController

@property (nonatomic,strong)DemandModel *model ;
@property (nonatomic,assign)NSInteger slectedIndex ;
@property (nonatomic,assign)Ordertype type ;

@property (nonatomic,strong)NSString *userName ;

@property (nonatomic,strong)NSString *demand_id ;



@end
