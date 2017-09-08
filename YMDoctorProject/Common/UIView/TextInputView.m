//
//  TextInputView.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TextInputView.h"


@interface TextInputView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (nonnull,nonatomic,strong)UIView *backView ;
@property (nonatomic,strong)UITapGestureRecognizer *gesture ;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;

@end
@implementation TextInputView

+ (TextInputView *)textViewLoadFromXibWithTitleString:(NSString *)title {
    
    TextInputView *view = [[[NSBundle mainBundle]loadNibNamed:@"TextInput" owner:self options:nil] firstObject];
    view.bounds = CGRectMake(0, 0, WIDTH * 0.8, 230);
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES ;
    view.textView.delegate = view ;
    view.titleLabel.text = title ;
    view.alpha = 0 ;
    [[NSNotificationCenter defaultCenter]addObserver:view selector:@selector(upkeyboard:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:view selector:@selector(downkeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    return view ;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.placeHolderLabel.hidden = NO ;
    }
    [textView resignFirstResponder];
    return YES ;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.placeHolderLabel.hidden = YES;
    return YES ;
    
}
- (IBAction)sureBtnClicked:(id)sender {
    
    if (self.delegate) {
        [self.delegate didClickSureBtn:self.textView.text];
    }
    [self hiddenView];
}
- (IBAction)cancelBtnClicked:(id)sender {
    
    [self hiddenView];
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    _textView.delegate = self ;
    
}

- (void)inputViewShow {
    if (_backView) {
        [_backView removeFromSuperview];
        _backView = nil ;
    }
    _backView = [UIView new];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _backView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    _gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBegin)];
    
    [_backView addGestureRecognizer:_gesture];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    [_backView addSubview:self];
    self.center = _backView.center ;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1 ;
    } completion:^(BOOL finished) {
    }];
}

- (NSString *)content {
    
    return self.textView.text ;
}


- (void)touchBegin {
    
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
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
- (void)upkeyboard:(NSNotification *)notify {
    
    
    NSValue *upFrame = notify.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [upFrame CGRectValue];
    CGFloat start_y = frame.origin.y ;
    CGFloat maxY = CGRectGetMaxY(self.frame);
    if (start_y < maxY) {
        CGFloat offset = maxY - start_y ;
        CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformMakeTranslation(0, -offset);
        } completion:^(BOOL finished) {
        }];
    }
    
}

- (void)downkeyboard:(NSNotification *)notify {
    
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.transform =CGAffineTransformIdentity ;
    }];
    
}



@end
