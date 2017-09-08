//
//  YMDoctorDetailsEvaluationTableViewCell.m
//  doctor_user
//
//  Created by 黄军 on 17/5/23.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorDetailsEvaluationTableViewCell.h"

@interface YMDoctorDetailsEvaluationTableViewCell ()

@property(nonatomic,strong)UIImageView *headerImageView;//头像
@property(nonatomic,strong)UILabel *userNameLabel;//用户名字
@property(nonatomic,strong)UILabel *gevalTimeLabel;//时间
@property(nonatomic,strong)UILabel *gevalContentLabel;//内容
@property(nonatomic,strong)UILabel *serverGevalLabel;//评分
@property(nonatomic,strong)UIView *serverGevalView;//评分视图

@property(nonatomic,assign)NSInteger praiseNumber;

@property(nonatomic,strong)UILabel *serverNumberLabel;

@end

@implementation YMDoctorDetailsEvaluationTableViewCell

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
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(60);
    }];
    _gevalContentLabel = [[UILabel alloc]init];
//    _gevalContentLabel.text = @"服务评价：医生很专业";
    _gevalContentLabel.numberOfLines = 0;
    _gevalContentLabel.font = [UIFont systemFontOfSize:13];
    _gevalContentLabel.textColor = RGBCOLOR(180, 180, 180);
    [self addSubview:_gevalContentLabel];
    [_gevalContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headerImageView.mas_right).offset(10);
        make.centerY.equalTo(_headerImageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    _gevalTimeLabel = [[UILabel alloc]init];
//    _gevalTimeLabel.text = @"2017-08-09 12:23";
    _gevalTimeLabel.textColor =RGBCOLOR(114, 114, 114);
    _gevalTimeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_gevalTimeLabel];
    [_gevalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(_gevalContentLabel.mas_top).offset(-5);
    }];
    
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.text = @"小龙同学打得发疯大";
    _userNameLabel.font = [UIFont systemFontOfSize:13];
    _userNameLabel.textColor = RGBCOLOR(51, 51, 51);
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gevalContentLabel.mas_left);
        make.bottom.equalTo(_gevalTimeLabel.mas_bottom);
        make.right.equalTo(_gevalTimeLabel.mas_left).offset(-5);
    }];
    
    _serverGevalLabel = [[UILabel alloc]init];
    _serverGevalLabel.textColor = _gevalContentLabel.textColor;
    _serverGevalLabel.font = _gevalContentLabel.font;
    _serverGevalLabel.text = @"服务评分:";
    [self addSubview:_serverGevalLabel];
    [_serverGevalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_gevalContentLabel.mas_left);
        make.top.equalTo(_gevalContentLabel.mas_bottom).offset(5);
        make.width.mas_equalTo([_serverGevalLabel intrinsicContentSize].width+5);
    }];
    
    _serverNumberLabel = [[UILabel alloc]init];
    _serverNumberLabel.textColor = _gevalContentLabel.textColor;
    _serverNumberLabel.text = @"4.5分";
    _serverNumberLabel.font = _gevalContentLabel.font;
    [self addSubview:_serverNumberLabel];
    [_serverNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_gevalTimeLabel.mas_right);
        make.top.equalTo(_serverGevalLabel.mas_top);
        make.width.mas_equalTo([_serverNumberLabel intrinsicContentSize].width);
    }];
    
    _serverGevalView = [[UIView alloc]init];
    _serverGevalView.backgroundColor = [UIColor clearColor];
    [self addSubview:_serverGevalView];
    [_serverGevalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_serverNumberLabel.mas_left);
        make.bottom.equalTo(_serverGevalLabel.mas_bottom);
        make.height.mas_equalTo([_serverGevalLabel intrinsicContentSize].height);
        make.width.mas_equalTo(78);
    }];
    
    __weak typeof(self) weakSlef = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.height-1, SCREEN_WIDTH - 20, 3)];
        
        lineImg.image = [weakSlef drawLineByImageView:lineImg];
        // 添加到控制器的view上
        [weakSlef addSubview:lineImg];
    });
    
    
}


-(void)setPraiseNumber:(NSInteger)praiseNumber{
    _praiseNumber = praiseNumber;
    UIImage *highlightImage = [UIImage imageNamed:@"ct_start"];
    for (NSInteger i = 0; i<5 ; i++) {
        UIImageView *starImageView = [[UIImageView alloc]init];
        if (_praiseNumber > i) {
            starImageView.image = highlightImage;
        }else{
            starImageView.image = [UIImage imageNamed:@"start_gray"];
        }
        [_serverGevalView addSubview:starImageView];
        [starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i==0) {
                make.left.equalTo(_serverGevalView.mas_left);
            }else{
                make.left.mas_equalTo(highlightImage.size.width *i+3*i);
            }
            make.centerY.equalTo(_serverGevalView.mas_centerY);
            make.height.with.mas_equalTo(12);
        }];
    }
}


// 返回虚线image的方法
- (UIImage *)drawLineByImageView:(UIImageView *)imageView{
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 0.5是高度
    CGFloat lengths[] = {5,0.5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line,RGBCOLOR(229, 229, 229).CGColor );
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
    CGContextAddLineToPoint(line, SCREEN_WIDTH - 10, 2.0);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

-(void)setModel:(YMDoctorDetailsEvaluationModel *)model{
    _model = model;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@""]];
    NSArray *timeArr = [model.geval_addtime componentsSeparatedByString:@" "];
    NSString *geval_addtime = timeArr[0];
    _gevalTimeLabel.text = geval_addtime;
    //电话号码
    NSString *numStr =model.geval_frommembername;
    NSString *numberStr =[numStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    _userNameLabel.text =numberStr;
    
    _gevalContentLabel.text = [NSString stringWithFormat:@"服务评价：%@",model.geval_tags];
    _serverNumberLabel.text = [NSString stringWithFormat:@"%@分",model.geval_scores];
    [_serverNumberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_serverNumberLabel intrinsicContentSize].width);
    }];
    [_gevalTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([_gevalTimeLabel intrinsicContentSize].width);
    }];
    
    self.praiseNumber = [model.geval_scores integerValue];
}


@end
