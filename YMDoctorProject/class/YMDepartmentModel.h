//
//  YMDepartmentModel.h
//  doctor_user
//
//  Created by 黄军 on 17/5/26.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMDepartmentChildModel.h"

@interface YMDepartmentModel : NSObject

@property(nonatomic,copy)NSString *departemID;//部门id
@property(nonatomic,copy)NSString *ename;//科室
@property(nonatomic,copy)NSString *disorder; //大类组
@property(nonatomic,strong)NSArray *_child; //科室

@property(nonatomic,strong)NSMutableArray<YMDepartmentChildModel *> *departmentChild;

@end
