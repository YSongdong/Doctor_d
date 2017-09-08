//
//  PhoneView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^VertificationClickBlock)();

typedef void(^DrawWithMessageBlock)(NSString *code);


typedef void(^DrawWithPayPassBlock)(NSString *payPass); //设置支付密码

typedef void (^payWithPayPassBlock)(NSString *paypass);

@interface PhoneView : UIView

@property (nonatomic,copy)VertificationClickBlock block ;

@property (nonatomic,copy)DrawWithMessageBlock messgeBlock ;
@property (nonatomic,copy)DrawWithPayPassBlock setPaypassBlock ;
@property (nonatomic,copy)payWithPayPassBlock paypassBlock ;
@property (nonatomic,assign)NSString * havePayPass ;

+(PhoneView *)phoneViewFromXIBWithTitle:(NSString *)title ;

- (void)disappearView ;


- (void)showView  ;
@end
