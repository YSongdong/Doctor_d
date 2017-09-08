//
//  BaseViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController



- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = Global_mainBackgroundColor ;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    [self leftNavigationBar];
    [self addObservc];
}

- (void)leftNavigationBar {
    
      self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonOperator)];
}

- (void)leftButtonOperator {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addObservc {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillshow:) name:UIKeyboardWillShowNotification object:nil];    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)returnLastPage {
    
    
}

- (void)keyBoardWillshow:(NSNotification *)notify {
    
}

- (void)keyBoardWillHidden:(NSNotification *)notify {
    
}
- (void)addRightButton {
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClickOperation)];
    self.navigationItem.rightBarButtonItem = myButton;
    self.rightButton = myButton ;
}

- (void)rightButtonClickOperation {
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)alertViewShow:(NSString *)alertString {
    AlertView *alert = [AlertView alertViewWithSuperView:self.view andData:alertString];
    [alert show];
}


- (void)alertViewControllerShowWithTitle:(NSString *)title message:(NSString *)message sureTitle:(NSString *)sureTitle cancelTitle:(NSString *) cancelTitle andHandleBlock:(void(^)(id  value,NSString  *error))commplete {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        commplete(@(1),nil);
        
    }];
    [alertVC addAction:action];

    if (cancelTitle != nil) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            commplete(nil,@"0");
        }];
        [alertVC addAction:action1];
    }
       [self presentViewController:alertVC animated:YES completion:nil];
    
}




@end
