//
//  EvaluateTableViewCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "EvaluateTableViewCell.h"


@interface EvaluateTableViewCell ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *orderSnLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceEvaluateLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;



@end

@implementation EvaluateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _selectedIndex = 2 ;
    _textView.delegate = self ;
}

- (void)setModel:(DemandModel *)model {

    _model = model ;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.demand_sketch];
    self.orderSnLabel.text = [NSString stringWithFormat:@"%@",model.demand_bh];
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.demand_needs];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.jtimes];
    self.personLabel.text = nil ;
//    self.personLabel.text = [NSString stringWithFormat:@"招标%@-%@",model.demand_amount,model.total];
    self.moneyLabel.text =  [NSString stringWithFormat:@"%@",model.price];
    self.statusLabel.text =  [NSString stringWithFormat:@"%@",model.demand_type];
    self.progressLabel.text = [NSString stringWithFormat:@"%@",model.demand_type];
}
- (IBAction)starSelected:(UIButton *)sender {
    
    UIButton *button = [self.contentView viewWithTag:_selectedIndex + 1000];
    if (button.tag == sender.tag) {
        return ;
    }
    _selectedIndex = sender.tag - 1000 ;
    for (int i = 0; i <= _selectedIndex; i ++) {
        UIButton *btn = [self.contentView viewWithTag:1000 + i];
        [btn setImage:[UIImage imageNamed:@"star_selected"] forState:UIControlStateNormal];
    }
    for (NSInteger i = _selectedIndex + 1; i <=4; i ++) {
        
        UIButton *btn = [self.contentView viewWithTag:i+ 1000];
        [btn setImage:[UIImage imageNamed:@"star_unselected"] forState:UIControlStateNormal];
    }
}

- (NSString *)content {
    
    return self.textView.text ;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.placeHolderLabel.hidden = YES ;
    
    return YES ;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    
    [textView resignFirstResponder];
    
    if (textView.text.length == 0) {
        
        self.placeHolderLabel.hidden = NO ;
    }
    return YES ;
}
@end
