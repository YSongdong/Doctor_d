//
//  QualificationViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface QualificationViewController : BaseViewController

@property (nonatomic,assign)BOOL isAuthen ;

@property (nonatomic,strong)NSMutableDictionary *params ;

@property (nonatomic,strong)NSArray *images ;


@property (strong,nonatomic)NSString *status;

@end
