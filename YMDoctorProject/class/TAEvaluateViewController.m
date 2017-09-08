//
//  TAEvaluateViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//


#import "TAEvaluateViewController.h"
#import "OrderHeadView.h"
#import "ContentView.h"
#import "DemandOrderModel.h"
#import "EvaluateModel.h"
#import "YMLabelButtonView.h"


@interface TAEvaluateViewController ()<OrderHeadViewDelegate>
@property (weak, nonatomic) IBOutlet OrderHeadView *headView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet ContentView *contentView1;

@property (weak, nonatomic) IBOutlet UILabel *evaluateLabel;
@property (weak, nonatomic) IBOutlet UILabel *evalteTimeLabel;
@property (weak, nonatomic) IBOutlet ContentView *contentView2;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UILabel *feedBackTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contrasctH;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic,strong)DemandOrderModel *orderModel ;
@property (nonatomic,strong)DemandModel *model ;
@property (nonatomic,strong)EvaluateModel *evalModel;

@property (weak, nonatomic) IBOutlet UIButton *oneScoreBtn;//评分1

@property (weak, nonatomic) IBOutlet UIButton *twoScoreBtn;//评分2

@property (weak, nonatomic) IBOutlet UIButton *threeScroeBtn;//评分3

@property (weak, nonatomic) IBOutlet UIButton *fourScoreBtn;//评分4

@property (weak, nonatomic) IBOutlet UIButton *fiveScoreBtn;//评分5

//@property (nonatomic,strong) YMLabelButtonView *labeButtonView;

@property (weak, nonatomic) IBOutlet YMLabelButtonView *labeButtonView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LabeBtnViewHeight; //自动布局的高度



@end

@implementation TAEvaluateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.headView setTitles:@[@"我的评价",@"TA对我的评价"]];
    _labeButtonView.type = LabelShowViewType;
 //   _labeButtonView.width = SCREEN_WIDTH;
    self.headView.selectedIndex = 1;
    self.headView.delegate =self ;
    self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setup];
}
- (void)setup {
    [self request];
    self.contentView1.hidden = YES ;
    self.contentView2.hidden = YES ;
}
- (void)request {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@([self.order_idStr integerValue]) forKey:@"order_id"];
    
   [self.orderModel showCommentsWithParams:dic
       commomPleteBlock:^(id status) {
           if (status) {
               self.evalModel = [EvaluateModel new];
               [self.evalModel setValuesForKeysWithDictionary:status];
               [self selectedIndexChangeRequest];
           }
    }];
}

- (void)viewDidLayoutSubviews {
    
    self.backgroundView.frame = CGRectMake(self.backgroundView.x, self.backgroundView.y, WIDTH, HEIGHT);
    self.scrollView.contentSize =CGSizeMake(WIDTH, self.backgroundView.height);
}

-(void)setEvalModel:(EvaluateModel *)evalModel
{

    _evalModel = evalModel;

}
//- (void)setModel:(DemandModel *)model {
//    _model = model ;
//}
- (void)selectedIndexChangeRequest {
    //我的评价 他的回复
    if (_headView.selectedIndex == 0 ) {
        self.sureBtn.hidden = YES ;
        if (!self.evalModel.doctor_ping_time ||
            [self.evalModel.doctor_ping_time isEqualToString:@""]) {
            //我还没有评价
            self.contentView1.hidden = YES ;
            self.contentView2.hidden = YES ;
            self.alertBtn.hidden  = NO ;
        }
        else{
            //我已经 评价
            self.contentView1.selectedIndex = [self.evalModel.doctor_score  integerValue];
            self.contentView1.hidden = NO ;
            self.evaluateLabel.text = _evalModel.doctor_ping ;
            self.evalteTimeLabel.text = [self stringFromTimeInterval:_evalModel.doctor_ping_time];
            self.alertBtn.hidden = YES ;
            if (![_evalModel.user_hui isEqualToString:@""]) {
                //用户已经回复
                self.contentView2.hidden = NO ;
                self.titleLabel.text = @"他的回复";
                self.feedbackTextView.text = self.evalModel.doctor_hui ;
                self.feedBackTimeLabel.text = [self stringFromTimeInterval:_model.mreply_time];
                self.feedbackTextView.userInteractionEnabled = NO ;
                
            }else{
                self.contentView2.hidden = YES ;
            }
        }
        [UIView animateWithDuration:1 animations:^{
            _labeButtonView.hidden = YES;
            _LabeBtnViewHeight.constant = 10;
        }];
       
    }
    if (_headView.selectedIndex == 1) {
        //用户评价时间
        if (!self.evalModel.user_ping_time ||
            [self.evalModel.user_ping_time isEqualToString:@""]) {
            self.contentView1.hidden  = YES ;
            self.contentView2.hidden = YES ;
            self.alertBtn.hidden = NO ;
            self.sureBtn.hidden = YES ;
            return ;
        }
        
        //用户评价了
        self.alertBtn.hidden = YES ;
        NSInteger index = [self.evalModel.user_score integerValue];
        self.contentView1.selectedIndex =index;
        self.evaluateLabel.text = _evalModel.user_hui ;
        
        self.evalteTimeLabel.text =[self stringFromTimeInterval:_evalModel.user_ping_time] ;
        self.contentView1.hidden = NO ;
        self.contentView2.hidden = NO;
        
       
        NSMutableArray *arr = [NSMutableArray array];
        for (NSString *str in _evalModel.user_ping) {
            [arr addObject:str];
        }
        _labeButtonView.labelArry = arr.copy;
        
        //医生回复
        if (![_evalModel.doctor_hui isEqualToString:@""]) {
            self.feedbackTextView.text = self.model.geval_sreply;
            self.feedBackTimeLabel.text =[self stringFromTimeInterval:self.model.sreply_time];
            self.sureBtn.hidden = YES ;
            self.titleLabel.text = @"我的回复";
            self.feedbackTextView.text = _evalModel.doctor_hui;
            self.feedbackTextView.userInteractionEnabled = NO ;
        }else {
            self.feedbackTextView.text = nil ;
            self.sureBtn.hidden = NO ;
            self.feedbackTextView.userInteractionEnabled = YES ;
        }
        [UIView animateWithDuration:1 animations:^{
             _labeButtonView.hidden = NO;
            _LabeBtnViewHeight.constant = [YMLabelButtonView labelButtonHeight:arr.copy selfWidth:SCREEN_WIDTH labelViewType:LabelShowViewType];
        }];
       
    }
}
//截取评论时间
- (NSString *)stringFromTimeInterval:(NSString *)timeIntervalString {

    NSArray *timeArr = [timeIntervalString componentsSeparatedByString:@" "];
    NSString *str = timeArr[0];
    return str ;
}

- (IBAction)didClickEvaluate:(id)sender {
    
    __weak typeof(self) weakSelf = self ;
    if (_headView.selectedIndex == 1) {
        //去评论吧
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.feedbackTextView.text) {
            dic[@"content"] = self.feedbackTextView.text ;
        }
        [dic setObject:@([self.order_idStr integerValue]) forKey:@"order_id"];
        [dic setObject:@"doctor" forKey:@"client"];

        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Repy_Url
                params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    weakSelf.sureBtn.hidden = YES;
                     [weakSelf request];
                });
            }else {
                [weakSelf alertViewShow:error];
            }
        }];
    }    
}
- (DemandOrderModel *)orderModel {
    if (!_orderModel) {
        _orderModel = [DemandOrderModel new];
    }
    return _orderModel ;
}

@end
