//
//  LoginViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPassViewController.h"
#import "LoginModel.h"
#import "LoginBtn.h"
#import <RongIMKit/RongIMKit.h>
#import "KRWebViewController.h"

static NSString *const FirstEnterTheHomepage = @"FirstEnterTheHomepage";

@interface LoginViewController ()<UITextFieldDelegate,LoginModelProtocal>

@property (nonatomic,strong)LoginModel *loginModel ;

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic,strong)LoginBtn *messageBtn ;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic,strong)UIButton *rightViewBtn ;

@property (nonatomic,assign)BOOL vertiLogin ;

@end

@implementation LoginViewController

- (void)dealloc {
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"UserNickName" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"longinSuccess" object:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self inputWebView];
}

- (UIButton *)rightViewBtn {
    if (!_rightViewBtn) {
        _rightViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightViewBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _rightViewBtn.frame = CGRectMake(0, 0, 75, 25);
        [_rightViewBtn setTitleColor:[UIColor bluesColor] forState:UIControlStateNormal];
        [_rightViewBtn setTitle:13];
        [_rightViewBtn addTarget:self action:@selector(getVeritification_Event) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightViewBtn ;
    
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _messageBtn.x = CGRectGetMaxX(_messageLabel.frame)+ 5;
    _messageBtn.y = _messageLabel.y ;
    _messageBtn.hidden = NO ;
}

- (LoginModel *)loginModel {
    if (!_loginModel) {
        _loginModel = [LoginModel new];
        _loginModel.delegate= self ;
    }
    return _loginModel ;
}

- (void)setup:(UITextField *)textField {
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.layer.borderWidth = 0.5 ;
    textField.layer.cornerRadius = 5 ;
    textField.layer.masksToBounds = YES;
    textField.delegate = self ;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    [self setup:_userName];
    if ([self  getUserNickName]) {
        _userName.text = [self getUserNickName];
    }
    _messageBtn = [[LoginBtn alloc]initWithFrame:CGRectMake(0, 0,50, 20)];
    _messageBtn.hidden = YES ;
    [self.view addSubview:_messageBtn];
    
    __weak typeof(self)weakSelf = self ;
    _messageBtn.block = ^(BOOL selected) {
        //选中
        if (selected) {
            
            weakSelf.userName.text = nil ;
            weakSelf.userName.placeholder = @"手机号";
            weakSelf.password.placeholder = @"验证码";
            weakSelf.password.rightView = weakSelf.rightViewBtn;
            weakSelf.password.rightViewMode = UITextFieldViewModeAlways ;
            weakSelf.password.secureTextEntry = NO ;
            weakSelf.password.keyboardType = UIKeyboardTypeNumberPad ;
            weakSelf.password.text = nil ;
            weakSelf.vertiLogin = YES ;
        }
        else {
            weakSelf.userName.placeholder = @"用户名/手机号";
            weakSelf.password.placeholder = @"密码";
            weakSelf.vertiLogin =NO;
            weakSelf.password.secureTextEntry = YES ;
            weakSelf.password.keyboardType = UIKeyboardTypeDefault ;
            weakSelf.password.text = nil ;
            weakSelf.password.rightView = nil;
        }
    };

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccessOperator:) name:@"registerSucces" object:nil];
    [self setup:_password];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.userName.text = [self getUserNickName];
}
- (void)resignResponseBounder {
    
    if ([_userName isFirstResponder]) {
        [_userName resignFirstResponder];
    }
    if ([_password isFirstResponder]) {
        [_password resignFirstResponder];
    }
}

- (IBAction)forgetPasswordEvent:(id)sender {
    [self resignResponseBounder];
    FindPassViewController *find = [[FindPassViewController alloc]init];
    [self.navigationController pushViewController:find animated:YES];
}


- (IBAction)login_event:(id)sender {
    
    [self resignResponseBounder];
    
    if ([_userName.text isEqualToString:@""]) {
        
        return ;
    }
    if ([_password.text isEqualToString:@""]) {
        
        return ;
    }

    NSString *type ;
    
    if (self.vertiLogin) {
        
        type = @"2";
        
    }else{
        
        type = @"1";
    }
    
    [self.loginModel setParams:@{@"seller_name":_userName.text,
    @"password":_password.text,
    @"type":type,@"user_type":@(2)
    }];
        
    [self login];
}


- (void)login {
    
    dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT), ^{
        [self.loginModel userLogin:self.view];
    });
}


//注册
- (IBAction)register_event:(id)sender {
    [self resignResponseBounder];
       RegisterViewController *gister = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:gister animated:YES];
}

- (void)registerSuccessOperator:(NSNotification *)notify {
    
    self.loginModel.params = notify.object ;
    [self login];
}


//获取验证码
- (void)getVeritification_Event {
    
    if (self.userName.text.length == 0) {
        
        [self alertViewShow:@"请输入手机号码"];
        return ;
    }
    if (self.userName.text.length > 0 ) {
        self.loginModel.params = @{@"phone":self.userName.text};
    }
    [self.loginModel loginGetVertification:nil andCommpleteBlock:^(id data, NSString *error) {
        
        if (error) {
            
            [self alertViewShow:error];
        }else {
            
            [self.rightViewBtn vertificationButtonClickedAnimationWithTimeStart:60
        beginString:@"获取验证码" block:^{
        
        }];
      }
   }];
}

//delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
        return YES ;
}



//observ

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
        [UIView animateWithDuration:duration animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -overlaps - 10);
        }];
    }
}

- (void)keyBoardWillHidden:(NSNotification *)notify {
    
    [super keyBoardWillHidden:notify];
      CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
  [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity ;
    }];
}

#pragma mark---LoginModelelegate

//
- (void)getDataSuccess {
    
    [self setUserNickName:self.userName.text];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:FirstEnterTheHomepage]){
        
        NSNotification *notification = [NSNotification notificationWithName:@"longinSuccess" object:nil userInfo:nil];

        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }else{
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
        window.rootViewController = vc ;
    }
}

- (void)requestDataFailureWithReason:(NSString *)reason {
    [self alertViewShow:reason];
}

-(void)inputWebView{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"inputadvertisingClick"]) {
        
        NSString *strUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"webUrl"];
        KRWebViewController *webVC = [[KRWebViewController alloc]init];
        webVC.saoceUrl = strUrl;
        [self.navigationController pushViewController:webVC animated:YES];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inputadvertisingClick"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}


@end
