//
//  AccountCollectionViewCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AccountCollectionViewCell.h"

@interface AccountCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;// account
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
@implementation AccountCollectionViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 10 ;
    self.layer.masksToBounds = YES ;    
    NSTextAttachment *attchment= [[NSTextAttachment alloc]init];
    attchment.image = [UIImage imageNamed:@"delete"];
    attchment.bounds = CGRectMake(0, 0, 20, 20);
    
    NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attchment];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:@"删除" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [attr appendAttributedString:str];
    [_deleteBtn setContentMode:UIViewContentModeCenter];
    [_deleteBtn setAttributedTitle:attr forState:UIControlStateNormal];
}


- (void)setModel:(DemandModel *)model {
    
    _model = model ;
    _bankNameLabel.text = model.name ;
    _accountLabel.text = model.card_num ;
}
- (IBAction)deleteCell:(UIButton *)sender {
    
    if (self.block) {
        self.block(self);
    }
    
    
}

- (void)deleteCellBlock:(deleteCellBlock)block {
    
    _block = block ;
}

@end
