//
//  DemandHallDetailViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandHallDetailViewController.h"
#import "DemandHallDetailTableViewCell.h"
#import "DemandHallModel.h"
#import "DemandOrderDetailViewController.h"
@interface DemandHallDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DemandHallModelDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn; //拒绝雇用
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic,strong)DemandHallModel *demandModel;


@end
@implementation DemandHallDetailViewController
- (void)dealloc {
    
    [self.demandModel removeObserver:self forKeyPath:@"model"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self.demandModel addObserver:self forKeyPath:@"model"
                          options:NSKeyValueObservingOptionNew context:nil];
}
//拒绝雇用

- (IBAction)refuseBtnClicked:(id)sender {
    
    //
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.model.demand_id) {
        dic[@"demand_id"] = self.model.demand_id ;
    }
    if ([self getStore_id]) {
        dic[@"store_id"] = [self getStore_id];
    }
    [self alertViewControllerShowWithTitle:@"是否残忍拒绝雇用?" message:nil sureTitle:@"确定" cancelTitle:@"取消" andHandleBlock:^(id value, NSString *error) {
        if ([value isEqual:@(1)]) {
            [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Refuse_Url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                if (!error) {
                    [self alertViewShow:@"您已拒绝雇用"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
            }];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
   // self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = NO;
    
    [_sureBtn setTitle:_buttonTitle forState:UIControlStateNormal];
    [self request];
}

- (DemandHallModel *)demandModel {
    
    if (!_demandModel) {
        _demandModel = [DemandHallModel new];
        _demandModel.delegate = self ;
        
    }
    return _demandModel ;
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    if (self.type == 0) {
        self.widthConstraint.constant = 0.0001f;
        [self.view updateConstraints];
    }
}

- (void)setup {
    
     _tableView.sectionFooterHeight = 10 ;
  if ([self.model.order_member integerValue] == 1) {
        self.sureBtn.enabled = NO ;
        [self.sureBtn setBackgroundColor:[UIColor colorWithRGBHex:0xB8B8B8]];
    }
}

- (void)request{
    

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.model.demand_id) {
     [dic setObject:self.model.demand_id forKey:@"demand_id"];
    }
    if ([self getStore_id]) {
        [dic setObject:[self getStore_id] forKey:@"store_id"];
    }
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    self.demandModel.params = dic ;
    [self.demandModel getDemandHallDetailWithView:self.view andModel:self.model];
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    
    _buttonTitle= buttonTitle ;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.model) {
        return 3 ;
    }
    
    return 0 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemandHallDetailTableViewCell *cell ;
    if (indexPath.section == 0) {
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
        cell = [tableView dequeueReusableCellWithIdentifier:@"contentDetailIdentifier"];
    }
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"orderProgressIdentifier"];
        
    }
    if (indexPath.section == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"demandHallDetailIdentifeir"];
    }
    cell.type  = self.type ;
    cell.model = self.model ;
    return cell ;
}
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 99 + 45;
    }
    if(indexPath.section == 1) {
        return 129;
    }
    DemandModel *demandModel = (DemandModel *)self.model ;
    return [demandModel getDemandDetailHeight];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 0.0001f ;
}

//立即投标
- (IBAction)imediatily_Tender:(id)sender {

    
    
    if (![self getStore_id]) {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:notExitStoreIDNotification object:nil];
        return ;
    }
    if (![self getMember_id]) {
        [self alertViewShow:@"请重新登录"];
        return ;
    }
    NSString *title ;
    NSString *url ;
    if (self.type == 0) {
        title = @"是否确认投标";
        url = SUBMIT_ORDER_URL ;
    }
    else {
        title = @"是否接受雇佣";
        url = RECEIVE_EMPLOYER ;
    }
    [self alertViewControllerShowWithTitle:title message:nil sureTitle:@"确定" cancelTitle:@"取消" andHandleBlock:^(id value,NSString *error) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.model.demand_id) {
            [dic setObject:self.model.demand_id forKey:@"demand_id"];
        }
        if ([self getMember_id]) {
            [dic setObject:[self getMember_id] forKey:@"member_id"];
        }
        if ([self getStore_id]) {
            [dic setObject:[self getStore_id] forKey:@"store_id"];
        }
        if (value ) {
            
            [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:url params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                if (!error) {
                    if (self.type == 0) {
                        [self alertViewShow:@"投标成功,去我的订单查看吧"];
                    }
                    if (self.type == 1) {
                        [self alertViewShow:@"成功接受雇佣"];
                    }
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    DemandOrderDetailViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"DemandOrderDetailIdentifier"];
                        if (self.type == 1) {
                            //雇佣订单
                            vc.detailType = employerDetailType ;
                        }
                        else {
                            vc.detailType = demandDetailType ;
                        }
                        vc.demand_id = self.model.demand_id ;
                        [self.navigationController pushViewController:vc animated:YES];
    
                    });
                }else {
                    [self alertViewShow:error];
                }
                
            }];
        }
    }];
}

- (void)getDataFailureWithReason:(NSString *)reason {
    
    [self alertViewShow:reason];
}


- (void)requestDataSucess:(NSString *)success {
    [self.sureBtn setTitle:@"已投标" forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self alertViewShow:success];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context   {

    if ([keyPath isEqualToString:@"model"]) {
        if (self.type == 0) {
            NSInteger status  = [self.model.demand_condition integerValue] ;
            _sureBtn.hidden = NO ;
            switch (status) {
                case 0:[self setTitleString:@"立即投标" andEnable:YES];break;
                case 1:{[self setTitleString:@"已经投标" andEnable:NO];};break ;
                case 2:{[self setTitleString:@"我的需求" andEnable:NO];};break ;
                case 3:{[self setTitleString:@"投标已满" andEnable:NO];};break ;
                case 4:{[self setTitleString:@"投标已结束" andEnable:NO];};break ;
                case 5:{[self setTitleString:@"投标失效" andEnable:NO];};break ;
                case 6:{[self setTitleString:@"投标已结束" andEnable:NO];};break ;
                default:{[self setTitleString:@"立即投标" andEnable:YES];};break;
            }
        }else {
            [self setTitleString:@"接受雇佣" andEnable:YES];
        }
    [self.tableView reloadData];
}
}
- (void)setTitleString:(NSString *)tiles
             andEnable:(BOOL)enable {
    self.sureBtn.enabled = enable ;
    [self.sureBtn setTitle:tiles forState:UIControlStateNormal];
  if (enable) {
        [self.sureBtn setBackgroundColor:[UIColor orangesColor]];
    }
    else {
        [self.sureBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
}


@end
