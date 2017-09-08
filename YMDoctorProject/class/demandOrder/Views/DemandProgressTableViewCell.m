//
//  DemandProgressTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandProgressTableViewCell.h"


@interface DemandProgressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderSnLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel; //eg 1 2 3 4 ...

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextStepbtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *layerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (nonatomic,assign)NSInteger step ;


@end
@implementation DemandProgressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"%s",__func__);
    self.nextStepbtn.hidden = YES ;
    CGFloat fontSize = _typeLabel.font.pointSize ;
    self.typeLabel.font = [UIFont systemFontOfSize:fontSize *VerticalRatio()];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)drawRect:(CGRect)rect {
    
    NSLog(@"%s",__func__);
    _nextStepbtn.layer.cornerRadius = 3 ;
    _nextStepbtn.layer.masksToBounds = YES ;
    _nextStepbtn.layer.borderColor = [UIColor orangesColor].CGColor ;
    _nextStepbtn.layer.borderWidth = 0.5 ;
     
}

- (void)setModel:(DemandModel *)model {
    
    NSInteger status = [model.demand_schedule integerValue];
    self.orderSnLabel.text = [NSString stringWithFormat:@"%@",model.demand_bh];
    self.statusLabel.text =  [NSString stringWithFormat:@"%@",model.demand_type];
    if ([self.stepLabel.text integerValue] <= status) {
        self.lineView.backgroundColor = [UIColor bluesColor];
        self.layerView.backgroundColor = [UIColor bluesColor];
        self.icon.image = [UIImage imageNamed:@"sanjiaoxing"];
    }else {
    self.lineView.backgroundColor = [UIColor deliveryMoneyColor];
        self.layerView.backgroundColor = [UIColor deliveryMoneyColor];
        self.icon.image =[UIImage imageNamed:@"sanjiaoxing2"];
    }
    if (status >=3) {
        
        if ([self.stepLabel.text integerValue] == 3) {
            self.nextStepbtn.hidden = NO;
            [self.nextStepbtn setTitle:@"查看合同" forState:UIControlStateNormal];
        }
        else if ((status == 5 || status == 6) &&([self.stepLabel.text integerValue] == 5)) {
            self.nextStepbtn.hidden = YES;
            //[self.nextStepbtn setTitle:@"上传处方" forState:UIControlStateNormal];
        }
    }
    if (self.step == 1) {
        //投标成功时间
        self.timeLabel.text = [self getTimeWithTimeInterval:model.finnshed_time]  ;
    }
    if (self.step == 2) {
        //洽谈成功时间
        //,......
        self.timeLabel.text = [self getTimeWithTimeInterval:model.order_time2] ;
    }
    if (self.step == 3) {
        self.timeLabel.text = [self getTimeWithTimeInterval:model.ascertain_tj] ;
    }
    if (self.step == 4) {
        self.timeLabel.text =  [self getTimeWithTimeInterval:model.payment_time ];
    }if (self.step == 5) {
        self.timeLabel.text =[self getTimeWithTimeInterval:model.geval_addtime] ;
    }
}
- (NSString *)getTimeWithTimeInterval:(NSString *)timeInterval {
    if ([timeInterval integerValue]<= 0) {
        return nil ;
    }
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:[timeInterval integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    return [formatter stringFromDate:data];
}

- (IBAction)btnClick_Event:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickCellRightBtnEvent:)]) {
        [self.delegate didClickCellRightBtnEvent:self.step];
    }
}
- (void)setDataList:(NSDictionary *)dataList {
    
    _dataList = dataList ;
    self.contentLabel.text = dataList[@"content"];
    self.typeLabel.text = dataList[@"title"];
    self.stepLabel.text = dataList[@"step"];
    self.step = [dataList[@"step"] integerValue];
    
}
@end
