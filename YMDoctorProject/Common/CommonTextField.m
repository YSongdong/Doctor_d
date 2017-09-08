//
//  CommonTextField.m
//  FenYouShopping
//
//  Created by fenyounet on 16/8/16.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "CommonTextField.h"
#import "LineView.h"
@interface CommonTextField ()
@property (nonatomic,strong)UILabel *titleLabel ;
@end

@implementation CommonTextField




- (instancetype)initWithPosition_Y:(CGFloat)position_Y
                         andHeight:(CGFloat)height{
    
    self = [super init];
    if (self) {
        self.height = height ;
        self.y = position_Y ;
        self.backgroundColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:16 *VerticalRatio()];
        self.textColor = [UIColor colorWithRGBHex:0x121212];
        self.returnKeyType = UIReturnKeyDone ;
        [self addLeftView];
    }
    return self ;
}


- (void)addLeftView {
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:17 *VerticalRatio()];
    _titleLabel.frame = CGRectMake(10, 0, 100 *HorizontalRatio(), self.height);
    _titleLabel.adjustsFontSizeToFitWidth = YES ;
    _titleLabel.textAlignment = NSTextAlignmentCenter ;
    self.leftViewMode = UITextFieldViewModeAlways ;
    self.leftView = _titleLabel ;
}

- (void)addLine {
    
    LineView *line1 = [LineView LineViewWithPosition:0 andWidth:WIDTH];    
    LineView *line2 = [LineView LineViewWithPosition:self.height andWidth:WIDTH];
    
    [self addSubview:line1];
    [self addSubview:line2];
}


- (void)setKeyType:(UIKeyboardType)keyType {

    _keyType = keyType ;
    self.keyboardType = keyType ;
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleLabel.font = titleFont ;
}

- (void)setContent:(NSString *)content {
    self.text = content ;
}

- (NSString *)getContent {
    return self.text ;
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    
    _placeHolder = placeHolder ;
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor colorWithRGBHex:0x999999],
                          NSFontAttributeName:[UIFont systemFontOfSize:15*VerticalRatio()]};
    NSAttributedString *attribute = [[NSAttributedString alloc]initWithString:placeHolder attributes:dic];
    self.attributedPlaceholder = attribute ;
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title ;

}


- (void)setTextFont:(UIFont *)textFont {
    
    self.font = textFont ;
}

//- (UITextField *)textFieldWithString:(NSString *)title
//                               frame:(CGRect)frame
//                         placeholder:(NSString *)placeHodler {
//    
//    
//    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
//    textField.backgroundColor = [UIColor whiteColor];
//    textField.font = [UIFont systemFontOfSize:17 *VerticalRatio()];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100 *HorizontalRatio(), frame.size.height)];
//    label.text = title ;
//    label.textAlignment = NSTextAlignmentCenter ;
//    label.font = [UIFont systemFontOfSize:17 *VerticalRatio()weight:1];
//    [textField addSubview:label];
//    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, frame.size.height)];
//    leftView.backgroundColor = [UIColor clearColor];
//    textField.leftView = leftView ;
//    textField.leftViewMode = UITextFieldViewModeAlways ;
//   
//    textField.enabled = NO ;
//    return textField ;
//}



@end
