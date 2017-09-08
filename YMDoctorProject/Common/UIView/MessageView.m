//
//  MessageView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MessageView.h"

@interface MessageView ()
@property (nonatomic,strong)UIView *backView ;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumber;
@property (nonatomic,strong)UITapGestureRecognizer *gesture ;

@property (weak, nonatomic) IBOutlet UIButton *messageBtn;

@end

@implementation MessageView

+ (MessageView *)messageWithXib {
    
    MessageView *view =  [[[NSBundle mainBundle]
                             loadNibNamed:@"Message"
                           owner:self
                           options:nil]firstObject] ;
    view.bounds = CGRectMake(0, 0, WIDTH * 0.75, 100);
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10 ;
    view.layer.masksToBounds = YES ;
    view.alpha = 0 ;
    
    return view ;
}


- (void)messageShow{

    if (_backView.superview) {
        [_backView removeFromSuperview];
        _backView = nil ;
    }
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _backView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
    [_backView addGestureRecognizer:_gesture];
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    [_backView addSubview:self];
    self.center = _backView.center ;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1 ;
    } completion:^(BOOL finished) {
        
    }];
}

-(NSMutableAttributedString *)attributeStringWithStr:(NSString *)str
                                        andImageName:(NSString *)name{
    
    
    NSTextAttachment *attch = [[NSTextAttachment alloc]init];
    attch.image = [UIImage imageNamed:name];
    attch.bounds = CGRectMake(0, 0, 20, 20);
    NSAttributedString *attribte = [NSAttributedString attributedStringWithAttachment:attch];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:str];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor hightBlackClor]};
    [att setAttributes:dic range:NSMakeRange(0, att.length)];
    [att appendAttributedString:attribte];
    return att ;
}


- (void)setPhone:(NSString *)phone {
    
    _phone = phone ;
    if (![_phone isEqual:[NSNull null]]) {
          [_phoneNumber setTitle:[NSString stringWithFormat:@"雇主电话:%@",phone] forState:UIControlStateNormal];
    }
    else {
        [_phoneNumber setTitle:@"暂无联系电话" forState:UIControlStateNormal];
    }
  
}
- (void)hiddenView {
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0 ;
        
} completion:^(BOOL finished) {
        
    [self removeFromSuperview];
    [_backView removeFromSuperview];
    
    _backView = nil ;
    
    }];
}

//发送消息
- (IBAction)sendMessageEvent:(id)sender {
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(sendMessageOperator:)]) {
            
            [self.delegate sendMessageOperator:nil];
        }
    }
    [self hiddenView];
}

//拨打电话
- (IBAction)callEvent:(id)sender {
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(callNumber:)]) {
            [self.delegate callNumber:_phone];
        }
    }
    [self hiddenView];
}




@end
