//
//  YMCaseBriefingView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseBriefingView.h"

@interface YMCaseBriefingView()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *briefingLabel;

@end

@implementation YMCaseBriefingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initView];
}

-(void)initView{
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = RGBCOLOR(80, 80, 80);
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.text = @"2017-06-21";
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo([_timeLabel intrinsicContentSize].width);
    }];
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"糖尿病治疗的完整过程";
    _titleLabel.textColor = RGBCOLOR(64, 149, 255);
    _titleLabel.font = _timeLabel.font;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(_timeLabel.mas_top);
        make.right.equalTo(_timeLabel.mas_left).offset(-10);
    }];
    
    _briefingLabel = [[UILabel alloc]init];
    _briefingLabel.text = @"案例简述：糖尿病治疗的完整过程";
    _briefingLabel.textColor = RGBCOLOR(80, 80, 80);
    _briefingLabel.font = _timeLabel.font;
    [self addSubview:_briefingLabel];
    [_briefingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.right.equalTo(_timeLabel.mas_right);
    }];
}

-(void)setModel:(YMCaseDetailsModel *)model{
    _timeLabel.text = model.case_time;
    _titleLabel.text = model.case_title;
    _briefingLabel.text = [NSString stringWithFormat:@"案例简述：%@",model.case_desc];
    
    NSLog(@"%f", [_briefingLabel intrinsicContentSize].height);
    [_timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_timeLabel intrinsicContentSize].width);
    }];
    
}


@end
