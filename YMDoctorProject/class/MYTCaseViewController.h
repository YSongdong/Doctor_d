//
//  MYTCaseViewController.h
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTFarther_VC.h"
#import <UIKit/UIKit.h>

@interface MYTCaseViewController : MYTFarther_VC

@property (nonatomic, strong)NSString *case_id;

@property (nonatomic, strong)NSString *type;

//请求列表数据
- (void)requestListDataWithView:(UIView *)view;

@end
