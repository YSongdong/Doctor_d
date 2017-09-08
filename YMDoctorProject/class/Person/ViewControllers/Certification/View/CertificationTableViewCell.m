//
//  CertificationTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CertificationTableViewCell.h"
@interface CertificationTableViewCell ()<UITextFieldDelegate>

@end

@implementation CertificationTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    _writeTextField.delegate = self ;
   
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_writeTextField resignFirstResponder];
    return YES ;
}

- (IBAction)didclickWithDifferentOperate:(id)sender {
    
    UIButton *btn = (UIButton *)sender ;
    if (_type == cellTypeGender) {
        [self listViewShowWithPoint:CGPointMake(btn.centerX, self.contentView.height)];
    }
    if (_type == cellTypeBirthDay) {
        [self choiceTime];
    }
    //证件有效期
    if (_type == cellTypeIdCardValidData) {
        [self choiceTime];
    }
    //科室
    if (_type == cellTypeDepartMent) {
        
        [self choiceDepartment];
    }
    if (_type == cellTypeHightestEducational) {
        
        [self listViewShowWithPoint:CGPointMake(btn.centerX, self.contentView.height)];
    }
    if (_type == cellTypeHospital || _type == cellTypeQualification) {
        [self choiceValidateTime];
    }

}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //身份证号
    if (self.type == cellTypeIDCard) {
        
        
    }
}


- (void)setType:(Celltype)type {
    _type = type ;
}

- (void) listViewShowWithPoint:(CGPoint)startPoint {
    if (self.delegate) {
        [self.delegate didClickWithPoint:startPoint andView:self];
    }
}
- (void)choiceTime {
 if (self.delegate) {
     [self.delegate didClickChoiceTimeView:self andType:self.type];
    }
}

- (void)choiceValidateTime {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didClickChoiceValidateTimeView:)]) {
            
            NSLog(@"%s",__func__);
            [self.delegate didClickChoiceValidateTimeView:self];

        }
        
    }
}

- (void)choiceDepartment {
    if (self.delegate) {
        [self.delegate didClickChoiceDepartmentWithView:self];
        
    }
}

- (IBAction)secondPicChoice:(id)sender {
    
    [self.delegate didClickChoicePicture:sender];
}
- (IBAction)firstPicChoice:(id)sender {
    
    [self.delegate didClickChoicePicture:sender];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}
@end
