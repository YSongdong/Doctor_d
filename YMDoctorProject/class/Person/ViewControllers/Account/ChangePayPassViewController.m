//
//  ChangePayPassViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChangePayPassViewController.h"

@interface ChangePayPassViewController ()

@end

@implementation ChangePayPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付密码修改";
}



- (void)rightButtonClickOperation {
    
    UITextField *vertiTextfield = [self.view viewWithTag:1000];
    UITextField *newpass = [self.view viewWithTag:1001];
    UITextField *surePass = [self.view viewWithTag:1002];
    if (vertiTextfield.text.length == 0) {
        [self alertViewShow:@"请输入验证码"];
        return ;
    }
    if (newpass.text.length < 6) {
        [self alertViewShow:@"请输入至少6位密码"];
        return ;
    }
    if (surePass.text.length == 0) {
        [self alertViewShow:@"请输入确认密码"];
        return ;
    }if (![surePass.text isEqualToString:newpass.text]) {
        [self alertViewShow:@"两次密码不一致请重新输入"];
        return ;
    }
     self.step = 2 ;
    NSDictionary *dic = @{@"member_id":[self getMember_id],
                          @"code":vertiTextfield.text,
                          @"member_paypwd":newpass.text,
                          @"member_paypwds":surePass.text};
    self.loginModel.params = dic ;
    dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT), ^{
        [self.loginModel changePayPass:self.view];
    });
}

- (void)getDataSuccess {
    if (self.step == 1) {
        [super getDataSuccess];
    }
    else {
        [self alertViewShow:@"支付密码修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

@end
