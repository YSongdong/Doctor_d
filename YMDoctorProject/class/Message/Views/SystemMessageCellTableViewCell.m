//
//  SystemMessageCellTableViewCell.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SystemMessageCellTableViewCell.h"
@implementation SystemMessageCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.timeLabel.layer.cornerRadius = 5 ;
    self.timeLabel.layer.masksToBounds = YES ;
    self.timeLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    self.backView.layer.cornerRadius = 5 ;
    self.backView.layer.masksToBounds = YES ;
    self.contentView.backgroundColor = [UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)setModel:(DemandModel *)model {
    
//     CGSize timeSize = [model.message_time sizeWithBoundingSize:CGSizeMake(WIDTH  - 20, 0) font:[UIFont systemFontOfSize:13]];
    
    
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:model._logo] placeholderImage:[UIImage imageNamed:@"系统消息_03"]];
    self.timeLabel.text = [NSString stringWithFormat:@"  %@  ",[self timeWithTimeIntervalString:model.message_time ]];
    self.titleLabel.text = model.message_title ;
    self.contentLabel.text =  model.message_body ;
}
+ (CGFloat)calcuteHeihtWithWIthModel:(DemandModel *)model {
    
    CGSize timeSize = [model.message_title sizeWithBoundingSize:CGSizeMake(WIDTH  - 20, 0) font:[UIFont systemFontOfSize:16]];
    CGSize contentSize = [model.message_body sizeWithBoundingSize:CGSizeMake(WIDTH - 130, 0) font:[UIFont systemFontOfSize:15]];
    CGFloat height = contentSize.height ;
    if (height < 60) {
        height  = 60 ;
    }
    return 50 + height + timeSize.height + 20 ;
}
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
@end
