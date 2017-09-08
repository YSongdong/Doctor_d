//
//  YMCaseDetailsMonthInformationModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMCaseDetailsDayInformationModel.h"

@interface YMCaseDetailsMonthInformationModel : NSObject

@property(nonatomic,copy)NSString *month;//月份

@property(nonatomic,strong)NSArray *detail;//详情

-(NSMutableArray<YMCaseDetailsDayInformationModel *> *)monthDetail;

@end
