//
//  YMAddAccountTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/18.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMAddAccountTableViewCell.h"
#import "Masonry.h"
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


@interface YMAddAccountTableViewCell()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *rightImageView;

@property(nonatomic,strong)UIView *topLineView;

@property(nonatomic,strong)UIView *bottomLineView;

@property(nonatomic,strong)UILabel *subTitleLabel;

@end

@implementation YMAddAccountTableViewCell

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

-(void)initView{
    _topLineView = [[UIView alloc]init];
    _topLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    [self addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    _bottomLineView = [[UIView alloc]init];
    _bottomLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    _bottomLineView.hidden = YES;
    [self addSubview:_bottomLineView];
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    _rightImageView = [[UIImageView alloc]init];
    _rightImageView.image = [UIImage imageNamed:@"self_right_icon"];
    _rightImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_rightImageView];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(9);
    }];
    
    _titleLabel =[[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = RGBCOLOR(51, 51, 51);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(_topLineView.mas_bottom);
        make.bottom.equalTo(_bottomLineView.mas_top);
        
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH - 50);
    }];
    
    _subTitleLabel = [[UILabel alloc]init];
    _subTitleLabel.textColor = RGBCOLOR(80, 80, 80);
    _subTitleLabel.hidden = YES;
    _subTitleLabel.textAlignment = NSTextAlignmentRight;
    _subTitleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_subTitleLabel];
    [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_titleLabel);
        make.right.equalTo(_rightImageView.mas_left).offset(-10);
        make.left.equalTo(_titleLabel.mas_right).offset(10);
    }];
}

-(void)setLineInterval:(BOOL)lineInterval{
    if (lineInterval) {
        [_topLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
        }];
    }
}


-(void)setLastOne:(BOOL)lastOne{
    _bottomLineView.hidden = NO;
}

-(void)setTitleName:(NSString *)titleName{
    _titleLabel.text = titleName;
}


-(void)setSubTitlename:(NSString *)subTitlename{
    _subTitleLabel.hidden = NO;
    _subTitleLabel.text = subTitlename;
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH - 150);
    }];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
