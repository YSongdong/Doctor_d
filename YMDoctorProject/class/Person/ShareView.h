//
//  CertificationView.h
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView

@property (weak, nonatomic) IBOutlet UIButton *userShare;

@property (weak, nonatomic) IBOutlet UIButton *doctorShare;


+(instancetype)initWithXib;
-(void)show;
-(void)miss;



@end
