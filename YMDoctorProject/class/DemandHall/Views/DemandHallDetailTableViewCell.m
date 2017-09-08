//
//  DemandHallDetailTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandHallDetailTableViewCell.h"

#import "ProgressView.h"
@interface DemandHallDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderSnLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *tenderLabel; //投标人数
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;

@property (weak, nonatomic) IBOutlet UILabel *visitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *visitAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *demandDescriptLabel;
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@end

@implementation DemandHallDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


- (void)setModel:(DemandModel *)model {
    
    _model = model ;
    self.progressView.account = 5 ;
    self.progressView.progress = [model.demand_schedule integerValue];
    [self.progressView addViews];
    self.orderSnLabel.text = [NSString stringWithFormat:@"需求编号:%@",model.demand_bh];
    self.titleLabel.text = model.demand_sketch;
    self.contentLabel.text = model.demand_needs ;
    self.priceLabel.text =  [NSString stringWithFormat:@"¥ %@",model.price];
    self.progressLabel.text = model.demand_type ;
    
    self.visitAreaLabel.text = [NSString stringWithFormat:@"描述:%@",model.demand_sketch];
    if (self.type == 1) {
        self.accountLabel.text = nil ;
        self.tenderLabel.text = nil ;
    }
    else {
        
        self.tenderLabel.text = model.demand_tbs;
        self.accountLabel.text = [NSString stringWithFormat:@"招标:%@/%@人",model.demand_amount,model.total];
        
    }
    self.doctorLabel.text = [NSString stringWithFormat:@"医师资格:%@",model.seniority];
    self.timeLabel.text = [NSString stringWithFormat:@"就诊时间:%@-%@",model.ktimes,model.jtimes];
    self.visitTimeLabel.text =[NSString stringWithFormat:@"就诊时间:%@-%@",model.ktimes,model.jtimes] ;
    self.demandDescriptLabel.text = [NSString stringWithFormat:@"需求内容:%@",model.demand_needs]  ;
}

@end
