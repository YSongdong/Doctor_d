//
//  MYTMingYiAgreementTableViewCell1.h
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTMingYiAgreementTableViewCell : UITableViewCell


//合同说明
@property (weak, nonatomic) IBOutlet UILabel *explainLab;
//温馨提示
@property (weak, nonatomic) IBOutlet UILabel *tipsLab;


//时间约定
@property (weak, nonatomic) IBOutlet UIButton *service_start_timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *service_end_timeBtn;


//重要提醒
@property (strong, nonatomic) NSMutableArray *tipArr;

/**
 空腹
 */
@property (weak, nonatomic) IBOutlet UIButton *btn1;

/**
 医保卡
 */
@property (weak, nonatomic) IBOutlet UIButton *btn2;

/**
 身份证
 */
@property (weak, nonatomic) IBOutlet UIButton *btn3;

/**
 病历本
 */
@property (weak, nonatomic) IBOutlet UIButton *btn4;

/**
 近期检查报告
 */
@property (weak, nonatomic) IBOutlet UIButton *btn5;


//其他提醒
@property (weak, nonatomic) IBOutlet UITextField *other_tipsTF;


//双双责任
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


//甲方
@property (weak, nonatomic) IBOutlet UILabel *partA_nameLab;
//乙方
@property (weak, nonatomic) IBOutlet UILabel *partB_nameLab;


//甲方签署时间
@property (weak, nonatomic) IBOutlet UILabel *partA_timeLab;
//乙方签署时间
@property (weak, nonatomic) IBOutlet UILabel *partB_timeLab;


@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;


//注
@property (weak, nonatomic) IBOutlet UILabel *noteLab;


//再约时间
@property (weak, nonatomic) IBOutlet UIButton *secondTimeBtn;


- (void)setDetailsWithDictionary:(NSDictionary *)dic;

@property (nonatomic,copy) void (^selectedTipBlock)(NSMutableArray *tipArr);


@end

