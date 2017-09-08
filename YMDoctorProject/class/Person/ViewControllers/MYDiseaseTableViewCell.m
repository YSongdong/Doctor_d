//
//  MYDiseaseTableViewCell.m
//  YMDoctorProject
//
//  Created by 黄军 on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYDiseaseTableViewCell.h"

#import "KTRLabelView.h"

@interface MYDiseaseTableViewCell()<KTRLabelViewDelegate>


@property(nonatomic,strong)KTRLabelView *labeView;

@end

@implementation MYDiseaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
    // Initialization code
}


-(void)initView{
    _labeView =[[KTRLabelView alloc]init];
    _labeView.delegate = self;
    [self addSubview:_labeView];
    _labeView.labelClock = RGBCOLOR(180, 180, 180);
    _labeView.borderClock = RGBCOLOR(130, 130, 130);
    _labeView.roundAngle = YES;
    _labeView.roundNumber = 5;
    [_labeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.bottom.equalTo(self);
    }];
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    _labeView.labelProperty = dic;
}

-(void)setDiseaseArry:(NSArray *)diseaseArry{
    _diseaseArry = diseaseArry;
    _labeView.labelData = _diseaseArry;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)diseaseTableViewHeight:(NSArray *)diseaseArr dic:(NSDictionary *)dic{
    return [KTRLabelView labelViewHeight:dic labelData:diseaseArr];
}

#pragma mark - KTRLabelViewDelegate

-(void)labeView:(KTRLabelView *)labeView clickNumber:(NSInteger)clickNumber{
    NSDictionary *diseaseDic = _diseaseArry[clickNumber];
    if ([self.delegate respondsToSelector:@selector(diseaseCell:diseaseDic:)]) {
        [self.delegate diseaseCell:self diseaseDic:diseaseDic];
    }
}

@end
