//
//  YMDoctorCaseViewCollectCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorCaseViewCollectCell.h"

@interface YMDoctorCaseViewCollectCell()

@property(nonatomic,strong)UIImageView *informationImageView;//图片

//@property(nonatomic,strong)UILabel *picTopLabel;//图片上的文字

@property(nonatomic,strong)UILabel *titleLabel;//标题

@property(nonatomic,strong)UILabel *timeLabel;//时间

@property(nonatomic,strong)UILabel *browseLabel;//浏览次数


@end

@implementation YMDoctorCaseViewCollectCell

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
    _informationImageView = [[UIImageView alloc]init];
    _informationImageView.backgroundColor = [UIColor clearColor];
    
   // [_informationImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    _informationImageView.image =  [UIImage imageNamed:@"doctor_default"];
   
    [self addSubview:_informationImageView];
    [_informationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(self.width-30);
    }];
    
    UIView *maskedView =[[UIView alloc]init];
    maskedView.backgroundColor = [UIColor clearColor];
//    maskedView.alpha = 0.5f;
    [self addSubview:maskedView];
    [maskedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_informationImageView);
    }];
    

    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.text = @"";
    CGSize labelSize = [_titleLabel intrinsicContentSize];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
         make.top.equalTo(_informationImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(labelSize.width);
    }];
    
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.text = @"2017-02-19";
    _timeLabel.font =[UIFont systemFontOfSize:13];
    
    CGSize scoreLabelSize = [_timeLabel intrinsicContentSize];
    
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_titleLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(scoreLabelSize.width+10);
    }];
    
    _browseLabel =[[UILabel alloc]init];
    _browseLabel.textColor = _timeLabel.textColor;
    _browseLabel.text = @"500次";
    _browseLabel.font = _timeLabel.font;
    _browseLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_browseLabel];
    [_browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_timeLabel.mas_top);
        make.left.equalTo(self.mas_right);
    }];
    
}

-(void)setModel:(YMDoctorDetailsCaseModel *)model{
    _model = model;
    [_informationImageView sd_setImageWithURL:[NSURL URLWithString:model.case_thumb] placeholderImage:[UIImage imageNamed:@"doctor_default"]];
    _titleLabel.text = model.case_title;
    _timeLabel.text = model.case_time;
    _browseLabel.text = [NSString stringWithFormat:@"%@次",model.page_view];
}

@end
