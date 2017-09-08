//
//  YMCaseDetailsDayInformationModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMCaseDetailsDayInformationModel : NSObject

@property(nonatomic,copy)NSString *d_time;//案例时间
@property(nonatomic,strong)NSArray *d_imgs;//案例图片
@property(nonatomic,copy)NSString *d_con;//案例详情描述

-(NSString *)year;
-(NSString *)month;
-(NSString *)day;

@end
