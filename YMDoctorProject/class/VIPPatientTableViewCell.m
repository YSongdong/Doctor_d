//
//  VIPPatientTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "VIPPatientTableViewCell.h"

@interface VIPPatientTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageVIew; //头像

@property (weak, nonatomic) IBOutlet UILabel *nameLabel; //名字
@property (weak, nonatomic) IBOutlet UILabel *sexLabel; //性别

@property (weak, nonatomic) IBOutlet UILabel *ordersLabel; //就医详情

@property (weak, nonatomic) IBOutlet UILabel *orderCencetLabel;//就医内容

@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel; //就医时间

@property (weak, nonatomic) IBOutlet UIButton *medicalCareBtn;

- (IBAction)medicalCareBtnAction:(UIButton *)sender;

@end



@implementation VIPPatientTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}
-(void)initUI
{
    _headerImageVIew.layer.masksToBounds = YES;
    _headerImageVIew.layer.cornerRadius = CGRectGetWidth(_headerImageVIew.frame)/2;
    
    //名字
    _nameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    
    _ordersLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    
    _orderCencetLabel.textColor  = [UIColor colorWithHexString:@"#A7A7A7"];
    
    _orderTimeLabel.textColor =[UIColor colorWithHexString:@"#999999"];
    
    //联系患者按钮
    self.medicalCareBtn.layer.cornerRadius = CGRectGetHeight(self.medicalCareBtn.frame)/2;
    self.medicalCareBtn.layer.masksToBounds = YES;
    self.medicalCareBtn.backgroundColor = [UIColor btnBlueColor];
}

-(void)setModel:(PatientManagerModel *)model
{

    _model = model;
    
    //头像
    [self.headerImageVIew sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"Image-11"]];
    
    //名字
    
    self.nameLabel.text = model.mealth_name;
    
    //性别
    self.sexLabel.text = model.member_sex;
    
    //就医内容
 
    self.orderCencetLabel.text = model.instructions_content;
    
    //就医详情
    self.ordersLabel.text = model.orders;
    
    //就诊时间
    
    self.orderTimeLabel.text = model.time;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
}

- (IBAction)medicalCareBtnAction:(UIButton *)sender {
    
    if ([self.delegate  respondsToSelector:@selector(selectdPatientCellIndexPath:)]) {
        [self.delegate selectdPatientCellIndexPath:self.indexPath];
    }

    
}
@end
