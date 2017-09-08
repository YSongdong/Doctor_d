//
//  PassView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PassView.h"

@interface PassView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneSure; //
@property (nonatomic,strong)NSMutableDictionary *params ;
@property (nonatomic,assign)NSInteger step ;
@end
@implementation PassView

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}

+(PassView *)passViewFromXIBWithTitle:(NSString *)title
                              andType:(NSInteger)type{
    PassView *passView = [[[NSBundle mainBundle]loadNibNamed:@"PassView"
            owner:nil options:nil] firstObject];
    passView.titleLabel.text = title ;
    passView.type = type;
    if (type == 0) {

        [passView.rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
        passView.step = type ;
    }else {
        [passView.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    return passView ;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _PassTextField.delegate = self ;
    _PassTextField.layer.cornerRadius = 10 ;
    _PassTextField.layer.masksToBounds = YES ;
}
- (void)showView {

    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
    UIView *view = [[UIView alloc]init];
    view.frame = window.bounds ;
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [window addSubview:view];
    [view addSubview:self];
    [self.PassTextField becomeFirstResponder];
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

- (IBAction)rightBtnClickEvent:(id)sender {
    
    if (!self.PassTextField.text || self.PassTextField.text.length < 6) {
        [self passTextFiledAnimation:self.PassTextField];
        self.PassTextField.placeholder = @"密码长度至少为6位";
        
        return ;
    }
    
    if (self.step == 1) {
        if ([self.params objectForKey:@"pass"]) {
            if (![[self.params objectForKey:@"pass"]
                  isEqualToString:self.PassTextField.text]) {
                self.PassTextField.placeholder = @"请重新输入确认密码";
                [self passTextFiledAnimation:self.PassTextField];
                return ;
            }
        }
    }
    
    if (self.type == 0) {
        if (self.step == 0) {
            [self.params setObject:self.PassTextField.text forKey:@"pass"];
            self.PassTextField.text = nil ;
            self.PassTextField.placeholder = @"请再次确认支付密码";
            [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
            self.step = 1 ;
        } else if (self.step == 1) {
            //zhu ce
            self.payBlock(self.PassTextField.text);
        }
    }
    
    //zhi jie ti xian
    if (self.type == 1) {
        if (self.usepayPassBlock) {
            self.usepayPassBlock(self.PassTextField.text);
        }
    }
    //
    
}
- (void)passTextFiledAnimation:(UIView *)view {
    
    CALayer *shakeLayer = view.layer ;
    
         CGPoint position = shakeLayer.position;
       CGPoint x = CGPointMake(position.x + 10, position.y);
       CGPoint y = CGPointMake(position.x - 10, position.y);
   
         CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
       // 设置运动形式
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
     // 设置开始位置
         [animation setFromValue:[NSValue valueWithCGPoint:x]];
        // 设置结束位置
        [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
        [animation setAutoreverses:YES];
        // 设置时间
        [animation setDuration:.06];
         // 设置次数
        [animation setRepeatCount:3];
        // 添加上动画
         [shakeLayer addAnimation:animation forKey:nil];
}
//shou ji yanzheng
- (IBAction)phoneVertification:(id)sender {
    if (self.block) {
        self.block() ;
    }
}

@end
