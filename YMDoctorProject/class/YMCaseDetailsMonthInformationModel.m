//
//  YMCaseDetailsMonthInformationModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/22.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseDetailsMonthInformationModel.h"
//#import <NSObject+YYModel.h>


@implementation YMCaseDetailsMonthInformationModel


-(NSMutableArray<YMCaseDetailsDayInformationModel *> *)monthDetail{
    NSMutableArray<YMCaseDetailsDayInformationModel *> *returnDetail = [NSMutableArray array];
    for (NSDictionary *dic in _detail) {
        [returnDetail addObject:[YMCaseDetailsDayInformationModel yy_modelWithDictionary:dic]];
    }
    return returnDetail;
}

@end
