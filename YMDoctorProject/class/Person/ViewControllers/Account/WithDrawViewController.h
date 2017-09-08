//
//  WithDrawViewController.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^returnBankNameBlock)(id  value);


@interface WithDrawViewController : BaseViewController

@property (nonatomic,assign)NSInteger ways ;//推出路径

@property (nonatomic,copy)returnBankNameBlock block ;

- (void)choiceBankName:(returnBankNameBlock)block ;

@end
