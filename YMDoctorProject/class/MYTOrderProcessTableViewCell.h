//
//  MYTOrderProcess1TableViewCell.h
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTOrderProcessTableViewCell : UITableViewCell

#pragma mark - 鸣医订单

//查看详情
@property (weak, nonatomic) IBOutlet UIButton *viewDetailsBtn;

@property (weak, nonatomic) IBOutlet UILabel *orderSnLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *demandTimeLab;


//查看合同
@property (weak, nonatomic) IBOutlet UIButton *viewContractBtn;

@property (weak, nonatomic) IBOutlet UILabel *doctorSignTimeLab;

@property (weak, nonatomic) IBOutlet UILabel *titeLab;


//确认提交
@property (weak, nonatomic) IBOutlet UIButton *sureCommitBtn;
//申请仲裁†
@property (weak, nonatomic) IBOutlet UIButton *applyArbitrationBtn;


@property (weak, nonatomic) IBOutlet UIButton *instructionsBtn1;
@property (weak, nonatomic) IBOutlet UIButton *instructionsBtn2;
@property (weak, nonatomic) IBOutlet UIButton *instructionsBtn3;
@property (weak, nonatomic) IBOutlet UIButton *instructionsBtn4;


@property (weak, nonatomic) IBOutlet UILabel *instructionsPlaceHolder;
@property (weak, nonatomic) IBOutlet UITextView *instructionsTextView;


//确认提交
@property (weak, nonatomic) IBOutlet UIButton *sureCommitBtn2;
//查看评价
@property (weak, nonatomic) IBOutlet UIButton *viewEvaluateBtn;


@property (weak, nonatomic) IBOutlet UILabel *evaluatePlaceHolder;
@property (weak, nonatomic) IBOutlet UITextView *evaluateTextView;


#pragma mark - 预约订单

//接受 预约
@property (weak, nonatomic) IBOutlet UIButton *acceptOrderBtn;

//拒绝 预约
@property (weak, nonatomic) IBOutlet UIButton *refuseOrderBtn;


#pragma mark  -  判断线的亮度

@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *view1;


@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *view2;


@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *view3;


@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *view4;


@property (weak, nonatomic) IBOutlet UILabel *numThreeLab;
@property (weak, nonatomic) IBOutlet UIImageView *threeArrowImgView;
@property (weak, nonatomic) IBOutlet UILabel *finishWorkLab;


- (void)setDetailsWithDictionary:(NSDictionary *)dic;


@end

