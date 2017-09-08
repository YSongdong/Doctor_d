//
//  YMDoctorDetailsHonorTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorDetailsHonorTableViewCell.h"
#import "XWScanImage.h"

@interface YMDoctorDetailsHonorTableViewCell ()

@property(nonatomic,strong)UIView *titleView;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *honorImageView;

@end

@implementation YMDoctorDetailsHonorTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self initView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initView{
    _titleView = [[UIView alloc]init];
    _titleView.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@45);
    }];
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 2;
    _titleLabel.textColor = RGBCOLOR(80, 80, 80);
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [_titleView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleView.mas_left).offset(10);
        make.right.top.bottom.equalTo(_titleView);
    }];
    _honorImageView = [[UIImageView alloc]init];
    
    _honorImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _honorImageView.backgroundColor = [UIColor clearColor];
    _honorImageView.image = [UIImage imageNamed:@""];
    [self addSubview:_honorImageView];
    [_honorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.height.equalTo(@105);
        make.width.equalTo(@130);
        make.top.equalTo(_titleView.mas_bottom).offset(5);
    }];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick:)];
    [_honorImageView addGestureRecognizer:tapGestureRecognizer];
    [_honorImageView setUserInteractionEnabled:YES];
}

-(void)setModel:(YMDoctorDetailsHonorModel *)model{
    _model = model;
    _titleLabel.text = [NSString stringWithFormat:@"%@%@",model.honor_time,model.honor_name];
    [_honorImageView sd_setImageWithURL:[NSURL URLWithString:model.honor_image] placeholderImage:[UIImage imageNamed:@""]];
    
}



#pragma mark - 浏览大图点击事件
-(void)scanBigImageClick:(UITapGestureRecognizer *)tap{
    NSLog(@"点击图片");
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    [XWScanImage scanBigImageWithImageView:clickedImageView];
}

@end
