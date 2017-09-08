//
//  HomeListTableViewCell.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeListTableViewCell.h"

@interface HomeListTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *bid_numLabel;





@property (weak, nonatomic) IBOutlet UILabel *timeoutLabel;

@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
@property (weak, nonatomic) IBOutlet UILabel *TrusteeshipLabel; //托管
@property (weak, nonatomic) IBOutlet UIImageView *icon;



@property (nonatomic,strong)NSTimer *timer ;
@property (weak, nonatomic) IBOutlet UIButton *systemBtn;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (strong, nonatomic)UIView *lineView; //线条view
@end
@implementation HomeListTableViewCell
{
    NSInteger _time ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(_orderBtn.frame)/2-43, CGRectGetHeight(self.frame)-1, 86, 2)];
    self.lineView.backgroundColor =[UIColor btnBroungColor];
    [self addSubview:self.lineView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(DemandModel *)model {

    
    self.titleLabel.text = model.title;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",model.money];

    self.tipLabel.text = model.tip;

    self.bid_numLabel.text = [NSString stringWithFormat:@"招标 %@人",model.bid_num];
    
    
    
    
    
//    if ([model.order_apply integerValue] == 1
//        && [model.demand_schedule integerValue] < 3) {
//        //表示正常 洽谈中或者没有选标
//    }
//    //说明雇主选了医生
//    _model = model ;
//    _contextLabel.hidden = YES ;
//    _icon.hidden = YES ;
//    self.titleLabel.text =[NSString stringWithFormat:@"%@",model.demand_sketch ] ;
//    
////    self.moneyLabel.text =[NSString stringWithFormat:@"¥%@", model.price];
//    
//    self.moneyLabel.text = model.price;
//    self.TrusteeshipLabel.text = model.tuoguan;
//    
//    if (self.type == 2) {
//        
//        self.contextLabel.text = @"距离派单结束还有 ";
//        //表示雇佣
//        if ([model.demand_hire integerValue]== 1) {
//            self.contactLabel.text = [NSString stringWithFormat:@"雇佣 - / -"];
//        }else {
//            NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor bluesColor],
//                                  NSFontAttributeName:[UIFont systemFontOfSize:14]};
//            NSDictionary *dic1 = @{NSForegroundColorAttributeName:[UIColor redColor],
//                                   NSFontAttributeName:[UIFont systemFontOfSize:14]};
//            NSDictionary *dic2 = @{NSForegroundColorAttributeName:[UIColor hightBlackClor],
//                                   NSFontAttributeName:[UIFont systemFontOfSize:14]};
//            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"招标  " attributes:dic2];
//            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:model.demand_amount attributes:dic];
//            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" / %@",model.total] attributes:dic1];
//            [str appendAttributedString:str1];
//            [str appendAttributedString:str2];
//            self.contactLabel.attributedText = str ;
//        }
//    }else
//    {
//        self.contextLabel.text = @"距离沟通时限还有 ";
//          self.contactLabel.text = [NSString stringWithFormat:@"%@", model.demand_type];
//    }
//    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *myDate =[dateFormat dateFromString:self.model.jtimes];
//    NSDate *date = [NSDate date];
//    _time =  [myDate timeIntervalSinceDate:date];
//    //1 为选表中 2 选表成功 3 为选表失败
//    if (self.type == 1) {
//        NSInteger orderStatus = [model.order_apply integerValue];
//        switch (orderStatus){
//            case 1:{
//              if ([_model.demand_schedule integerValue] == 1) {
//                [self timeChange];
//        }
//            }break;
//            default:
//            { self.timeoutLabel.text  = nil;
//                _contextLabel.hidden = YES ;
//                _icon.hidden = YES ;
//                [_timer invalidate];
//                _timer = nil ;
//            }
//                break;
//        } 
//    }
//    //type == 2
//    else if (self.type == 2){
//        [self timeChange];
//    }
    
}

- (void)timeChange {
    
    if (_time <= 0) {
        self.timeoutLabel.text = @"已过期";
        self.icon.hidden = YES ;
        _contextLabel.hidden = YES ;
    }
    if (_time > 0) {
        self.icon.hidden =NO ;
        _contextLabel.hidden = NO ;
    }
    if  (_time > 0 && !_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            int days  = ((int)_time)/(3600*24);
            int hours = ((int) _time)%(3600 * 24)/3600;
            int m =     (((int)_time)%(3600 * 24)%3600)/60;
            
            if (days == 0) {
                _timeoutLabel.text = [NSString stringWithFormat:@"%d时%d分",hours,m];
            }
            else {
                _timeoutLabel.text = [NSString stringWithFormat:@"%d天%d时%d分",days,hours,m];
            }
            _time -- ;
            if (_time <= 0) {
                _timeoutLabel.text = @"已过期";
                [_timer invalidate];
            }
        }];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

- (NSTimer *)timer {
    return _timer ;
}

//订单动态
- (IBAction)systemOrder_event:(id)sender {
    if (_systemBtn.selected) {
        return ;
    }
    _systemBtn.selected = YES ;
    [_systemBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
    
    _orderBtn.selected = NO ;
    [_orderBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    
    //改变lineview的位置
    CGRect lineViewFrame = self.lineView.frame;
    lineViewFrame.origin.x -= CGRectGetWidth(_orderBtn.frame);
    [UIView animateWithDuration:1 animations:^{
        self.lineView.frame = lineViewFrame;
    }];
    
    if (self.block) {
        self.block(1);
    }
}
//系统派单
- (IBAction)orderStatsu_Event:(id)sender {
    
    if (_orderBtn.selected) {
        return ;
    }
    _orderBtn.selected = YES ;
    [_orderBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
    
    _systemBtn.selected = NO;
    [_systemBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    
    //改变lineview的位置
    CGRect lineViewFrame = self.lineView.frame;
    lineViewFrame.origin.x += CGRectGetWidth(_systemBtn.frame);
    [UIView animateWithDuration:1 animations:^{
        self.lineView.frame = lineViewFrame;
    }];
    
    if (self.block) {
        self.block(2);
    }
}




@end
