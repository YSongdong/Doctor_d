//
//  ContractViewController.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemandModel.h"
@interface ContractViewController : BaseViewController
@property (nonatomic,strong)DemandModel *model ;
@property (nonatomic,assign)BOOL haveConstract ; //判断是否签订了合同
@property (nonatomic,strong)NSString *contract_id ;

@end
