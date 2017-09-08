//
//  HomeFunctionTableViewCell.m
//  YMDoctorProject
//
//  Created by dong on 2017/7/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeFunctionTableViewCell.h"

#import "UIButton+LZCategory.h"
#import "YFRollingLabel.h"
#import "HRAdView.h"

#import "HotspotModel.h"


@interface HomeFunctionTableViewCell (){
    YFRollingLabel *_label;
}

@property (weak, nonatomic) IBOutlet UIView *lineView; //中间线view
@property (weak, nonatomic) IBOutlet UIButton *mingyiBtn; //鸣医btn
- (IBAction)mingyiBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *mingyiLabel;

@property (weak, nonatomic) IBOutlet UIButton *governmentBtn;//官方活动
- (IBAction)governmentBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *governmentLabel;
@property (weak, nonatomic) IBOutlet UIButton *patientBtn;//患者

- (IBAction)patientBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *patientLabel;
@property (weak, nonatomic) IBOutlet UIButton *mineTrendsBtn; //我的动态
- (IBAction)mineTrendsBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *mineTrendLabel;

@property (weak, nonatomic) IBOutlet UILabel *TodayHotLabel; //今日热点

@property (weak, nonatomic) IBOutlet UIImageView *todayHotImageView;
@property (weak, nonatomic) IBOutlet UIImageView *hotImageView;



@property (weak, nonatomic) IBOutlet UIButton *adViewGrounBtn; //跑马灯背景btn

@property (nonatomic, strong) HRAdView *adView; //跑马灯效果

@property (nonatomic,strong) NSMutableArray *dataArr; //热点数组数据

@end

@implementation HomeFunctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self requestDataWithUrl];
  
    
}
-(void) updataUI
{
    NSMutableArray *textArr = [NSMutableArray array];
    for ( HotspotModel *model in self.dataArr) {
        [textArr addObject:model.hotspot_title];
    }
    HRAdView * view = [[HRAdView alloc]initWithTitles:textArr];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(_adViewGrounBtn);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.mas_right).offset(-40);
    }];
    view.textAlignment = NSTextAlignmentLeft;//默认
    view.isHaveTouchEvent = YES;
    view.labelFont = [UIFont boldSystemFontOfSize:14];
    view.color = [UIColor blackColor];
    view.time = 2.0f;
    view.defaultMargin = 10;
    view.numberOfTextLines = 2;
    view.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    __weak typeof(self) weakself = self;
    view.clickAdBlock = ^(NSUInteger index){
        HotspotModel *model = weakself.dataArr[index];
        NSString *url = model.hotspot_url;
        NSString *title = model.hotspot_title;
        if ([weakself.delegate respondsToSelector:@selector(selectdHospotUrl:andTitle:)]) {
            [weakself.delegate selectdHospotUrl:url andTitle:title];
        }
    };
    view.headImg = [UIImage imageNamed:@"home_hot"];
    self.adView = view;
    view.backgroundColor = [UIColor whiteColor];
    [self.adView beginScroll];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//鸣医
- (IBAction)mingyiBtnClick:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector(selectdCellBtnIndex:)]) {
        [self.delegate selectdCellBtnIndex:0];
    }
}
//官方活动
- (IBAction)governmentBtnClick:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector(selectdCellBtnIndex:)]) {
        [self.delegate selectdCellBtnIndex:1];
    }
}
//患者管理
- (IBAction)patientBtnClick:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector(selectdCellBtnIndex:)]) {
        [self.delegate selectdCellBtnIndex:2];
    }
}
//我的动态
- (IBAction)mineTrendsBtnClick:(UIButton *)sender {
    if ([self.delegate  respondsToSelector:@selector(selectdCellBtnIndex:)]) {
        [self.delegate selectdCellBtnIndex:3];
    }
}

#pragma mark  -- 热点时迅 ------
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
    
}
//热点
- (void)requestDataWithUrl {
    __weak typeof(self) weakSelf = self;
    KRMainNetTool *tool = [KRMainNetTool new];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"type"] = @(1);
    [tool sendRequstWith:Hotspot_Url params:params withModel:nil complateHandle:^(id showdata, NSString *error) {
        
        if (showdata == nil) {
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]]||[showdata isKindOfClass:[NSMutableArray  class]]) {
            for (NSDictionary *dic in showdata) {
                
              [weakSelf.dataArr addObject:[HotspotModel yy_modelWithDictionary:dic]];
  
            }
        }
         [weakSelf updataUI];
    }];
   
}






@end
