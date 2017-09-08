//
//  MYTAccountRecordTableViewCell.h
//  MYTDoctor
//
//  Created by kupurui on 2017/6/29.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTAccountRecordTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

-(void)setDataWithDictionary:(NSMutableDictionary *)dic;

@end
