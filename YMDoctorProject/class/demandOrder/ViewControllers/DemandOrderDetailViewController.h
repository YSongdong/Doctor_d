//
//  DemandOrderDetailViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemandModel.h"

typedef enum : NSUInteger {
    demandDetailType,
    employerDetailType,
    incruableDetailTyppe,
} OrderDetailType;
@interface DemandOrderDetailViewController : BaseViewController
@property (nonatomic,assign)OrderDetailType detailType ;

@property (nonatomic,strong)NSString *demand_id ;


@end
