//
//  SuccessViewController.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    bankList,
    withDraw,
}SuccessType;
@interface SuccessViewController : BaseViewController

@property (nonatomic,assign)SuccessType type ;

@end
