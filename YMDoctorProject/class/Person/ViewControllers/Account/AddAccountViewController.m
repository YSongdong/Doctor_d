//
//  AddAccountViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AddAccountViewController.h"
#import "PersonViewModel.h"
#import "SuccessViewController.h"
@interface AddAccountViewController ()<UITextFieldDelegate,PersonViewModelDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *belongBankLabel; //所属银行
@property (nonatomic,strong)PersonViewModel *viewModel ;


@end

@implementation AddAccountViewController


- (PersonViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
        _viewModel.delegate = self ;
    }
    return _viewModel ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)addRightButton{
    [super addRightButton];
    [self.rightButton setTitle:@"下一步"];
}
- (void)rightButtonClickOperation{
    
    if (!self.nameLabel.text ||[[self.nameLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [self alertViewShow:@"请输入持卡人姓名"];
        return ;
    }
    if ([[self.cardNumberLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [self alertViewShow:@"请输入银行卡卡号"];
        return ;
    }
    if ([[self.belongBankLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [self alertViewShow:@"请输入银行名称"];
        return ;
    }
    NSDictionary *dic = @{@"member_id":[self getMember_id],
                          @"mem_name":self.nameLabel.text,
                          @"card_num":self.cardNumberLabel.text,
                          @"name":self.belongBankLabel.text};
    [self.viewModel addBankWithParams:dic andView:self.view];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES ;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_nameLabel resignFirstResponder];
    [_cardNumberLabel resignFirstResponder];
    [_belongBankLabel resignFirstResponder];
}
- (IBAction)click_showDoctor_protocal:(id)sender {
    
    
}


- (void)operateFailure:(NSString *)failureReason {
    
    [self alertViewShow:failureReason];
}

- (void)operateSuccess:(NSString *)successTitle {
    [self performSegueWithIdentifier:@"successIdentifier" sender:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"successIdentifier"]) {
        SuccessViewController *vc = segue.destinationViewController ;
        vc.type = bankList ;
    }
}

@end
