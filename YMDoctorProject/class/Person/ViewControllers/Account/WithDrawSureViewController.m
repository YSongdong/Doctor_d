//
//  WithDrawSureViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "WithDrawSureViewController.h"
#import "PersonViewModel.h"
#import "WithDrawViewController.h"
#import "DemandModel.h"
#import "PassView.h"
#import "PhoneView.h"
#import <objc/runtime.h>
#import "SuccessViewController.h"
@interface WithDrawSureViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn; //确认提现按钮
@property (weak, nonatomic) IBOutlet UILabel *feeLabel; //手续费
@property (weak, nonatomic) IBOutlet UITextField *moneyTextfield;

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIButton *bankName;
@property (nonatomic,strong)PersonViewModel *viewModel ;
@property (nonatomic,strong)NSString *bankString;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@end
@implementation WithDrawSureViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"alipayNotification" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(alipayChoiced:) name:@"alipayNotification" object:nil];
}


- (PersonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
    }
    return _viewModel ;
}

- (void)setup {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]) {
        [dic setObject:@"member_id" forKey:[self getMember_id]];
    }
    self.bankString = @"选择卡号";
    [self.viewModel getBankListWithParams:dic andView:_backGroundView];
    _moneyTextfield.delegate = self ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    if ([textField.text floatValue] - [self.money floatValue] < 0) {
        [self alertViewShow:@"余额不足"];
    }
    return YES ;
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.viewModel removeObserver:self forKeyPath:@"billLists"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
      [self.viewModel addObserver:self forKeyPath:@"billLists" options:NSKeyValueObservingOptionNew context:nil];
     self.moneyTextfield.placeholder = @"请输入提现金额";
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                          NSForegroundColorAttributeName:[UIColor textLabelColor]};
    NSMutableAttributedString *attr  = [[NSMutableAttributedString alloc]initWithString:@"请输入提现金额" attributes:dic];
    self.moneyTextfield.attributedPlaceholder = attr ;
    self.feeLabel.hidden = YES ;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.sureBtn.layer.cornerRadius = 4 ;
    self.sureBtn.layer.masksToBounds = YES ;
    self.bankName.tintColor = [UIColor whiteColor];
}

-(NSMutableAttributedString *)attributeStringWithStr:(NSString *)str{
    
    NSTextAttachment *attch = [[NSTextAttachment alloc]init];
    attch.image = [UIImage imageNamed:@"next1.png"];
    attch.bounds = CGRectMake(0, 0, 15, 15);
   NSAttributedString *attribte = [NSAttributedString attributedStringWithAttachment:attch];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [att setAttributes:dic range:NSMakeRange(0, att.length)];
    [att appendAttributedString:attribte];
     return att ;
}

- (void)setBankString:(NSString *)bankString {
    _bankString = bankString ;
      [self.bankName setAttributedTitle:[self attributeStringWithStr:bankString] forState:UIControlStateNormal];
}
-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"billLists"]) {
        DemandModel *model = [self.viewModel.billLists firstObject];
        if (model.name && model.card_num) {
            NSString *str = [model.card_num substringFromIndex:model.card_num.length - 4];
            self.bankString = [model.name stringByAppendingFormat:@"(%@)",str];
            }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBankListIdentifier"]) {

        WithDrawViewController *vc = segue.destinationViewController ;
        __weak typeof(self)weakSelf = self ;
        vc.ways = 1 ;
        [vc choiceBankName:^(id value) {
            if ([value isKindOfClass:[DemandModel class]]) {
                DemandModel *model = (DemandModel *)value ;
                weakSelf.bankNameLabel.text = model.name ;
                objc_setAssociatedObject(self, "card_idKey", model.card_id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                NSString *str= [model.card_num substringFromIndex:model.card_num.length - 4];
             self.bankString =  [@"" stringByAppendingFormat:@"(....%@)",str];
            }
        }];
    }
}
//选择支付宝提现
- (void)alipayChoiced:(NSNotification *)notify {
    
    
     NSDictionary *dic = notify.object ;
    objc_setAssociatedObject(self, "card_idKey", dic[@"card_id"], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.bankString = dic[@"card_num"];
    self.bankNameLabel.text = dic[@"mem_name"];
    
    NSLog(@"%@",dic);
    
    
}
- (IBAction)drawEvent:(id)sender {


    [self.view endEditing:YES];
    
    if (_moneyTextfield.text.length == 0) {
        [self alertViewShow:@"请输入提现金额"];
        return ;
    }
    PhoneView *phoneView = [PhoneView phoneViewFromXIBWithTitle:@"请输入手机验证码"];
    [phoneView showView ];
    phoneView.havePayPass = self.havePayPass ;
    
    //yanzhengma
    __weak typeof(self)weakSelf = self ;
    phoneView.block = ^() {
        NSDictionary *dic = @{@"member_id":[self getMember_id]};
        [self.viewModel getVertificationWithParams:dic
                                    andReturnBlock:^(id status) {
                    [self alertViewShow:status];
        }];
    };
    //短信提现
    
    __weak typeof(phoneView)weakPhone = phoneView ;
    
    phoneView.messgeBlock = ^(NSString * code){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ([weakSelf getMember_id]) {
            [dic setObject:[weakSelf getMember_id] forKey:@"member_id"];
        }if (objc_getAssociatedObject(weakSelf, "card_idKey")) {
            id value = objc_getAssociatedObject(weakSelf, "card_idKey");
            [dic setObject:value forKey:@"pdc_bank_id"];
        }
        
        [dic setObject:weakSelf.moneyTextfield.text forKey:@"pdc_amount"];
        [dic setObject:code forKey:@"code"];
        dispatch_async(dispatch_queue_create("", DISPATCH_QUEUE_SERIAL), ^{
            
            [weakSelf.viewModel drawMoneyWithParams:dic
                                        andView:weakSelf.view
                                             andUrl:MESSAGE_DRAW_URL
                                  andCommpleteBlock:^(id status) {
                                      [weakPhone disappearView];

                                      if ([status isEqual:@(1)]) {
                                          
                                          [self successViewController];
                                          [weakSelf alertViewShow:@"提现成功"];
                                      }
                                      else {
                                          [weakSelf alertViewShow:status];
                                      }
                                      
                    }];
            
        });
        
        
    };
    
    phoneView.setPaypassBlock = ^(id value){
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if ([self getMember_id]) {
            [dic setObject:[self getMember_id] forKey:@"member_id"];
        }
        [dic setObject:value forKey:@"member_paypwd"];
        [weakSelf.viewModel setPayPassWithParams:dic
                                  andReturnBlock:^(id status) {
                         
                                      //cheng gong
                                      if ([status isEqual:@(1)]) {
                                          NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
                                          if ([weakSelf getMember_id]) {
                                              [mudic setObject:[weakSelf getMember_id] forKey:@"member_id"];
                                          }if (objc_getAssociatedObject(weakSelf, "card_idKey")) {
                                              id value = objc_getAssociatedObject(weakSelf, "card_idKey");
                                              [mudic setObject:value forKey:@"pdc_bank_id"];
                                          }
                                          [mudic setObject:weakSelf.moneyTextfield.text forKey:@"pdc_amount"];
                                          [mudic setObject:value forKey:@"member_paypwd"];
                                          [weakSelf.viewModel drawMoneyWithParams:mudic andView:self.view andUrl:ACCOUNT_DRAW_URL andCommpleteBlock:^(id status) {
                                              [weakPhone disappearView];

                                              if ([status isEqual:@(1)]) {
                                                  //tixianchenggong
                                                  [self alertViewShow:@"提现成功"];
                                                  [self successViewController];
                                                  
                                              }
                                              else {
                                                  [weakSelf alertViewShow:status];
                                              }
                                          }];
                                          
                                      }else {
                                          
                                          [self alertViewShow:status];
                                      }
                                      
        }];
    };
    
    phoneView.paypassBlock = ^(NSString *value) {
        
        NSMutableDictionary *mudic = [NSMutableDictionary dictionary];
        if ([weakSelf getMember_id]) {
            [mudic setObject:[weakSelf getMember_id] forKey:@"member_id"];
        }if (objc_getAssociatedObject(weakSelf, "card_idKey")) {
            id value = objc_getAssociatedObject(weakSelf, "card_idKey");
            [mudic setObject:value forKey:@"pdc_bank_id"];
        }
        [mudic setObject:weakSelf.moneyTextfield.text forKey:@"pdc_amount"];
        [mudic setObject:value forKey:@"member_paypwd"];
        [weakSelf.viewModel drawMoneyWithParams:mudic andView:self.view andUrl:ACCOUNT_DRAW_URL andCommpleteBlock:^(id status) {
            [weakPhone disappearView];

            if ([status isEqual:@(1)]) {
                [self alertViewShow:@"提现成功"];
                [self successViewController];
            }
            else {
                [weakSelf alertViewShow:status];
            }
        }];

        
    };
}

- (void)successViewController {

    SuccessViewController *vc = [[UIStoryboard storyboardWithName:@"Success"
                bundle:nil]instantiateViewControllerWithIdentifier:@"SuccessViewController"];
      vc.type = withDraw ;
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
