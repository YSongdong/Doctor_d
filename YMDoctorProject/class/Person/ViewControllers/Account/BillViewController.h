//
//  BillViewController.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"


typedef enum : NSUInteger {
    demandOrderType,
    EmployerOrderType,
}BillListType;
@interface BillViewController : BaseViewController
@property (nonatomic,assign)BillListType type ;

@end
