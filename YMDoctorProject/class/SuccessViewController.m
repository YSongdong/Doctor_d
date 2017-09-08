//
//  SuccessViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SuccessViewController.h"

@interface SuccessViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textaLabel;

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == withDraw) {
        self.title = @"提现成功";
        self.textaLabel.text = @"恭喜你提现成功";
    }else {
        self.title = @"添加成功";
        self.textaLabel.text = @"银行卡绑定成功";
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
       [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
     [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0) forBarMetrics:UIBarMetricsDefault];
}
- (void)leftButtonOperator {
  NSInteger count  = [self.navigationController.viewControllers count];
    UIViewController *vc = self.navigationController.viewControllers[count - 1 -2];
    [self.navigationController popToViewController:vc animated:YES];
}
@end
