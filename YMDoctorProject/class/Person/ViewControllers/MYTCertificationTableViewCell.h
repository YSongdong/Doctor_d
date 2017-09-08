//
//  MYTCertificationTableViewCell.h
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTCertificationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (weak, nonatomic) IBOutlet UITextField *realNameTF;

@property (weak, nonatomic) IBOutlet UIButton *sexBtn;

@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@property (nonatomic,copy) void (^CallBack)(NSString * str,NSInteger index);

@end
