//
//  YMDepartmentModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDepartmentModel.h"
//#import <NSObject+YYModel.h>


@implementation YMDepartmentModel

-(NSMutableArray<YMDepartmentChildModel *> *)departmentChild{
    _departmentChild = [NSMutableArray array];
    for (NSDictionary *dic in __child) {
        NSMutableDictionary *mudic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        [mudic setObject:dic[@"id"] forKey:@"chieldiD"];
        [_departmentChild addObject:[YMDepartmentChildModel modelWithJSON:mudic]];
    }
    return _departmentChild;
}

@end
