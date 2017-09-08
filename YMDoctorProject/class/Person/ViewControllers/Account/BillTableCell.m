//
//  BillTableCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BillTableCell.h"

@interface BillTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *diseaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation BillTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setModel:(NSDictionary *)model {
    
        _timeLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"finnshed_time"]];
        _nameLabel.text  = [NSString stringWithFormat:@"%@",[model objectForKey:@"buyer_name"]];
    if (![model[@"demand_sketch"]isEqual:[NSNull null]]) {
        _diseaseLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"demand_sketch"]];
    }
    else {
        _diseaseLabel.text = nil ;
    }
        _moneyLabel.text = [NSString stringWithFormat:@"+ %@",[model objectForKey:@"order_amount"]];
    
}


@end
