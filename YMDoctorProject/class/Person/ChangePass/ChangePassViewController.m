//
//  ChangePassViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ChangePassViewController.h"
#import "CommonTextField.h"
#import "LoginViewController.h"

@interface ChangePassViewController ()<UITextFieldDelegate,LoginModelProtocal>

@property (nonatomic,strong)NSMutableArray *dataList ;
@property (nonatomic,strong)UIButton *vertificationBtn ; //获取验证码

@property (nonatomic,strong)NSMutableArray *placeHoldersArr;

@end

@implementation ChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.placeHoldersArr = [NSMutableArray new];
    
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (LoginModel *)loginModel {
    if (!_loginModel) {
        _loginModel = [LoginModel new];
        _loginModel.delegate = self ;
    }
    return _loginModel ;
}

- (void)viewWillLayoutSubviews {
    
    for (int i = 0; i < [_dataList count]; i ++) {
        CommonTextField *textField = (CommonTextField *)_dataList[i];
        textField.width = WIDTH ;
        textField.x = 0 ;
        if (i == 0) {
            _vertificationBtn.centerY = textField.centerY ;
            _vertificationBtn.centerX = WIDTH - 10 - _vertificationBtn.width/2 ;
        }
    }
}

- (void)setup{
    
    [self addRightButton];
    [self.rightButton setTitle:@"完成"];
    
    NSArray *titles = @[@"验证码",@"密码",@"确认密码"];

    if (self.type == 0) {
        
        //密码
        self.placeHoldersArr = @[@"请输入手机信息验证码",@"请输入6-22位字符",@"请再次输入密码"];
        
    }else{
        
        //支付密码
        self.placeHoldersArr = @[@"请输入手机信息验证码",@"请输入6位数字密码",@"请再次输入密码"];
    }
    
    _dataList = [NSMutableArray array];
    for (int i = 0; i < [titles count]; i ++) {
        
        CommonTextField *textField = [[CommonTextField alloc]initWithPosition_Y:10  + (i * 60)  andHeight:50];
        [self.view addSubview:textField];
        textField.tag = 1000 + i;
        textField.title = titles[i];
        textField.placeHolder = self.placeHoldersArr[i];
        textField.titleFont = [UIFont systemFontOfSize:16];
        textField.delegate = self ;
        [textField addLine];
        
        if (i == 1 || i == 2) {
            
            textField.secureTextEntry = YES ;
        }
        [_dataList addObject:textField];
    }
    _vertificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_vertificationBtn setTitleColor:[UIColor colorWithRGBHex:0x0091ff] forState:UIControlStateNormal];
    [_vertificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _vertificationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_vertificationBtn];
    [_vertificationBtn sizeToFit];
    [_vertificationBtn addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside ];
}

//完成
- (void)rightButtonClickOperation{
    
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
                          @"password":newpass.text,
                          @"password_confirm":surePass.text};
    self.loginModel.params = dic ;
    dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT), ^{
        [self.loginModel changePass:self.view];
    });
}

//获取验证码
- (void)didClick {
    
    __weak typeof(self)weakSelf = self ;
    self.step = 1 ;
    [_vertificationBtn vertificationButtonClickedAnimationWithTimeStart:60 beginString:@"获取验证码" block:^{
    }];
    weakSelf.loginModel.params = @{@"member_id":[self getMember_id]};
    [weakSelf.loginModel getVertificationchangePass];
}

- (void)requestDataFailureWithReason:(NSString *)reason {
    [self alertViewShow:reason];
}

- (void)getDataSuccess {
    
    if (_step ==1) {
        
        [self alertViewShow:@"验证码发送成功"];
        
    }else if (_step == 2) {
        
        //修改密码
        [self alertViewShow:@"修改密码成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];

            // 重新登录
//                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//                LoginViewController *login = [[LoginViewController alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
//                window.rootViewController = nav ;
        });
        
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES ;
}

@end
