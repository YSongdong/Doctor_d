//
//  YMDoctorHomePageHeaderView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorHomePageHeaderTableViewCell.h"
#import "UIButton+LZCategory.h"
#import <UIView+YYAdd.h>


@interface YMDoctorHomePageHeaderTableViewCell()
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *headerImagView;
@property (weak, nonatomic) IBOutlet UILabel *headerName;
@property (weak, nonatomic) IBOutlet UILabel *EducationLabel;//文化程度
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;//等级
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel;//关注
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;//科室
@property (weak, nonatomic) IBOutlet UILabel *dutiesLabel;//职务
@property (weak, nonatomic) IBOutlet UILabel *affiliatedHospitalLabel;//所属医院
@property (weak, nonatomic) IBOutlet UILabel *favorableRateLabel;//成交量
@property (weak, nonatomic) IBOutlet UILabel *pageViewsLabel;//浏览量
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;//好评率
@property (weak, nonatomic) IBOutlet UILabel *dorverDynamicLabel;//医生动态
@property (weak, nonatomic) IBOutlet UILabel *goodDescriptionLabel;//擅长描述
@property (weak, nonatomic) IBOutlet UILabel *expertdiseaseLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailsButton;  //隐藏详情按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodAtHeight;

@property (weak, nonatomic) IBOutlet UIView *descriptionView;//描述视图
@property (weak, nonatomic) IBOutlet UIView *goodAtView;

@property (weak, nonatomic) IBOutlet UILabel *memberPersonalLabel;//个人介绍
@property (weak, nonatomic) IBOutlet UILabel *memberPersonalInfoLabel;//个人介绍

@property (weak, nonatomic) IBOutlet UIView *groundBView;


@end

@implementation YMDoctorHomePageHeaderTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self createView];
}

-(void)createView{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil];
    
    [self addSubview:_view];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    //隐藏详情按钮
    [_detailsButton LZSetbuttonType:LZCategoryTypeLeft];
    
    //背景view
    self.groundBView.backgroundColor =[UIColor colorWithHexString:@"#3d85cc"];
}

-(void)setClcickEvent:(BOOL)clcickEvent{
    _clcickEvent = clcickEvent;
    if (clcickEvent){
        _goodDescriptionLabel.numberOfLines = 0;
        _memberPersonalLabel.hidden =NO;
        _memberPersonalInfoLabel.hidden = NO;
        [_detailsButton setTitle:@"隐藏详情" forState:UIControlStateNormal];
        [_detailsButton setImage:[UIImage imageNamed:@"imgv_arrow_top_black"] forState:UIControlStateNormal];
    }else{
        _goodDescriptionLabel.numberOfLines = 2;
        _memberPersonalLabel.hidden = YES;
        _memberPersonalInfoLabel.hidden = YES;
        [_detailsButton setTitle:@"查看详情" forState:UIControlStateNormal];
        [_detailsButton setImage:[UIImage imageNamed:@"dropdown_icon"] forState:UIControlStateNormal];
    }
}

-(void)setModel:(YMDoctorDetailsModel *)model{
    _model = model;

    [_headerImagView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"暂无头像_03"]];
    _headerName.text = model.member_names;
//    _EducationLabel.text =model.member_education;
    _gradeLabel.text =[NSString stringWithFormat:@"V%@",model.grade_id];
    
    _attentionLabel.text =[NSString stringWithFormat:@"关注:%@人",model.follow_num];
    
    _departmentLabel.text =model.member_bm;
    _dutiesLabel.text =model.member_aptitude;
    _affiliatedHospitalLabel.text = model.member_occupation ;
    
    _favorableRateLabel.text =[NSString stringWithFormat:@"成交量:%@笔",_model.store_sales];
    _pageViewsLabel.text =[NSString stringWithFormat:@"浏览量:%@次",model.stoer_browse];
    _volumeLabel.text =[NSString stringWithFormat:@"评分:%@",model.avg_score];
    _EducationLabel.text = _model.member_education;
    _goodDescriptionLabel.text =model.member_service;
    
    _memberPersonalLabel.text = @"个人介绍:";

    
    _memberPersonalInfoLabel.text = _model.member_Personal;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"doctor_user===%f", _goodDescriptionLabel.height);
        NSLog(@"doctor_user===%f",_memberPersonalInfoLabel.height);
    });
    

    [self createGoodAtView];
}

#pragma mark - clickButton

- (IBAction)DetailsClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(HeaderTableViewCell:sender:)]) {
        [self.delegate HeaderTableViewCell:self sender:sender];
    }
}

+(CGFloat)DetailsViewHeight:(NSString *)text detailsClick:(BOOL)detailsClick{
    
    UILabel *detailLabel = [[UILabel alloc]init];
    if (detailsClick) {
        detailLabel.numberOfLines = 0;
        return  [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    }else{
        detailLabel.text = text;
        detailLabel.numberOfLines = 2;
        detailLabel.font = [UIFont systemFontOfSize:13];
        
        if (detailLabel.width>(SCREEN_WIDTH-20)) {
            return  35.f;
        }else{
            return 16;
        }

    }
    
    
}

+(CGFloat)memberPersonalInfoHeight:(NSString *)memberPersonalInfo{
    
    UILabel *detailLabel = [[UILabel alloc]init];
   
    detailLabel.numberOfLines = 0;
    
    CGSize titleSize = [memberPersonalInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    detailLabel.size = titleSize;
    
    return titleSize.height;
    
}

+(CGFloat)goodAtHeight:(NSString *)specialty_tags{
    CGFloat goodAtwidth= SCREEN_WIDTH - 85;
    NSArray *array = [specialty_tags componentsSeparatedByString:@","];
    CGFloat goodAtHeight = 18.f;
    CGFloat inforleft= 0.f;
    NSInteger goodAtNum =  0;
    for (NSString *goodat in array) {
        if (goodat.length == 0) {
            continue;
        }
        CGFloat  inforWidth = 0.0;
        UILabel *goodAtLabel = [[UILabel alloc]init];
        goodAtLabel.text = goodat;
        goodAtLabel.textColor = RGBCOLOR(251, 153, 42);
        goodAtLabel.font = [UIFont systemFontOfSize:11];
        goodAtLabel.layer.borderColor = RGBCOLOR(251, 153, 42).CGColor;
        goodAtLabel.layer.cornerRadius = 5;
        goodAtLabel.layer.borderWidth = 1.f;
        goodAtLabel.layer.masksToBounds = YES;
        goodAtLabel.backgroundColor = [UIColor whiteColor];
        goodAtLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize inforSize = [goodAtLabel intrinsicContentSize];
        inforWidth += inforSize.width+(10 + 10*2);
        NSInteger index = [array indexOfObject:goodat];
        if (index == 0) {
            inforleft = 0;
        }
        
        if (inforleft+inforWidth > goodAtwidth ) {
            inforleft = 0;
            goodAtNum ++;
            goodAtHeight =  goodAtNum*(18+10)+10;
        }
        
    }
    return  goodAtHeight;
}

-(void)createGoodAtView{
    NSArray *array = [_model.specialty_tags componentsSeparatedByString:@"、"];
    CGFloat goodAtwidth= SCREEN_WIDTH -_expertdiseaseLabel.width ;
    CGFloat inforleft= 0.f;
    NSInteger goodAtNum =  0;
    for (NSString *goodat in array) {
        if (goodat.length == 0) {
            continue;
        }
         CGFloat  inforWidth = 0.0;
        UILabel *goodAtLabel = [[UILabel alloc]init];
        goodAtLabel.text = goodat;
        goodAtLabel.textColor = RGBCOLOR(251, 153, 42);
        goodAtLabel.font = [UIFont systemFontOfSize:11];
        goodAtLabel.layer.borderColor = RGBCOLOR(251, 153, 42).CGColor;
        goodAtLabel.layer.cornerRadius = 5;
        goodAtLabel.layer.borderWidth = 1.f;
        goodAtLabel.layer.masksToBounds = YES;
        goodAtLabel.backgroundColor = [UIColor whiteColor];
        goodAtLabel.textAlignment = NSTextAlignmentCenter;
        [_goodAtView addSubview:goodAtLabel];
        
        CGSize inforSize = [goodAtLabel intrinsicContentSize];
        inforWidth += inforSize.width+(10 + 10*2);
        NSInteger index = [array indexOfObject:goodat];
        if (index == 0) {
            inforleft = 0;
        }
        
        if (inforleft+inforWidth > goodAtwidth ) {
            inforleft = 0;
            goodAtNum ++;
            _goodAtHeight.constant = goodAtNum*(18+10)+10;
        }
        
        [goodAtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(inforSize.width+10*2));//文字居中对其后左右的间距为5

            make.top.mas_equalTo(goodAtNum*(18+5));
            make.height.mas_equalTo(18);
            
            make.left.equalTo(@(inforleft));
        }];
       inforleft = inforleft+inforWidth;
    }
}
#pragma mark  --- 关于医生关注------
//关注医生
- (IBAction)fun_doctoBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(selectdFollowDoctorBtnClick)]) {
        [self.delegate selectdFollowDoctorBtnClick];
    }
    
}



@end
