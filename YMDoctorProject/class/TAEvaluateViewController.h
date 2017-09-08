//
//  TAEvaluateViewController.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemandModel.h"

@interface TAEvaluateViewController : BaseViewController


@property (nonatomic,strong)DemandModel *demand_model  ;

@property (nonatomic,strong)NSString *order_idStr;


- (void)showCommentsWithParams:(id)params
              commomPleteBlock:(void(^)(id status))commompleteBlock;



@end
