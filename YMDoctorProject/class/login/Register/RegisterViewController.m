//
//  RegisterViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginModel.h"
#import "AggrementViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate,LoginModelProtocal>

@property (weak, nonatomic) IBOutlet UIButton *vertificationBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *vertification;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UITextField *surePassWord;
@property (weak, nonatomic) IBOutlet UIButton *sureRegisterBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureSaveBtn;
@property (nonatomic,strong)LoginModel *registModel ;

@property (nonatomic,assign)dispatch_queue_t queue ;

@end

@implementation RegisterViewController


- (dispatch_queue_t)queue {

    return  dispatch_queue_create("com.kupurui.requset", DISPATCH_QUEUE_CONCURRENT);
}

- (LoginModel *)registModel {
    if (!_registModel) {
        
        _registModel = [LoginModel new];
        _registModel.delegate = self ;
        
    }
    return _registModel ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.title = @"用户注册";
    [_sureSaveBtn setImage:[UIImage imageNamed:@"login_unselected_imag"] forState:UIControlStateNormal];
    [_sureSaveBtn setImage:[UIImage imageNamed:@"login_selectedSave"] forState:UIControlStateSelected];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO ;
}

//获取短信验证码
- (IBAction)click_get_vertificationCode_event:(id)sender {
    if ([_phoneNumber.text length] != 11) {
        [self alertViewShow:@"请输入正确的手机号格式"];
        return ;
    }
    UIButton *btn = (UIButton *)sender ;
    self.registModel.params = @{@"phone":_phoneNumber.text};
    dispatch_async(self.queue, ^{
        [self.registModel getVertification:nil];
    });
    [btn vertificationButtonClickedAnimationWithTimeStart:60
                                              beginString:btn.currentTitle
                                                    block:^{
                                                    
    }];
}

- (IBAction)click_showDoctor_ProtocalEvent:(id)sender {
    
    AggrementViewController *vc = [[UIStoryboard storyboardWithName:@"Aggrement" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
    vc.url = @"http://ys9958.com/api/index.php?act=demand&op=gvrp" ;
    [self.navigationController pushViewController:vc animated:YES];
}


//注册
- (IBAction)click_register_event:(id)sender{
    
    [self resignesponder];
    if (!_sureSaveBtn.selected) {
        [self alertViewShow:@"请先同意鸣医通用户协议"];
        return ;
    }
    if ([_phoneNumber.text length] == 0) {
        [self alertViewShow:@"请输入手机号码"];
        return ;
        //手机号不对
    }
    if ([_phoneNumber.text length] != 11) {
        [self alertViewShow:@"请输入正确的手机号码"];
        return ;
    }
    
   [self.registModel setParams:@{@"phone":_phoneNumber.text,
    @"password":_passWord.text,
    @"password_confirm":_surePassWord.text,
    @"code":_vertification.text,
    @"user_type":@(2)}];
    
    dispatch_async(self.queue, ^{
        
        [self.registModel registerUser:self.view];
    });
}

//失去焦点
- (void)resignesponder{
    
    
    [self.view endEditing:YES];
}

- (IBAction)click_aggree_protocal:(id)sender {
    UIButton *btn = sender ;
    btn.selected = !btn.selected ;
}


#pragma TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES ;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
}

//alertViewShow


#pragma Delegate
//成功
- (void)getDataSuccess {
    
    //注册成功
    NSDictionary *dic = @{@"seller_name":self.phoneNumber.text,
                          @"password":self.passWord.text};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSucces" object:dic userInfo:nil];
    self.registModel.params  = dic;
    [self.registModel userLogin:self.view];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
    window.rootViewController = vc ;

}

- (void)requestDataFailureWithReason:(NSString *)reason {
    
    [self alertViewShow:reason];
}


#pragma//KVO
- (void)keyBoardWillshow:(NSNotification*)notify {
    
    [super keyBoardWillshow:notify];
    CGFloat maxHeight = 0.0f ;
    for (UIView *view in self.view.subviews) {
        CGFloat max_Y = CGRectGetMaxY(view.frame);
        if (max_Y > maxHeight){
            maxHeight = max_Y ;
        }
    }
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGRect keyRect = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat overlaps = maxHeight + keyRect.size.height - HEIGHT ;
    if (overlaps > 0) {
        
    }
}

- (void)keyBoardWillHidden:(NSNotification *)notify {
    [super keyBoardWillHidden:notify];
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity ;
    }];
}

@end
