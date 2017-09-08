//
//  DemandProgressViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandProgressViewController.h"
#import "DemandProgressTableViewCell.h"
#import "DemandOrderTableViewCell.h"
#import "MessageView.h"
#import "TakingAlertView.h"
#import "DemandOrderModel.h"
#import "TextInputView.h"
#import "ContractViewController.h"
#import "EvaluateViewController.h"
#import "TalkingViewController.h"
#import "TAEvaluateViewController.h"


@interface DemandProgressViewController ()<UITableViewDelegate,UITableViewDataSource,TakingAlertViewDelegate,TextInputViewDelegate,MessageViewDelegate,DemandOrderModelDelegate,DemandProgressTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *centerBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic,strong)DemandOrderModel *orderModel ;
@property (nonatomic,strong)NSArray *data ;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (nonatomic,assign)NSInteger orderStatus ;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightWidth;

@end

@implementation DemandProgressViewController

- (void)dealloc {
    
    [self.orderModel removeObserver:self forKeyPath:@"dataList"];
}
- (DemandOrderModel *)orderModel {
    if (!_orderModel) {
        _orderModel = [DemandOrderModel new];
        _orderModel.delegate = self ;
    }
    return _orderModel ;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _tableView.sectionFooterHeight = 10 ;
    [self getListData];
    [self.orderModel addObserver:self forKeyPath:@"dataList"
                         options:NSKeyValueObservingOptionNew context:""];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requetOrderProgress];
    }];
}

- (void)getListData {
    
    NSArray *array = @[@"报名投标",@"洽谈需求",@"签订合同 开始工作",@"完成工作 确认付款",@"订单完成 双方互评"];
    NSArray *contentArray = @[@"您已投标成功",@"洽谈成功 等待雇主选标",@"签订合同，开始工作",@"完成工作，申请付款，如有异议申请医盟仲裁。",@"双方互评"];
    
    NSMutableArray *mutArray = [NSMutableArray array];
    for (int i = 0; i < [contentArray count]; i ++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:contentArray[i] forKey:@"content"];
        [dic setObject:array[i] forKey:@"title"];
        [dic setObject:[NSString stringWithFormat:@"%d",i+1] forKey:@"step"];
        [mutArray addObject:dic];
    }
    self.data = [mutArray mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //需求订单
    [self requetOrderProgress];
}


- (void)requetOrderProgress {
    NSString *url ;
    if (self.type == demandOrderType) {
        url =Demand_Order_Detail_URL ;
    }
    //2雇佣订单
    if (self.type == employType) {
        url =Employer_order_Detail_URL ;
    }
    if (self.type == incruableType) {
        url = Incruable_Detail_URL ;
    }
    [self.orderModel requestOrderDetailWithParams: @{@"demand_id":self.model.demand_id,
                                                     @"store_id":[self  getStore_id]}url:url
                                         andModel:self.model];

}


- (void)setSlectedIndex:(NSInteger)slectedIndex {
    _slectedIndex = slectedIndex ;
}
- (IBAction)contactEmployer:(id)sender {
    
    MessageView *messageView = [MessageView messageWithXib];
    messageView.delegate =self ;
    if (self.model.demand_phone) {
//        messageView.phone = self.model.demand_phone ;
        messageView.phone = self.model.member_mobile ;
    }
    [messageView messageShow];
}
- (void)callNumber:(NSString *)number {
    if (!number) {
        [self alertViewShow:@"未获取到雇主电话号码"];
        return ;
    }
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",number]] options:nil completionHandler:nil];
}

- (void)sendMessageOperator:(id)value {
    
    TalkingViewController *vc = [[TalkingViewController alloc]initWithConversationType:ConversationType_PRIVATE targetId:self.model.ry_usid];
    if (self.userName &&![self.userName isEqual:[NSNull null]]) {
        vc.title = self.userName;
        
        
    }
    vc.portraint = self.model.demand_portrait ;
    [self.navigationController pushViewController:vc animated:YES];
}


//中间按钮
- (IBAction)centerBtnOperator:(id)sender {

    //洽谈成功
    switch (_slectedIndex) {
        case 1:{

            TakingAlertView *alert = [TakingAlertView takingViewWithXIBWithtitles:self.orderModel.talkArrays];
            alert.titleLabel.text = @"请确认一下信息";
            alert.type = multiplyType ;
            alert.delegate = self ;
            [alert viewShow];
        }break;
            //签合同
        case 2:{
            [self performSegueWithIdentifier:@"progressIntoContractIdentifier" sender:sender];
        }break ;
            //提醒付款
        case 4:{
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            if (self.model.demand_id) {
                [dic setObject:self.model.demand_id forKey:@"demand_id"];
            }
            if (self.model.store_id) {
                [dic setObject:self.model.store_id forKey:@"store_id"];
            }
            self.orderModel.type = applyPayment ;
            [self.orderModel centerBtnOperatorWithUrl:APPLY_PAY_URL params:dic andImages:nil andView:self.view];
        }break ;
            //评价
            
        case 5:{
            
            if ([self.model.order_isEvaluate integerValue] == 0) {
                
                [self performSegueWithIdentifier:@"progressIntoEvaluateIdentifier" sender:nil];
                    
                }else {
                    TAEvaluateViewController *vc = [[UIStoryboard storyboardWithName:@"Evaluate" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
                    vc.demand_model = self.model ;
                    [self.navigationController pushViewController:vc animated:YES];
                }
        }break ;
        case 6:{
            if ([self.model.order_isEvaluate integerValue] == 0) {
                
                [self performSegueWithIdentifier:@"progressIntoEvaluateIdentifier" sender:nil];
                
            }else {
                TAEvaluateViewController *vc = [[UIStoryboard storyboardWithName:@"Evaluate" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
                vc.demand_model = self.model ;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }break ;
        default:
            break;
    }
}

- (IBAction)rightBtnOperator:(id)sender {
    

    if (_slectedIndex == 1) {
        TakingAlertView *alert = [TakingAlertView takingViewWithXIBWithtitles:self.orderModel.talkFailureArray];
        alert.titleLabel.text = @"请选择洽谈失败原因(单选)";
        alert.type = singleType ;
        alert.delegate = self ;
        
        [alert viewShow];
    }
    //通知已开始工作
    if (_slectedIndex == 2) {
        self.orderModel.type = beginWork;
        [self.orderModel centerBtnOperatorWithUrl:START_WORK_URL
                                           params:nil
                                        andImages:nil andView:self.view];
    }
    
    //申请仲裁
    if (_slectedIndex == 4) {
        TextInputView *view = [TextInputView textViewLoadFromXibWithTitleString:@"申请仲裁原因"];
        [view inputViewShow];
        view.delegate = self ;
        return ;
    }
    //他的评价
    if (_slectedIndex == 5 || _slectedIndex == 6) {
        
        TAEvaluateViewController *vc = [[UIStoryboard storyboardWithName:@"Evaluate" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
        vc.demand_model = self.model ;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didClickSureBtn:(NSString *)content {
    
    if ([content isEqualToString:@""]) {
        [self alertViewShow:@"请输入仲裁原因"];
        return ;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.model.demand_id) {
        [dic setObject:self.model.demand_id forKey:@"demand_id"];
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


//洽谈成功
- (void)didClickSureBtn:(id)value
                andType:(ChoiceType)type {
    NSString *url ;
    //表示洽谈失败
    
    
    if (type == singleType) {
            url = CONTACT_FAILURE_URL ;
        self.orderModel.type = contactFailure ;
        
    }
    //洽谈成功
    else if (type == multiplyType){
        self.orderModel.type = contactApproprite ;

        if (self.type == employType) {
            url = EMPLOY_CONTACT_APPROPRITE ;
            
        }else {
            
            url = CONTACT_APPROPRITE ;
        }
    }
    if (self.model.demand_id) {
        [value setObject:self.model.demand_id forKey:@"demand_id"];
    }
    if ([self getStore_id ]) {
        [value setObject:[self getStore_id] forKey:@"store_id"];
    }
    [self.orderModel centerBtnOperatorWithUrl:url params:value andImages:nil andView:self.view ];
}
- (void)operatorFailureWithReason:(NSString *)reason {
    if ([self.tableView.header isRefreshing]) {
        [self.tableView.header endRefreshing];
    }
    [self alertViewShow:reason];
}
- (void)operatorSuccessWithReason:(NSString *)reason {
     if (self.orderModel.type == contactApproprite) {
        self.centerBtn.hidden = YES ;
        self.rightBtn.hidden = YES ;
        self.alertLabel.hidden = NO ;
         [self.alertLabel setText:@"洽谈成功,等待雇主选标"];
    }
        [self alertViewShow:reason];
    [self.tableView.header beginRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }
    return 5 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DemandProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressCellTitleIdentifeir"];
           cell.model = self.model ;
            return cell ;
        }
        if (indexPath.row == 1) {
            DemandOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellIdentifeir"];
            cell.model = self.model ;
            cell.type = @"1";
            if (self.type == employType) {
                cell.orderType = 1;
            }else {
                cell.orderType = 0 ;
            }
            return cell ;
        }
    }
    
    DemandProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProgressIdentifier"];
    cell.delegate = self ;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    cell.dataList = self.data[indexPath.row];
    cell.model = self.model ;
    return cell ;

}
//右边的按钮
- (void)didClickCellRightBtnEvent:(NSInteger)type {
    
    //表示查看合同
  if (type == 3) {
      [self performSegueWithIdentifier:@"progressIntoContractIdentifier" sender:@(type)];
        }
    //上传处方
    if (type == 5) {
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"progressIntoContractIdentifier"]) {
        ContractViewController *contractVC = segue.destinationViewController;
        contractVC.model = self.model ;
        if (self.model.contract_id) {
            if ([self.model.demand_qb integerValue] == 3) {
                if (!self.model.ascertain1
                    || [self.model.ascertain1 isEqual:[NSNull null]]) {
                    contractVC.title = @"签订合同";
                }else{
                    contractVC.title = @"查看合同";
                }
            }
            contractVC.haveConstract = YES;
        }else {
            contractVC.title = @"发起合同";
        }
    }
    if ([segue.identifier isEqualToString:@"progressIntoEvaluateIdentifier"]) {
        EvaluateViewController *vc = segue.destinationViewController ;
        vc.model = self.model ;
    }
}
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return 10 ;
    }
    return 0.0001f ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return  45 ;
        }
        return 95;
    }
    return 90 ;
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

//拍照
- (void)didClickChoicePicture:(UIButton *)sender {
    
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:nil message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"选取照片"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                       [self takePhoto:sender];
                                                   }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                        [self takePicture:sender];
                                                    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction * _Nonnull action) {}];
    [controll addAction:action];
    [controll addAction:action2];
    [controll addAction:action3];
    [self presentViewController:controll animated:YES completion:nil];
}
- (void)takePhoto:(UIButton *)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *controller = [[UIImagePickerController alloc]init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
        controller.allowsEditing = YES ;
        
        controller.delegate = self ;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
        
    }
}
- (void)takePicture:(UIButton *)sender {
    
    if ([ UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *controller = [[UIImagePickerController alloc]init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera ;
        controller.delegate = self ;
        [self presentViewController:controller animated:YES completion:nil];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.model.order_id) {
        [dic setObject:self.model.order_id forKey:@"order_id"];
    }
    self.orderModel.type = uploadPrescription ;
    
    NSArray *images = @[@{@"data":data,
                          @"name":@"goods_image1"}];
    [self.orderModel centerBtnOperatorWithUrl:UploadPrescription_Url
                                       params:dic
                                    andImages:images
                                      andView:self.view];
    
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)setOrderStatus:(NSInteger)orderStatus {
    
    _orderStatus = orderStatus ;
    NSString *title ;
    NSString *notSureTitle ;
    if (orderStatus  == 1) {
        //用户未选标
        if (_slectedIndex == 1) {
            title = @"洽谈成功";notSureTitle = @"洽谈失败";
            self.alertLabel.hidden = YES ;
            self.centerBtn.hidden = NO ;
            self.rightBtn.hidden = NO ;
        }
        if (_slectedIndex == 2) {
            self.alertLabel.hidden = NO ;
            [self.alertLabel setText:@"洽谈成功,等待雇主选标"];
            self.centerBtn.hidden = YES ;
            self.rightBtn.hidden = YES ;
        }
        else if (_slectedIndex > 2
                 || _slectedIndex == 0) {
            self.alertLabel.hidden = NO ;

            [self.alertLabel setText:@"订单出错"];
            self.centerBtn.hidden = YES ;
            self.rightBtn.hidden = YES ;
            
        }

    }
    //选标成功
    else if (orderStatus  == 2) {
        if (_slectedIndex == 2) {
            self.alertLabel.hidden = YES ;
            self.centerBtn.hidden = NO ;
            self.rightBtn.hidden = NO ;
            title = @"发起合同";
            if (self.model.contract_id) {
                title = @"签订合同";
            }
            self.rightWidth.constant = 0.0001f ;
            [self.view updateConstraintsIfNeeded];
        }
        if (_slectedIndex == 3) {
                self.alertLabel.hidden = NO ;
                [self.alertLabel setText:@"等待合同签订完成"];
                self.centerBtn.hidden = YES ;
                self.rightBtn.hidden = YES;
        }
        if (_slectedIndex == 4) {
            self.alertLabel.hidden = YES ;
            self.centerBtn.hidden = NO ;
            self.rightBtn.hidden = NO ;
            title = @"申请收款";
            notSureTitle = @"申请鸣医通仲裁";
        }
        if (_slectedIndex == 5) {
            self.alertLabel.hidden = YES ;
            self.centerBtn.hidden = NO ;
            self.rightBtn.hidden = NO ;
            title = @"对Ta评价";
            notSureTitle = @"Ta的评价";
        }
        if (_slectedIndex == 6) {
            self.alertLabel.hidden = YES ;
            self.centerBtn.hidden = NO ;
            self.rightBtn.hidden = NO ;
            title = @"对Ta评价";
            notSureTitle = @"Ta的评价";
        }
    }
    //订单失败
    if (orderStatus == 3) {
        _slectedIndex = 0 ;
    }
    if (_slectedIndex == 0) {
        self.alertLabel.text = @"订单失败";
        title = @"投标失败";
        notSureTitle = @"退出";
        [self.centerBtn setBackgroundColor:[UIColor textLabelColor]];
        [self.rightBtn setBackgroundColor:[UIColor lightGrayColor]];
        self.centerBtn.enabled = NO ;
    }
    [self.centerBtn setTitle:title forState:UIControlStateNormal];
    [self.rightBtn setTitle:notSureTitle forState:UIControlStateNormal];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"dataList"]) {
        if ([self.tableView.header isRefreshing]) {
            [self.tableView.header endRefreshing];
        }
        [self.tableView reloadData];
        self.orderStatus = [self.model.order_apply integerValue];
    }
}

@end
