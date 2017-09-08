//
//  YMDoctorFooterCollectionReusableView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorFooterCollectionReusableView.h"
#import "UIButton+LZCategory.h"

@interface YMDoctorFooterCollectionReusableView()

@property(nonatomic,strong)UILabel *outpatientClinicLabel;//门诊时间

@property(nonatomic,strong)UILabel *hospitalLabel;//所属医院

@property(nonatomic,strong)UILabel *weekLabel;//星期label

@property(nonatomic,strong)UIButton *anAndPmButton;//上午下午

@end


@implementation YMDoctorFooterCollectionReusableView

-(id)initWithFrame:(CGRect)frame{
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
   
    _hospitalLabel = [[UILabel alloc]init];
    _hospitalLabel.font = [UIFont systemFontOfSize:13];
    _hospitalLabel.textColor = RGBCOLOR(136, 136, 136);
    CGSize hospitalSize = [_hospitalLabel intrinsicContentSize];
    [self addSubview:_hospitalLabel];
    [_hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.top.bottom.equalTo(self);
        make.width.mas_equalTo(hospitalSize.width);
    }];
    
    _outpatientClinicLabel = [[UILabel alloc]init];
    _outpatientClinicLabel.text = @"门诊时间:";
    _outpatientClinicLabel.font = _hospitalLabel.font;
    [self addSubview:_outpatientClinicLabel];
    [_outpatientClinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.bottom.equalTo(self);
        make.right.equalTo(_hospitalLabel.mas_left);
    }];
    
    _anAndPmButton = [[UIButton alloc]init];
//    [_anAndPmButton setTitle:@"上午" forState:UIControlStateNormal];
//    [_anAndPmButton setImage:[UIImage imageNamed:@"dropdown_icon"] forState:UIControlStateNormal];
//    [_anAndPmButton addTarget:self action:@selector(timeClick:) forControlEvents:UIControlEventTouchUpInside];
    _anAndPmButton.titleLabel.font = _hospitalLabel.font;
    [_anAndPmButton setTitleColor:_hospitalLabel.textColor forState:UIControlStateNormal];
    
    
    [self addSubview:_anAndPmButton];
    [_anAndPmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(50);
    }];
    
    _weekLabel = [[UILabel alloc]init];
    _weekLabel.textColor = _hospitalLabel.textColor;
    _weekLabel.font = _hospitalLabel.font;
    [self addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_anAndPmButton.mas_left).offset(-10);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo([_weekLabel intrinsicContentSize].width);
    }];
}


-(void)setModel:(YMDoctorTimeModel *)model{
    _model = model;
    _hospitalLabel.text = model.hospital;
    [_hospitalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo([_hospitalLabel intrinsicContentSize].width);
    }];
    [_anAndPmButton setTitle:model.period forState:UIControlStateNormal];
    _weekLabel.text = model.week;
    [_weekLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_weekLabel intrinsicContentSize].width);
    }];
}



@end
