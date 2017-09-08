//
//  YMDoctorServerInformationCollectionViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorServerInformationCollectionViewCell.h"

@interface YMDoctorServerInformationCollectionViewCell()

@property(nonatomic,strong)UIImageView *informationImageView;//图片

@property(nonatomic,strong)UILabel *picTopLabel;//图片上的文字

@property(nonatomic,strong)UILabel *serverPriceLabel;//价格

@property(nonatomic,strong)UILabel *scoreLabel;//评分

@property(nonatomic,strong)UILabel *browseLabel;//浏览次数


@end

@implementation YMDoctorServerInformationCollectionViewCell

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
    _informationImageView.image = [UIImage imageNamed:@"doctor_default"];
    [self addSubview:_informationImageView];
    [_informationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(self.width-30);
    }];
    
    UIView *maskedView =[[UIView alloc]init];
    maskedView.backgroundColor = [UIColor blackColor];
    maskedView.alpha = 0.5f;
    [self addSubview:maskedView];
    [maskedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_informationImageView);
    }];
    
    _picTopLabel = [[UILabel alloc]init];
    _picTopLabel.textAlignment = NSTextAlignmentCenter;
    _picTopLabel.text = @"123";
    [_picTopLabel setFont:[UIFont systemFontOfSize:20]];
    [_picTopLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_picTopLabel];
    [_picTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_informationImageView);
        make.left.right.equalTo(_informationImageView);
    }];
    
    
    
    _serverPriceLabel = [[UILabel alloc]init];
    _serverPriceLabel.textColor = [UIColor redColor];
    _serverPriceLabel.font = [UIFont systemFontOfSize:15];
    _serverPriceLabel.text = @"¥ 388.00";
    CGSize labelSize = [_serverPriceLabel intrinsicContentSize];
    [self addSubview:_serverPriceLabel];
    [_serverPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
         make.top.equalTo(_informationImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(labelSize.width);
    }];
    
    UILabel *boutLabel = [[UILabel alloc]init];
    boutLabel.text = @"元/次";
    boutLabel.font = _serverPriceLabel.font;
    [self addSubview:boutLabel];
    [boutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_serverPriceLabel.mas_top);
        make.right.equalTo(self.mas_right);
        
        make.left.equalTo(_serverPriceLabel.mas_right).offset(2);
    }];
    
    _scoreLabel = [[UILabel alloc]init];
    _scoreLabel.textColor = [UIColor grayColor];
    _scoreLabel.text = @"评分:4.5";
    _scoreLabel.font =[UIFont systemFontOfSize:13];
    
    CGSize scoreLabelSize = [_scoreLabel intrinsicContentSize];
    
    [self addSubview:_scoreLabel];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(_serverPriceLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(scoreLabelSize.width+10);
    }];
    
    _browseLabel =[[UILabel alloc]init];
    _browseLabel.textColor = _scoreLabel.textColor;
    _browseLabel.text = @"500次";
    _browseLabel.font = _scoreLabel.font;
    _browseLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_browseLabel];
    [_browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_scoreLabel.mas_top);
        make.left.equalTo(_scoreLabel.mas_right).offset(10);
    }];
    
}

@end
