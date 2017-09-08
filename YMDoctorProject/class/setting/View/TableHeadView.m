//
//  TableHeadView.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TableHeadView.h"

@interface TableHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@property (weak, nonatomic) IBOutlet UILabel *authenticationLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;

@property (weak, nonatomic) IBOutlet UILabel *doctor;
@property (weak, nonatomic) IBOutlet UILabel *successDealLabel;//成交量

@property (weak, nonatomic) IBOutlet UILabel *scanLabel;//浏览
@property (weak, nonatomic) IBOutlet UILabel *valuatePercentLabel; //好评率


@end


@implementation TableHeadView



+ (instancetype)tableHeadView {
    
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"TableViewHead" owner:self options:nil];
    return [array firstObject];
}

- (void)drawRect:(CGRect)rect {
    _headBtn.layer.cornerRadius = _headBtn.width/2;
    _headBtn.layer.masksToBounds = YES ;
    _authenticationLabel.layer.cornerRadius = 3 ;
    _authenticationLabel.layer.masksToBounds = YES ;
}



@end
