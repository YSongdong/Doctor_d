//
//  FindPassViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "FindPassViewController.h"
#import "CommonTextField.h"
#import "LoginModel.h"
@interface FindPassViewController ()<UITextFieldDelegate,LoginModelProtocal>

@property (nonatomic,strong)NSMutableArray *dataList ;
@property (nonatomic,strong)UIButton *vertificationBtn ; //获取验证码
@property (nonatomic,strong)LoginModel *findModel;
@property (nonatomic,assign)NSInteger step ;

@end

@implementation FindPassViewController

- (LoginModel *)findModel {
    if (!_findModel) {
        
        _findModel = [[LoginModel alloc]init];
        _findModel.delegate = self ;
    }
    return _findModel ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor colorWithRGBHex:0xf0eff5] ;
    [self setup];
    self.title = @"找回密码";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO ;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
- (void)viewWillLayoutSubviews {
    
    for (int i = 0; i < [_dataList count]; i ++) {
        CommonTextField *textField = (CommonTextField *)_dataList[i];
        textField.width = WIDTH ;
        textField.x = 0 ;
        if (i == 1) {
            _vertificationBtn.centerY = textField.centerY ;
            _vertificationBtn.centerX = WIDTH - 20 - _vertificationBtn.width/2 ;
        }
        
    }
}

- (void)setup{
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishFindpassOperate)];
    self.navigationItem.rightBarButtonItem = myButton;
    
    NSArray *titles = @[@"手机号",@"验证码",@"新密码",@"确认密码"];
    NSArray *placeHolders =@[@"请输入您的手机号码",@"发送验证码",@"请输入6-20位新密码",@"请输入确认密码"];
    _dataList = [NSMutableArray array];
    for (int i = 0; i < [titles count]; i ++) {
        CommonTextField *textField = [[CommonTextField alloc]initWithPosition_Y:64 + 20  + (i * 54)  andHeight:44];
        [self.view addSubview:textField];
        textField.tag = 1000 + i;
        textField.title = titles[i];
        textField.placeHolder = placeHolders[i];
        textField.titleFont = [UIFont systemFontOfSize:15];
        textField.delegate = self ;
        [textField addLine];
        if (i == 2 || i == 3) {
            textField.secureTextEntry = YES ;
        }

        [_dataList addObject:textField];
    }
    _vertificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_vertificationBtn setTitleColor:[UIColor colorWithRGBHex:0x0091ff] forState:UIControlStateNormal];
    [_vertificationBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _vertificationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_vertificationBtn];
    [_vertificationBtn sizeToFit];
    [_vertificationBtn addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside ];
}


/*
 
 名称	类型	描述	必填
 phone	varchar	手机号	是
 code	int	短信验证码	是
 password	varchar	密码	是
 password_confirm	varchar	确认密码	是

 */

//完成
- (void)finishFindpassOperate{
    
    self.step = 2 ;
    [self resignResponder];
    CommonTextField *phone = [self.view viewWithTag:1000];
    CommonTextField *vertifi = [self.view viewWithTag:1001];
    CommonTextField *pass = [self.view viewWithTag:1002];
    CommonTextField *surePass = [self.view viewWithTag:1003];
    if ([phone.text length] != 11) {
        [self alertViewShow:@"请输入正确的手机号格式"];
        return ;
    }
    if (!vertifi.text || vertifi.text.length < 1) {
        [self alertViewShow:@"请输入手机验证码"];
        return ;
    }
    if (pass.text.length < 6) {
        [self alertViewShow:@"密码长度不能小于6位"];
        return ;
    }
    if (!surePass.text) {
        [self alertViewShow:@"请输入确认密码"];
        return ;
    }
    if (![surePass.text isEqualToString:pass.text]) {
        [self alertViewShow:@"两次输入的密码不一致,请重新输入"];
        surePass.text = @"";
        return  ;
    }
    [self.findModel setParams:@{@"phone":phone.text,
                               @"code":vertifi.text,
                               @"password":pass.text,
                               @"password_confirm":surePass.text}];
    [self.findModel findPass:self.view];
}


- (void)resignResponder {
    for (UIView *view in self.dataList) {
        if ([view isKindOfClass:[CommonTextField class]]) {
            if ([view isFirstResponder]) {
                [view resignFirstResponder];
            }
        }
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    [self resignResponder];
}

- (void)didClick {

    NSLog(@"%s",__func__);
    
    [self resignResponder];
    
    CommonTextField *textField = [_dataList firstObject];
    if ([textField.text length] != 11) {
        [self  alertViewShow:@"请输入正确的手机号格式"];
        return ;
    }
    self.step = 1 ;
    self.findModel.params = @{@"phone":textField.text};
    [self.findModel getVeritificationCodeInFindViewController];
    [_vertificationBtn vertificationButtonClickedAnimationWithTimeStart:60 beginString:@"获取验证码" block:^{        
    }];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES ;
}

//成功
- (void)getDataSuccess {
    
    if (self.step ==1 ) {
        [self alertViewShow:@"验证码已发送成功"];
    }
    if (self.step ==2) {

        //新密码 确认密码
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)requestDataFailureWithReason:(NSString *)reason {
    [self alertViewShow:reason];
}

@end
