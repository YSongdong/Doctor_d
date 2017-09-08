//
//  DemandDetailTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandDetailTableViewCell.h"
#import "ProgressView.h"
@interface DemandDetailTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *orderSnLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealRecordLabel;
@property (weak, nonatomic) IBOutlet UILabel *userTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *evaluateLabel;//hao ping lv

@property (weak, nonatomic) IBOutlet UILabel *regInfoLabel;//挂号信息

@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;//剩余时间
@property (weak, nonatomic) IBOutlet ProgressView *progressView;

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderLabel; //订单号
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *needTime;

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goingOnLabel;//进行中
@property (weak, nonatomic) IBOutlet UILabel *personLable;

@property (weak, nonatomic) IBOutlet UILabel *chatLabel; //与雇主洽谈

@property (nonatomic,strong)NSTimer *timer ;
@property (nonatomic,assign)NSInteger time ;
@end

@implementation DemandDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)drawRect:(CGRect)rect {
    
    _headBtn.layer.cornerRadius = _headBtn.width/2 ;
    _headBtn.layer.masksToBounds = YES ;
    

}

- (void)setModel:(DemandModel *)model {
    
    self.orderLabel.text = model.demand_sketch ;
        //////进程数//需求状态 1为选标中 2洽谈成功3签订合同中 4签订合同 5完成工作付款 6 确认付款
    
    NSInteger index = [model.demand_schedule integerValue];
    self.statusLabel.text = model.demand_type ;
    self.nameLabel.text = model.buyner_name ;
    [self.headBtn sd_setImageWithURL:[NSURL URLWithString:model.demand_portrait]
                            forState:UIControlStateNormal];
    
    [self.progressView setAccount:5];
    [self.progressView setProgress:index];
    [self.progressView addViews];
    self.orderSnLabel.text = model.demand_bh;
    self.contentLabel.text= model.demand_needs ;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥: %@",model.price] ;
    if ( self.orderType == 1 ) {
        self.personLable.text = nil ;
    }else {
        self.personLable.text = [NSString stringWithFormat:@"招标: %@/%@",model.demand_amount,model.total];
    }
    self.dealRecordLabel.text = [NSString stringWithFormat:@"成交量:%@",model.demand_count]  ;
    self.goingOnLabel.text = model.demand_type ;
    self.nameLabel.text = model.demand_name ;
    self.needTime.text = [NSString stringWithFormat:@"%@ - %@",model.fbtime,model.jtimes];
    if ([model.demand_schedule integerValue] == 1) {
        NSInteger endTime = [model.finnshed_time integerValue];
        NSDate *data = [NSDate date];
        NSInteger nowTime = [data timeIntervalSince1970];
        _time = endTime - nowTime ;
        
        if (_time > 0) {
            self.chatLabel.hidden = NO ;
            self.alertLabel.text = [NSString stringWithFormat:@"请联系雇主 否则订单将于%@小时失效",model.demand_term];
            NSLog(@"time:%ld",_time);
            if (!_timer) {
                _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    int days  = ((int)_time)/(3600*24);
                    int hours = ((int) _time)%(3600 * 24)/3600;
                    int m =     (((int)_time)%(3600 * 24)%3600)/60;
                    int s = ((((int)_time)%(3600 * 24)%3600)%60)%60;
                    self.leftTimeLabel.text = [NSString stringWithFormat:@"剩余:%d天%d小时%d分%d秒",days,hours,m,s];
                    _time -- ;
                    if (_time <= 0) {
                        [_timer invalidate];
                    }
                }];
                [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
            }
            
        }
       
    }
    if ([model.demand_schedule integerValue] == 2) {
        if ([model.order_apply integerValue] == 1) {
            self.alertLabel.text = @"请耐心等待雇主选标";
        }
        if ([model.order_apply integerValue] == 2) {
            self.alertLabel.text = @"投标成功,可点击与雇主签订合同";
        }
        if ([model.order_apply integerValue] == 3) {
            self.alertLabel.text = @"投标失败";
        }
    }
    self.evaluateLabel.text = [NSString stringWithFormat:@"好评率:%@",model.average_value];
    [DemandDetailTableViewCell returnUploadTime:model.finnshed_time];
    
}

+ (NSString *) returnUploadTime:(NSString *)timeStr
{
    //Tue May 21 10:56:45 +0800 2013
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"E MMM d HH:mm:SS Z y"];
    NSDate *d=[date dateFromString:timeStr];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];

    }
    if (cha/3600>1&&cha/86400<1) {
        //        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        //        timeString = [timeString substringToIndex:timeString.length-7];
        //        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"HH:mm"];
        timeString = [NSString stringWithFormat:@"今天 %@",[dateformatter stringFromDate:d]];
    }
    if (cha/86400>1)
    {
        //        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        //        timeString = [timeString substringToIndex:timeString.length-7];
        //        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YY-MM-dd HH:mm"];
        timeString = [NSString stringWithFormat:@"%@",[dateformatter stringFromDate:d]];
        
    }
    
    
    return timeString;
}

@end
