//
//  LoginBtn.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/3/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnClickBlock)(BOOL selected);

@interface LoginBtn : UIButton

@property (nonatomic,strong)CAShapeLayer *roundlayer ;

@property (nonatomic,copy)BtnClickBlock block ;


@end
