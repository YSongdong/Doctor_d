//
//  PhoneView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PhoneView.h"
#import "PassView.h"

@interface PhoneView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rigtBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *vertificationTextField;
@property (weak, nonatomic) IBOutlet UIButton *vertificationBtn;
@property (weak, nonatomic) IBOutlet UIButton *usePassBtn;
@property (nonatomic,strong)PassView *passView ;


@end


@implementation PhoneView
+(PhoneView *)phoneViewFromXIBWithTitle:(NSString *)title{
    PhoneView *phone = [[[NSBundle mainBundle]loadNibNamed:@"PhoneView"
                                                       owner:nil options:nil] firstObject];
    phone.titleLabel.text = title ;
    phone.frame = CGRectMake(0, HEIGHT, WIDTH, 450 *VerticalRatio());
    return phone ;
}
- (void)awakeFromNib {
    
    [super awakeFromNib];
    _vertificationTextField.delegate = self ;
    _backView.layer.cornerRadius = 10 ;
    _backView.layer.masksToBounds = YES ;
    _backView.layer.borderColor = [UIColor colorWithRGBHex:0xDEDFE0].CGColor;
    _backView.layer.borderWidth = 1 ;

}
- (void)showView {

    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
    UIView *view = [[UIView alloc]init];
    view.frame = window.bounds ;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenSelfView:)];
    [view addGestureRecognizer:gesture];
    
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [window addSubview:view];
    [view addSubview:self];
    [self showAnimation];
}
- (void)showAnimation {
    
    [self.vertificationTextField resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.height);
    } completion:^(BOOL finished) {
        [self.vertificationTextField becomeFirstResponder];
    }];
}
- (void)hiddenSelfView:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.superview];
    if (!CGRectContainsPoint(self.frame, point) &&
        !CGRectContainsPoint(self.passView.frame, point)) {
        [self disappearView];
    }
  if ([self.vertificationTextField isFirstResponder] ||
      [self.passView.PassTextField isFirstResponder]) {
      [self.superview endEditing:YES];
    }
}

- (void)disappearView {
    
    UIView *view = self.superview ;
    [self removeFromSuperview];
    self.passView = nil ;
    [view removeFromSuperview];
    view = nil ;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES ;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    if (range.location >= 6) {
        return NO ;
    }
    return YES ;
}

//send vertification
- (IBAction)sendVertification:(id)sender {
    UIButton *btn = (UIButton *)sender ;
    
    //fasong yanzhengma
    self.block() ;
    [btn vertificationButtonClickedAnimationWithTimeStart:60
                                              beginString:@"发送验证码" block:^{
    }];
    
}


- (IBAction)usePassPayEvent:(id)sender {

    NSString *title ;
    
    
    NSInteger type = 0;
    if ([self.havePayPass isEqualToString:@"1"]) {
        title = [NSString stringWithFormat:@"请输入支付密码"];
        type =1 ;
    }else {
        title = [NSString stringWithFormat:@"请设置支付密码"];
        type = 0 ;
    }
    _passView = [PassView passViewFromXIBWithTitle:title
                                                    andType:type];
    _passView.frame = CGRectMake(WIDTH,self.y, self.width, self.height);
      __weak typeof(_passView)weakView = _passView ;
    __weak typeof(self)weakSelf = self ;
    _passView.block = ^() {
        [UIView animateWithDuration:0.25 animations:^{
            weakView.transform = CGAffineTransformIdentity ;
            weakSelf.transform = CGAffineTransformMakeTranslation(0, -weakSelf.height);
        } completion:^(BOOL finished) {
            [weakView removeFromSuperview];
        }];
    };
    //zhuce
    _passView.payBlock = ^BOOL( id value){
        if (weakSelf.setPaypassBlock) {
         weakSelf.setPaypassBlock(value);
        }
        return NO;
        
    };
    
    _passView.usepayPassBlock = ^(id value) {
        if (weakSelf.paypassBlock) {
            weakSelf.paypassBlock(value) ;
        }
    };
    
    [self.superview addSubview:_passView];
    
    if ([self.vertificationTextField isFirstResponder]) {
        [self.vertificationTextField resignFirstResponder];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformMakeTranslation(-WIDTH, -self.height);
        _passView.transform = CGAffineTransformMakeTranslation(-WIDTH, 0);
    } completion:^(BOOL finished) {
        [_passView.PassTextField becomeFirstResponder];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
   
    if ([self.vertificationBtn isFirstResponder]) {
        [self.vertificationBtn resignFirstResponder];
    }
}
- (IBAction)rightBtnClickEvent:(id)sender {
    if ([_vertificationTextField isFirstResponder]) {
        [_vertificationTextField resignFirstResponder];
    }
    
    if (self.messgeBlock) {
        self.messgeBlock(self.vertificationTextField.text);
    }

}

@end
