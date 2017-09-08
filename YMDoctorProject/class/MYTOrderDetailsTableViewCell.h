//
//  MYTOrderDetailsTableViewCell1.h
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTOrderDetailsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *ageLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

//订单类型
@property (weak, nonatomic) IBOutlet UILabel *demandTypeLabel;
//科室
@property (weak, nonatomic) IBOutlet UILabel *ksLabel;
//医师资格
@property (weak, nonatomic) IBOutlet UILabel *aptitudeLab;
@property (weak, nonatomic) IBOutlet UILabel *demandTimeLab;

@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLab;
@property (weak, nonatomic) IBOutlet UITextView *demandContentTextView;

@property (weak, nonatomic) IBOutlet UILabel *demandEndTimelab; //结束时间




- (void)setDetailsWithDictionary:(NSDictionary *)dic;


@end
