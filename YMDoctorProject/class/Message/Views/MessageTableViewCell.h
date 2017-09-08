//
//  MessageTableViewCell.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic,strong)NSString *target ;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *tilteLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)setDataModel:(id)model ;

- (void)setCellBackgroundColor:(UIColor *)color ;


@end
