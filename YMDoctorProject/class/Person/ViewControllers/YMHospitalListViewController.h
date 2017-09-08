//
//  YMHospitalListViewController.h
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YMHospitalModel.h"

@class YMHospitalListViewController;
@protocol YMHospitalListViewControllerDelegate <NSObject>

-(void)hospitalList:(YMHospitalListViewController *)hospitalList hospitalModel:(YMHospitalModel *)hospitalModel;

@end

@interface YMHospitalListViewController : UIViewController

@property(nonatomic,weak)id<YMHospitalListViewControllerDelegate> delegate;

@end
