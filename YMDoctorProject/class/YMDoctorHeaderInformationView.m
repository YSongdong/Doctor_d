//
//  YMDoctorHeaderInformationView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorHeaderInformationView.h"

@interface YMDoctorHeaderInformationView()

@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEducationLabel;
@property (weak, nonatomic) IBOutlet UILabel *userGradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;

@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dutiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *affiliatedHospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *favorableRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *pageviewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@end

@implementation YMDoctorHeaderInformationView

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
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

-(void)setModel:(YMDoctorDetailsModel *)model{
    _model = model;
    _userEducationLabel.text = model.member_education;
    [_userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    _userNameLabel.text = model.member_names;
    //    _EducationLabel.text =model.member_education;
    _userGradeLabel.text =[NSString stringWithFormat:@"V%@",model.grade_id];
    
    _attentionLabel.text =[NSString stringWithFormat:@"关注:%@人",model.follow_num];
    
    _departmentLabel.text =model.member_bm;
    _dutiesLabel.text =model.member_aptitude;
    _affiliatedHospitalLabel.text = model.member_occupation ;
    
    _favorableRateLabel.text =[NSString stringWithFormat:@"成交量:%@笔",_model.store_sales];
    _pageviewsLabel.text =[NSString stringWithFormat:@"浏览量:%@次",model.stoer_browse];
    _volumeLabel.text =[NSString stringWithFormat:@"好评率:%d%%次",[model.avg_score intValue]*20];
    //    _dorverDynamicLabel.text = _model.member_service;
//    _goodDescriptionLabel.text =model.member_service;
}

@end
