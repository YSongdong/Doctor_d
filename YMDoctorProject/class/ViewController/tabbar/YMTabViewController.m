//
//  YMTabViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YMTabViewController.h"
#import "LoginViewController.h"
#import "MessageViewController.h"
@interface YMTabViewController ()


@end


@implementation YMTabViewController


- (void)dealloc {

   [[NSNotificationCenter defaultCenter]removeObserver:self name:notExitStoreIDNotification object:nil];
   [[NSNotificationCenter defaultCenter]removeObserver:self name:notExitStoreIDNotification object:nil];
}


- (void)viewDidLoad {
    
     [super viewDidLoad];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(noStoreIDEvent) name:notExitStoreIDNotification object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(userMemberIDAlertOperator) name:notExitMemberIDNotification object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.selectedViewController beginAppearanceTransition:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {

    
    [self.selectedViewController endAppearanceTransition];
    
    
    //
    
//    LoginViewController *login = [[LoginViewController alloc]init];
//     UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//    [self presentViewController:nav animated:YES completion:^{
//    }];

}



- (void)viewWillDisappear:(BOOL)animated {
}

- (void)noStoreIDEvent {
    
    NSLog(@"去实名认证吧");
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示"    message:@"您还没有实名认证 不能进行投标"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertVC addAction:action];
    
//    if (cancelTitle != nil) {
//        UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            commplete(nil,@"0");
//        }];
//        [alertVC addAction:action1];
//    }
    [self presentViewController:alertVC animated:YES completion:nil];

    
    //去实名认证
    
//        LoginViewController *login = [[LoginViewController alloc]init];
//         UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//        [self presentViewController:nav animated:YES completion:^{
//        }];    
}
- (void)userMemberIDAlertOperator {
    
    return ;
}

@end
