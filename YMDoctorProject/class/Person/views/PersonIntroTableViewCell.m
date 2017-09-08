//
//  PersonIntroTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PersonIntroTableViewCell.h"

@implementation PersonIntroTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _contentTextView.delegate = self;
}
- (void)setTitle:(NSString *)title {
    
    _title = title ;
    _personTitleLabel.text = title ;
}


- (void)setContent:(NSString *)content {
    self.placeHolderLabel.hidden = YES ;
    _content = content ;
    _contentTextView.text = content ;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    _placeHolderLabel.text = placeHolder ;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _placeHolderLabel.hidden = YES;
    return YES ;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    //职业擅长
    if (textView.text.length == 0) {
        return ;
    }
    NSString *key = @"";
    NSString *value = @"";
    if (self.type == beGoodAt) {
        key = @"member_service";
        value = textView.text ;
    }
    else if (self.type == ProfileIntroduce){
        key = @"member_Personal" ;
        value = textView.text ;
    }
    if (self.textBlock) {
        self.textBlock(key,value);
    }
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        _placeHolderLabel.hidden = NO ;
    }
    [textView resignFirstResponder];
    return YES ;
}

@end
