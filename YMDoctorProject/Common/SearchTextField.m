//
//  SearchTextField.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SearchTextField.h"

@interface SearchTextField ()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton *leftBtn ;


@end

@implementation SearchTextField


- (void)drawRect:(CGRect)rect {
    
    self.placeholder = @"请输入关键字进行搜索";
    self.borderStyle = UITextBorderStyleRoundedRect ;
    self.height = 30 ;
    
    self.delegate = self;
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    
    [textField resignFirstResponder];
    
    return YES ;

}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    return YES ;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    return YES ;
}


- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.bounds = CGRectMake(0, 0, 20, 20);
        self.leftView = _leftBtn ;
    }
    return _leftBtn ;
}

@end
