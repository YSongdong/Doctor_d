//
//  BindAlipayViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/22.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BindAlipayViewController.h"
#import "PersonViewModel.h"

@interface BindAlipayViewController ()<UITextFieldDelegate,PersonViewModelDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (nonatomic,strong)NSDictionary *params ;

@property (nonatomic,assign)NSInteger ways ;
@property (nonatomic,strong)PersonViewModel *viewModel ;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation BindAlipayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightButton];
    [self.rightButton setTitle:@"完成"];
    self.title = @"绑定支付宝";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}
- (void)requestData {
    
    
    dispatch_async(dispatch_queue_create("queueCreate",
                                         DISPATCH_QUEUE_CONCURRENT), ^{
        if ([self getMember_id]) {
            [self.viewModel getAlipayWithParams:@{@"member_id":[self getMember_id]}
                                        andView:self.view];
        }
    });
}

- (PersonViewModel *)viewModel {
    
    
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
        _viewModel.delegate = self ;
    }
    return _viewModel ;
}

//点击下一步的时候
- (void)rightButtonClickOperation{
    if (self.params && self.ways == 1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayNotification"
        object:self.params userInfo:nil];
        [self returnBack];
        return ;
    }
    if ([_nameTextField.text isEqualToString:@""]) {
        
        [self alertViewShow:@"请输入姓名"];
        return ;
    }
    if ([_accountTextField.text isEqualToString:@""]) {
        [self alertViewShow:@"请输入支付宝账号"];
        return ;
    }
    [self showAlert];
}

//提示用户
- (void)showAlert {

    [self alertViewControllerShowWithTitle:@"支付宝账号一旦绑定将不可修改"
                                   message:nil sureTitle:@"确认"
                               cancelTitle:@"取消" andHandleBlock:^(id value, NSString *error) {
        if (value) {
            [self bindAlipay];
        }
    }];
}
//绑定支付宝账号
- (void)bindAlipay {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]){
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    [dic setObject:_nameTextField.text forKey:@"memz_name"];
    [dic setObject:_accountTextField.text forKey:@"cardz_num"];
    [self.viewModel bindAlipayWithParams:dic andView:self.view];
}
- (void)operateSuccess:(NSString *)successTitle {
    
    [self alertViewShow:@"支付宝绑定成功"];
    if ([successTitle isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)successTitle  ;
        NSString *str = dic[@"id"];
        if (str) {
            self.params = @{@"mem_name":_nameTextField.text,
                            @"card_num":_accountTextField.text,
                            @"card_id":str};
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayNotification"
                                                           object:self.params userInfo:nil];
        self.view.userInteractionEnabled = NO ;
        [self performSelector:@selector(returnBack) withObject:nil afterDelay:2];

    }
}
//huo qu zhifu bao chenggong
- (void)requestDataSuccess:(id)resultValue {
    
    
    if ([resultValue isKindOfClass:[NSDictionary class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _nameTextField.text = resultValue[@"mem_name"];
            _accountTextField.text = resultValue[@"card_num"];
            _nameTextField.enabled = NO ;
            _accountTextField.enabled = NO ;
            self.ways = 1 ;
            self.params = resultValue ;
        });
    }
}
- (void)returnBack {
    
    UIViewController *vc = self.navigationController.viewControllers[2];
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)operateFailure:(NSString *)failureReason {
    [self alertViewShow:failureReason];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {

    [_nameTextField resignFirstResponder];
    [_accountTextField resignFirstResponder];
}

@end
