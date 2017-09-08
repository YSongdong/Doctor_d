//
//  YMDoctorHomePageViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

@interface YMDoctorHomePageViewController : BaseViewController
@property (nonatomic,strong) NSString *store_id;//店铺ID

@property (nonatomic,assign) BOOL isUserDoctor; //判断是不是自己

@end
