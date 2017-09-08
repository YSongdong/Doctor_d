//
//  DemandOrderDetailViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandOrderDetailViewController.h"
#import "DemandDetailTableViewCell.h"
#import "DemandOrderModel.h"
#import "DemandProgressViewController.h"
#import "DemandContentViewController.h"
#import "EvaluateViewController.h"
#import "MessageView.h"
#import "TextInputView.h"
#import "ContractViewController.h"
#import "TakingAlertView.h"
#import "TAEvaluateViewController.h"
#import "TalkingViewController.h"
@interface DemandOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate,TextInputViewDelegate,TakingAlertViewDelegate,DemandOrderModelDelegate,MessageViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIButton *notSureBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactEmployer;
@property (nonnull,nonatomic,strong)DemandOrderModel *orderModel ;
@property (nonatomic,strong) DemandModel *params ;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBtnWidth;

@property (nonatomic,strong)MessageView *messageView ;
@property (nonatomic,assign)NSInteger schedual ;

@property (nonatomic,strong)NSString *detailUrl ;

@property (nonatomic,strong)NSString *userNames ;

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@end

@implementation DemandOrderDetailViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;

    [self  requestDetailInfo];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.sectionFooterHeight = 10 ;
    self.automaticallyAdjustsScrollViewInsets = NO ;
    [self setUP];
}

- (void)dealloc {
    
    NSLog(@"%s",__func__);
}


- (void)setUP {
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestDetailInfo];
    }];
}


- (void)setSchedual:(NSInteger)schedual {
    
    _schedual = schedual ;
    NSString *title ;
    NSString *notSureTitle ;
    

    //需求订单 和疑难杂症
    //order_apply 1.等待选标  2 选标成功  3 失败
    NSInteger orderStatus = [self.params.order_apply integerValue];
    
    NSLog(@"orderStatus:%ld,schedual:%ld",orderStatus,_schedual);
    
    if (orderStatus  == 1) {
        //用户未选标
        if (_schedual == 1){
            title = @"洽谈成功";notSureTitle = @"洽谈失败";
        }
       else if (_schedual == 2) {
            self.alertLabel.hidden = NO ;
            [self.alertLabel setText:@"洽谈成功,等待雇主选标"];
            self.sureBtn.hidden = YES ;
            self.notSureBtn.hidden = YES ;
        }
        //啥子玩意儿
         else if (_schedual > 2 || _schedual == 0) {
             self.alertLabel.hidden = NO ;
             [self.alertLabel setText:@"订单出错"];
             self.sureBtn.hidden = YES ;
             self.notSureBtn.hidden = YES ;
        }
    }
    //选标成功
    if (orderStatus  == 2) {
        
//        if (_schedual == 1) {
//            self.alertLabel.hidden = NO ;
//            [self.alertLabel setText:@"订单出错"];
//            self.sureBtn.hidden = YES ;
//            self.notSureBtn.hidden = YES ;
//        }
        if (_schedual == 2) {
             title = @"发起合同";
            if (self.params.contract_id) {
                title = @"签订合同";
            }
            self.alertLabel.hidden = YES ;
            self.notSureBtn.hidden = NO ;
            self.sureBtn.hidden = NO ;
            _rightBtnWidth.constant = 0.00f;
        }
        if (_schedual == 3) {
            self.alertLabel.hidden = NO ;
                [self.alertLabel setText:@"等待合同签订完成"];
                self.sureBtn.hidden = YES ;
                self.notSureBtn.hidden = YES;
        }
        if (_schedual == 4) {
            title = @"申请收款";
            self.alertLabel.hidden = YES ;
            self.notSureBtn.hidden = NO ;
            self.sureBtn.hidden = NO ;
            notSureTitle = @"申请鸣医通仲裁";
        }
        if (_schedual == 5) {
            self.alertLabel.hidden = YES ;
            self.notSureBtn.hidden = NO ;
            self.sureBtn.hidden = NO ;
            title = @"对Ta评价";
            notSureTitle = @"Ta的评价";
        }
    }
    //洽谈失败
    if (orderStatus == 3) {
         _schedual = 0 ;
        if (_schedual == 0) {
            self.alertLabel.text = @"订单失败";
            title = @"投标失败";
            notSureTitle = @"退出";
            [self.sureBtn setBackgroundColor:[UIColor textLabelColor]];
            [self.notSureBtn setBackgroundColor:[UIColor lightGrayColor]];
            self.sureBtn.enabled = NO ;
        }
    }
    [self.sureBtn setTitle:title forState:UIControlStateNormal];
    [self.notSureBtn setTitle:notSureTitle forState:UIControlStateNormal];
       [self.view updateConstraints];
}

- (void)setDetailType:(OrderDetailType)detailType {
    _detailType = detailType ;
    if (self.detailType == demandDetailType) {
        _detailUrl = Demand_Order_Detail_URL ;
    }
    if (self.detailType == employerDetailType) {
        _detailUrl = Employer_order_Detail_URL ;
    }
    if (self.detailType == incruableDetailTyppe) {
        _detailUrl = Incruable_Detail_URL ;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (DemandOrderModel *)orderModel {
    if (!_orderModel) {
        _orderModel = [DemandOrderModel new];
        _orderModel.delegate =self ;
    }return _orderModel ;
}

- (DemandModel *)params {
    if (!_params) {
        _params = [DemandModel new];
    }return _params ;
}

- (void)requestDetailInfo {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.demand_id){
        dic[@"demand_id"]= self.demand_id ;
    }
    if ([self getStore_id]) {
        dic[@"store_id"] = [self getStore_id];
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:_detailUrl params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            if ([showdata[@"_demand"] isKindOfClass:[NSDictionary class]]) {
                [self.params setValuesForKeysWithDictionary:showdata[@"_demand"]];
            }
            if ([showdata[@"_order"] isKindOfClass:[NSDictionary class]]) {
                [self.params setValuesForKeysWithDictionary:showdata[@"_order"]];
            }
            if ([showdata[@"_contract"]isKindOfClass:[NSDictionary class]]) {
                [self.params setValuesForKeysWithDictionary:showdata[@"_contract"]];
            }
            self.userNames = showdata[@"_demand"][@"member_names"];
            
        self.schedual = [self.params.demand_schedule integerValue];
        [self.tableView reloadData];
    }
    }];

}
//zhongjian anniu
- (IBAction)didClick_WithDifferentOperate:(id)sender {
    NSInteger index = [self.params.demand_schedule integerValue];
    if (index == 1) {
        //洽谈妥当
         TakingAlertView *alert = [TakingAlertView takingViewWithXIBWithtitles:self.orderModel.talkArrays];
         alert.titleLabel.text = @"请确认一下信息";
         alert.type = multiplyType ;
        alert.delegate = self ;
         [alert viewShow];
         return ;
    }
    
    if (index ==2){
        // 发起合同
        [self performSegueWithIdentifier:@"contractIdentifier" sender:nil];
    }
    //申请收款
    if (index == 4){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.params.demand_id) {
            [dic setObject:self.params.demand_id forKey:@"demand_id"];
        }
        if (self.params.store_id) {
            [dic setObject:self.params.store_id forKey:@"store_id"];
        }
        self.orderModel.type = applyPayment ;
        [self.orderModel centerBtnOperatorWithUrl:APPLY_PAY_URL params:dic andImages:nil andView:self.view];
    }
    
    
  if (index == 5 || index == 6) {
      
      if ([self.params.order_isEvaluate integerValue] == 0) {
          [self performSegueWithIdentifier:@"goEvaluateOtherPerson" sender:nil];

      }else {
          TAEvaluateViewController *vc = [[UIStoryboard storyboardWithName:@"Evaluate" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
          
          vc.demand_model = self.params ;
          [self.navigationController pushViewController:vc animated:YES];
      }
      return ;
    }
    // 评价
}

//youbian anniu
- (IBAction)didClick_unSuccessOperate:(id)sender {
    if (_schedual == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
    //洽谈失败
    if (_schedual == 1) {
        TakingAlertView *alert = [TakingAlertView takingViewWithXIBWithtitles:self.orderModel.talkFailureArray];
        alert.titleLabel.text = @"请选择洽谈失败原因(单选)";
        alert.delegate = self ;
        alert.type = singleType ;
        [alert viewShow];
    }
  //通知已开始工作
    if (_schedual == 2){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.params.demand_id) {
            [dic setObject:self.params.demand_id forKey:@"demand_id"];
        }
        self.orderModel.type = beginWork ;
        [self.orderModel centerBtnOperatorWithUrl:START_WORK_URL
                                           params:dic
                                        andImages:nil andView:self.view];
    }
    //申请仲裁
    if (_schedual == 4) {
      TextInputView *view = [TextInputView textViewLoadFromXibWithTitleString:@"申请仲裁原因"];
       [view inputViewShow];
        view.delegate = self ;
        return ;
    }
    //他的评价
    if (_schedual == 5) {
        TAEvaluateViewController *vc = [[UIStoryboard storyboardWithName:@"Evaluate" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
        vc.demand_model = self.params ;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark--------DemandOrderDelegate
- (void)operatorSuccessWithReason:(NSString *)reason {

    if (reason) {
        [self alertViewShow:reason];
    }
    [self requestDetailInfo];

}

- (void)operatorFailureWithReason:(NSString *)reason {
    
    [self alertViewShow:reason];
    [self requestDetailInfo];
}


//jiao tan anniu
- (IBAction)contact_EmployerOperate:(id)sender {
    
    MessageView *messageView = [MessageView messageWithXib];
    messageView.delegate =self ;
    if (self.params.demand_phone) {
        messageView.phone = self.params.demand_phone ;
    }
    [messageView messageShow];
}
// call
- (void)callNumber:(NSString *)number {
    
    if (!number) {
        [self alertViewShow:@"未获取到雇主电话号码"];
        return ;
    }

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]]options:nil completionHandler:nil];
}
- (void)sendMessageOperator:(id)value {
    
      TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:self.params.ry_usid];
    if (self.userNames &&
        ![self.userNames isEqual:[NSNull null]]) {
        vc.title =self.userNames;
    }
    vc.portraint = self.params.demand_portrait ;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark-------textInputTextViewDelegate

//申请仲裁
- (void)didClickSureBtn:(NSString *)content {
    if ([content isEqualToString:@""]) {
        [self alertViewShow:@"请输入仲裁原因"];
        return ;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.params.demand_id) {
        [dic setObject:self.params.demand_id forKey:@"demand_id"];
    }
    if ([self getStore_id]) {
        [dic setObject:[self getStore_id] forKey:@"store_id"];
    }
    [dic setObject:content forKey:@"arbitration"];
    self.orderModel.type = applyArbitrate ;
    [self.orderModel centerBtnOperatorWithUrl:APPLY_ZHONGCAI_URL
                                       params:dic
                                    andImages:nil
                                      andView:self.view];
}

#pragma mark------------TakingAlertDelegate
//点击洽谈妥当
- (void)didClickSureBtn:(id)value
                andType:(ChoiceType)type{
    
    NSString *url ;
    //表示洽谈失败
    if (type == singleType) {
        url = CONTACT_FAILURE_URL ;
        self.orderModel.type = contactFailure ;
    }
    //洽谈成功
    else if (type == multiplyType){
        //表示雇佣订单洽谈成功
        self.orderModel.type = contactApproprite ;
        if (self.detailType == employerDetailType) {
            url = EMPLOY_CONTACT_APPROPRITE ;
        }
        else {
            url = CONTACT_APPROPRITE ;
        }
    }

    if (self.params.demand_id) {
        [value setObject:self.params.demand_id forKey:@"demand_id"];
    }
    if ([self getStore_id ]) {
        [value setObject:[self getStore_id] forKey:@"store_id"];
    }
    [self.orderModel centerBtnOperatorWithUrl:url params:value andImages:nil andView:self.view ];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DemandDetailTableViewCell *cell ;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"detailTableCellUserInfoIdentifier"];
    }
    if (indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"orderProgressDetailIdentifier"];
    }
    if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"DetailOrderCellIdentifier"];
    }
    cell.model = self.params ;
    if (self.detailType == employerDetailType) {
     cell.orderType = 1 ;
    }else {
        cell.orderType = 0 ;
    }
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return  176 ;
    }
    if (indexPath.section == 1) {
        return 145 ;
    }
    return 144 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f ;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"intoProgressViewControllerIdentifier" sender:nil];
    }
    if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"DemandcontentIdentifier" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    if ([segue.identifier isEqualToString:@"intoProgressViewControllerIdentifier"]) {
        DemandProgressViewController *vc = (DemandProgressViewController *)segue.destinationViewController ;
        vc.model = self.params ;
        vc.userName = self.userNames ;
        if (self.detailType == demandDetailType) {
            vc.type = demandOrderType ;
        }
        else if (self.detailType == employerDetailType){
            vc.type = employType ;
        }
        else {
            vc.type = incruableType ;
        }
        vc.slectedIndex = self.schedual ;
    }
    if ([segue.identifier isEqualToString:@"DemandcontentIdentifier"]) {
    DemandContentViewController *contentVC = (DemandContentViewController *)segue.destinationViewController ;
        contentVC.model = self.params ;
    }
    if ([segue.identifier isEqualToString:@"goEvaluateOtherPerson"]) {
            EvaluateViewController *vc = (EvaluateViewController *)segue.destinationViewController ;
        vc.model = self.params ;
    }
    if ([segue.identifier isEqualToString:@"contractIdentifier"]) {
        
       ContractViewController *contractVc = segue.destinationViewController ;
        if (self.params.contract_id) {
            if ([self.params.demand_qb integerValue] == 3) {
                if (!self.params.ascertain1
                    || [self.params.ascertain1 isEqual:[NSNull null]]) {
                    contractVc.title = @"签订合同";
                }else{
                    contractVc.title = @"查看合同";
                }
            }
            contractVc.haveConstract = YES;
        }else {
            contractVc.title = @"发起合同";
        }
        contractVc.model = self.params ;
    }
}

@end
