//
//  YMCaseTopView.m
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseTopView.h"

static NSInteger const TAG_Treatment = 100010;//诊疗tag
static NSInteger const TAG_Case = 100011;//案例tag
static NSInteger const TAG_Honor = 100012;//荣誉tag
static NSInteger const TAG_Server = 100013;//服务tag

@interface YMCaseTopView()

@property(nonatomic,strong)NSArray *doctorCaseArry;//
@property(nonatomic,assign)NSInteger selectTextTag;

@end

@implementation YMCaseTopView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initVar];
        [self initView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self initVar];
    [self initView];
}


-(void)initVar{
    _doctorCaseArry = @[@"案例中心",@"荣誉中心",@"服务评价"];
}

-(void)initView{
    
    CGFloat single = (SCREEN_WIDTH -20) /(_doctorCaseArry.count * 1.f);
    
    for (NSInteger i = 0 ;i<_doctorCaseArry.count;i++) {
        UIButton *commodityButton = [[UIButton alloc]init];
        commodityButton.titleLabel.font = [UIFont systemFontOfSize:15];
        commodityButton.tag = TAG_Case+i;
        [commodityButton setTitle:_doctorCaseArry[i] forState:UIControlStateNormal];
        [commodityButton addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside
         ];
        
        if (i == 0) {
            _selectTextTag = commodityButton.tag;
        }
//
//            [commodityButton setTitleColor:RGBCOLOR(225, 225, 225) forState:UIControlStateNormal];
//            commodityButton.backgroundColor = RGBCOLOR(80, 168, 252);
//            commodityButton.layer.cornerRadius = 15;
//            commodityButton.layer.masksToBounds =YES;
//
//        }else{
            [commodityButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            commodityButton.backgroundColor = RGBCOLOR(255, 255, 255);
            commodityButton.layer.cornerRadius = 0;
            commodityButton.layer.masksToBounds =NO;
//
//        }
        [self addSubview:commodityButton];
        [commodityButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(single *i);
            make.centerY.top.equalTo(self);
            make.width.mas_offset(single);
        }];
    }
}

-(void)selectCaseNumber:(CaseNumber)CaseNumber{
    NSInteger tage = 0;
    switch (CaseNumber) {
        case CaseTreatmentNumber:{
            tage = TAG_Treatment;
        }
            break;
        case CaseHonorNumber:{
            tage = TAG_Honor;
        }
            break;
        case CaseCaseNumber:{
            tage = TAG_Case;
        }
            break;
        case CaseServerNumber :{
            tage = TAG_Server;
        }
            break;
        default:
            break;
    }
    
    NSArray *subViewArry = [self subviews];
    
    for (NSInteger i= 0; i<subViewArry.count; i++) {
        
        UIButton *sender = (UIButton *)[self viewWithTag:tage];
        
        if (tage == sender.tag) {
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            sender.backgroundColor = RGBCOLOR(80, 168, 252);
            sender.layer.cornerRadius = 15;
            sender.layer.masksToBounds =YES;
            _selectTextTag = tage;
        }else{
            [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [sender setBackgroundColor:RGBCOLOR(255, 255, 255)];
            
            sender.layer.cornerRadius = 0;
            sender.layer.masksToBounds = NO;
            
        }
    }
    

}


-(void)filterClick:(UIButton *)sender{
    if (sender.tag == _selectTextTag) {
        return;
    }
    
    CaseNumber clcikNumber = CaseTreatmentNumber;
    if (sender.tag == TAG_Treatment) {
        clcikNumber = CaseTreatmentNumber;
    }else if(sender.tag == TAG_Honor){
        clcikNumber = CaseHonorNumber;
    }else if(sender.tag == TAG_Case){
        clcikNumber = CaseCaseNumber;
    }else if (sender.tag == TAG_Server){
        clcikNumber = CaseServerNumber;
    }
    
    if ([self.delegate respondsToSelector:@selector(CaseTopView:CaseNumber:)]) {
        [self.delegate CaseTopView:self CaseNumber:clcikNumber];
    }
}

@end
