//
//  ChangePassViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginModel.h"
@interface ChangePassViewController : BaseViewController

@property (nonatomic,strong)LoginModel *loginModel ;
@property (nonatomic,assign)NSInteger step ;

//type   0  密码修改   1 支付密码修改
@property (nonatomic,assign)NSInteger type;


- (void)finishFindpassOperate ;

- (void)getDataSuccess ;

@end
