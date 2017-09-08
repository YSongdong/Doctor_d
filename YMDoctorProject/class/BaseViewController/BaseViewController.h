//
//  BaseViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic,strong)UIBarButtonItem *rightButton;

- (void)rightButtonClickOperation  ;

// left btn
- (void)leftButtonOperator ;
- (void)addRightButton  ;

- (void)keyBoardWillshow:(NSNotification *)notify ;

- (void)leftNavigationBar;

- (void)keyBoardWillHidden:(NSNotification *)notify ;
- (void)alertViewShow:(NSString *)alertString ;


- (void)alertViewControllerShowWithTitle:(NSString *)title message:(NSString *)message sureTitle:(NSString *)sureTitle cancelTitle:(NSString *) cancelTitle andHandleBlock:(void(^)(id  value,NSString *error))commplete ;


@end
