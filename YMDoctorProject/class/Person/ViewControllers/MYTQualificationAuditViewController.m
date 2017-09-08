//
//  MYTQualificationAuditViewController.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/7/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTQualificationAuditViewController.h"

@interface MYTQualificationAuditViewController ()

@end

@implementation MYTQualificationAuditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)knowBtnClick:(UIButton *)sender {
   
   // UIViewController *vc = self.navigationController.viewControllers[1];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
