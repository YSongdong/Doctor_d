 //
//  MYTOrderProcessViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOrderProcessViewController.h"
#import "MYTOrderProcessTableViewCell.h"
#import "MYTOrderDetailsViewController.h"
#import "MYTMingYiAgreementViewController.h"
#import "MessageView.h"
#import "TalkViewController.h"
#import "TAEvaluateViewController.h"
#import "TextInputView.h"
#import "DemandOrderModel.h"
#import "ClinicRemindView.h"
#import "RefuseOrderView.h"
#import "AlphaView.h"
@interface MYTOrderProcessViewController ()<UITableViewDelegate,UITableViewDataSource,MessageViewDelegate,TextInputViewDelegate,DemandOrderModelDelegate,UITextViewDelegate,ClinicRemindViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//联系患者
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;

@property (strong, nonatomic) NSMutableDictionary *dic;

@property (nonatomic,strong) DemandOrderModel *orderModel ;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NSMutableDictionary *yiZhuDic;
@property (nonatomic, strong) NSMutableDictionary *pingJiaDic;
@property (nonatomic, strong) NSMutableDictionary *refuseDic;

@property (nonatomic, strong) UILabel *instructionsPlaceHolder;
@property (nonatomic, strong) UILabel *evaluatePlaceHolder;

@property (nonatomic,strong) ClinicRemindView *clinicRemindView;
@property (nonatomic,strong) RefuseOrderView *refuseOrderView;

@property (nonatomic, strong) UIView *dateView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic,strong) NSMutableArray *fileImgArr;

@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIView *line3;
@property (nonatomic, strong) UIView *line4;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;
@property (nonatomic, strong) UIView *view3;
@property (nonatomic, strong) UIView *view4;

@property (strong, nonatomic) UILabel *numThreeLab;
@property (strong, nonatomic) UIImageView *threeArrowImgView;
@property (strong, nonatomic) UILabel *finishWorkLab;

@property (strong, nonatomic) MYTOrderProcessTableViewCell *cell;

@property (nonatomic,strong) AlphaView *alphaView; //透明view
@end

@implementation MYTOrderProcessViewController

-(NSMutableArray *)fileImgArr{
    if (_fileImgArr == nil) {
        _fileImgArr = [[NSMutableArray alloc]init];
    }
    return _fileImgArr;
}

- (DemandOrderModel *)orderModel {
    if (!_orderModel) {
        _orderModel = [DemandOrderModel new];
        _orderModel.delegate = self ;
    }
    return _orderModel ;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadDataWithView:self.view];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //联系患者
    self.contactBtn.clipsToBounds = YES;
    self.contactBtn.layer.cornerRadius = self.contactBtn.bounds.size.height/2;
    self.contactBtn.layer.borderWidth = 1;
    self.contactBtn.backgroundColor = [UIColor whiteColor];
    self.contactBtn.layer.borderColor = [UIColor colorWithRed:223/255.0 green:225/255.0 blue:225/255.0 alpha:1].CGColor;
    [self.contactBtn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dic = [NSMutableDictionary new];
    self.pingJiaDic = [NSMutableDictionary new];
    self.yiZhuDic = [NSMutableDictionary new];
    self.refuseDic = [NSMutableDictionary new];
    
    [self makeDateView];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    [self loadDataWithView:self.view];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    [self.view addGestureRecognizer:pan];
    
    
    
}

-(void)panfunction:(UIGestureRecognizer*)pan{
    
    [self.view  endEditing:YES];
}

//订单流程
- (void)loadDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Demand_Order_Process_URL
        params:@{@"order_id":@([self.orderIdStr integerValue])} withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {

       // NSLog(@"showdata--------------------%@",showdata);
            
        self.dic = showdata;
            
        NSString *order_typeStr = self.dic[@"order_type"];
        //鸣医订单
        if ([order_typeStr isEqualToString:@"1"]) {
            
            NSString *mingyi_statusStr = self.dic[@"mingyi_status"];
            
            if ([mingyi_statusStr isEqualToString:@"1"]) {
                
                [self setStyleByIndex:1];
                
            }else if ([mingyi_statusStr isEqualToString:@"2"]) {
                
                [self setStyleByIndex:2];
                
            }else {
                
                [self setStyleByIndex:3];
                
            }

        }else if([order_typeStr isEqualToString:@"2"]){
            //预约订单
            NSString *yuyue_statusStr = self.dic[@"yuyue_status"];
            
            NSLog(@"yuyue_statusStr--------%@",yuyue_statusStr);

            if ([yuyue_statusStr isEqualToString:@"0"]) {
                
                [self setStyleByIndex:0];
                
            }else if ([yuyue_statusStr isEqualToString:@"1"] || [yuyue_statusStr isEqualToString:@"2"] || [yuyue_statusStr isEqualToString:@"3"] ) {
                
                [self setStyleByIndex:1];
                
            }else if ([yuyue_statusStr isEqualToString:@"4"]) {
                
                [self setStyleByIndex:2];
                
            }else {
                
                [self setStyleByIndex:3];
                
            }
        }
            
        [self.tableView reloadData];
    }];
}

// 隐藏  状态
-(void)setStyleByIndex:(NSInteger )index{
    
    UIColor *blueColor  = [UIColor colorWithRed:75.0/255.0 green:166.0/255.0 blue:255.0/255.0 alpha:1];
    UIColor *grayColor  = [UIColor colorWithRed:224.0/255.0 green:225.0/255.0 blue:226.0/255.0 alpha:1];
    
    if (index == 0) {
        
        self.line1.backgroundColor = grayColor;
        self.line2.backgroundColor = grayColor;
        self.line3.backgroundColor = grayColor;
        
        self.view1.backgroundColor = grayColor;
        self.view2.backgroundColor = grayColor;
        self.view3.backgroundColor = grayColor;
        
        //预约订单
        if ([self.orderTypeStr isEqualToString:@"2"]) {
            
            self.line4.backgroundColor = grayColor;
            self.view4.backgroundColor = grayColor;
            
        }
        
    }else if (index == 1) {
        
        self.line1.backgroundColor = blueColor;
        self.line2.backgroundColor = grayColor;
        self.line3.backgroundColor = grayColor;
        
        self.view1.backgroundColor = blueColor;
        self.view2.backgroundColor = grayColor;
        self.view3.backgroundColor = grayColor;
        
        //预约订单
        if ([self.orderTypeStr isEqualToString:@"2"]) {
            
            self.line4.backgroundColor = blueColor;
            self.view4.backgroundColor = blueColor;

        }
        
    }else if (index==2){
        
        self.line1.backgroundColor = blueColor;
        self.line2.backgroundColor = blueColor;
        self.line3.backgroundColor = grayColor;
        
        
        self.view1.backgroundColor = blueColor;
        self.view2.backgroundColor = blueColor;
        self.view3.backgroundColor = grayColor;
        
        
        //预约订单
        if ([self.orderTypeStr isEqualToString:@"2"]) {
            
            self.line4.backgroundColor = blueColor;
            self.view4.backgroundColor = blueColor;
            
        }
        
    }else if (index==3){
       
        self.line1.backgroundColor = blueColor;
        self.line2.backgroundColor = blueColor;
        self.line3.backgroundColor = blueColor;
        
        
        self.view1.backgroundColor = blueColor;
        self.view2.backgroundColor = blueColor;
        self.view3.backgroundColor = blueColor;

        
        self.numThreeLab.textColor = [UIColor colorWithRed:68/255.0 green:149/255.0 blue:230/255.0 alpha:1];
        self.threeArrowImgView.image = [UIImage imageNamed:@"右箭头-图片蓝"];
        self.finishWorkLab.textColor = [UIColor colorWithRed:83/255.0 green:84/255.0 blue:86/255.0 alpha:1];
        
        
        //预约订单
        if ([self.orderTypeStr isEqualToString:@"2"]) {
            
            self.line4.backgroundColor = blueColor;
            self.view4.backgroundColor = blueColor;
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //订单类型
    NSInteger order_type = [self.dic[@"order_type"] integerValue];

    if (order_type == 1) {
        //鸣医订单
        NSInteger mingyi_statusStr = [self.dic[@"mingyi_status"] integerValue];
        if (mingyi_statusStr < 2 ) {
            
            return 2;
            
        }else if (mingyi_statusStr == 4 ) {
            
            return 4;
            
        }else{
            
            return 3;
        }
    }else if (order_type == 2) {
        //预约订单
        NSInteger yuyue_statusStr = [self.dic[@"yuyue_status"] integerValue];
        
        
        if ( yuyue_statusStr < 3) {
            
            return 2;
            
        }else if ( yuyue_statusStr == 6) {
            
            return 4;
            
        }else{
            
            return 3;
        }
    
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier1 = @"OrderProcess1";
    NSString *cellIdentifier2 = @"OrderProcess2";
    NSString *cellIdentifier3 = @"OrderProcess3";
    NSString *cellIdentifier4 = @"OrderProcess4";
    NSString *cellIdentifier5 = @"OrderProcess5";
   
    MYTOrderProcessTableViewCell *cell;
    
    //鸣医订单
    NSString *mingyi_statusStr = self.dic[@"mingyi_status"];
    //预约订单
    NSString *yuyue_statusStr = self.dic[@"yuyue_status"];
    
    
    if (indexPath.row == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        
        [cell.viewDetailsBtn addTarget:self action:@selector(viewDetailsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if (indexPath.row == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        self.cell = cell;
        
        [cell.viewContractBtn addTarget:self action:@selector(viewContractBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.line1 = cell.line1;
        self.view1 = cell.view1;
        

        //预约订单
        if ([self.orderTypeStr isEqualToString:@"2"]) {
            
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
            
            self.line4 = cell.line4;
            self.view4 = cell.view4;
            
           // cell.doctorSignTimeLab.text = self.dic[@"doctor_sign_time"];
            
            [cell.acceptOrderBtn addTarget:self action:@selector(acceptOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];

            [cell.refuseOrderBtn addTarget:self action:@selector(refuseOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
            if ([yuyue_statusStr isEqualToString:@"2"]||[yuyue_statusStr isEqualToString:@"4"] || [yuyue_statusStr isEqualToString:@"5"] || [yuyue_statusStr isEqualToString:@"6"]){
                
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
                
                cell.titeLab.text = @"患者发起预约";
               
                
                [cell.viewContractBtn addTarget:self action:@selector(viewContractBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
    }else if (indexPath.row == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        
        self.line2 = cell.line2;
        self.view2 = cell.view2;
        
        cell.instructionsTextView.editable = NO;
        
        cell.instructionsTextView.delegate = self;
        cell.instructionsTextView.tag = indexPath.row;
        
        if (cell.instructionsTextView.text.length == 0) {
            
            cell.instructionsPlaceHolder.hidden = NO ;
            
        }else{
            
            cell.instructionsPlaceHolder.hidden = YES ;
            
        }
        self.instructionsPlaceHolder = cell.instructionsPlaceHolder;
        
        NSString *order_typeStr = self.dic[@"order_type"];
        //鸣医订单
        if ([order_typeStr isEqualToString:@"1"]) {
            
          //  NSString *mingyi_statusStr = self.dic[@"mingyi_status"];
            
             if ([mingyi_statusStr isEqualToString:@"2"]) {
            
                [cell.sureCommitBtn addTarget:self action:@selector(sureCommitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.applyArbitrationBtn addTarget:self action:@selector(applyArbitrationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                //上传医嘱图片
                [cell.instructionsBtn1 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.instructionsBtn2 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.instructionsBtn3 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.instructionsBtn4 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];

                cell.instructionsTextView.editable = YES;
                 
             }
        }else if([order_typeStr isEqualToString:@"2"]){
            
            //预约订单

            if ([yuyue_statusStr isEqualToString:@"4"]) {
                
                [cell.sureCommitBtn addTarget:self action:@selector(sureCommitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell.applyArbitrationBtn addTarget:self action:@selector(applyArbitrationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                
                //上传医嘱图片
                [cell.instructionsBtn1 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.instructionsBtn2 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.instructionsBtn3 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.instructionsBtn4 addTarget:self action:@selector(instructionsBtnClick:) forControlEvents:UIControlEventTouchUpInside];

                cell.instructionsTextView.editable = YES;
            }
        }
        //判断提交按钮状态
        if ([mingyi_statusStr isEqualToString:@"3"] ||[mingyi_statusStr isEqualToString:@"4"] ||[yuyue_statusStr isEqualToString:@"5"] || [yuyue_statusStr isEqualToString:@"6"]) {
            //医生已填写医嘱
            cell.sureCommitBtn.backgroundColor = [UIColor lightGrayColor];
            cell.sureCommitBtn.userInteractionEnabled = NO;
            [cell.sureCommitBtn setTitle:@"已提交" forState:UIControlStateNormal];
        }
    }else if (indexPath.row == 3) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
        
        self.line3 = cell.line3;
        self.view3 = cell.view3;
        
        self.numThreeLab = cell.numThreeLab;
        self.threeArrowImgView = cell.threeArrowImgView;
        self.finishWorkLab = cell.finishWorkLab;

        [cell.viewEvaluateBtn addTarget:self action:@selector(viewEvaluateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.evaluateTextView.editable = NO ;
        cell.evaluateTextView.delegate = self ;
        cell.evaluateTextView.tag = indexPath.row;
        
        if ([self.dic[@"doctor_ping"] isEqualToString:@""]) {
            
            cell.evaluatePlaceHolder.hidden = NO ;
            
        }else{
            
            cell.evaluatePlaceHolder.hidden = YES ;
            
        }
        self.evaluatePlaceHolder = cell.evaluatePlaceHolder;
        
        
        NSString *order_typeStr = self.dic[@"order_type"];
       
        if ([order_typeStr isEqualToString:@"1"]) {
            
            if ([mingyi_statusStr isEqualToString:@"3"] || [mingyi_statusStr isEqualToString:@"4"]) {
                
                NSString *doctor_pingStr = self.dic[@"doctor_ping"];

                if ([doctor_pingStr isEqualToString:@""] || doctor_pingStr == nil) {
                    
                    [cell.sureCommitBtn2 addTarget:self action:@selector(sureCommitBtn2Click:) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.evaluateTextView.editable = YES;
                }
                
            } {
                
                
            }
            
        }else if([order_typeStr isEqualToString:@"2"]){
            
            //预约订单
            //NSString *yuyue_statusStr = self.dic[@"yuyue_status"];
            
            if ([yuyue_statusStr isEqualToString:@"5"] || [yuyue_statusStr isEqualToString:@"6"]) {
                
            
                NSString *doctor_pingStr = self.dic[@"doctor_ping"];
                
                if ([doctor_pingStr isEqualToString:@""] || doctor_pingStr == nil) {
                    
                    [cell.sureCommitBtn2 addTarget:self action:@selector(sureCommitBtn2Click:) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.evaluateTextView.editable = YES;

                }
            }
        }
        
        //判断提交按钮状态
        NSString *doctor_ping = self.dic[@"doctor_ping"];
        if (![doctor_ping isEqualToString:@""]) {
            //医生已填写医嘱
            cell.sureCommitBtn2.backgroundColor = [UIColor lightGrayColor];
            cell.sureCommitBtn2.userInteractionEnabled = NO;
            [cell.sureCommitBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.sureCommitBtn2 setTitle:@"已提交" forState:UIControlStateNormal];
        }else{
            cell.sureCommitBtn2.backgroundColor = [UIColor btnBroungColor];
            [cell.sureCommitBtn2 setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
            cell.sureCommitBtn2.userInteractionEnabled = YES;
            [cell.sureCommitBtn2 setTitle:@"确定提交" forState:UIControlStateNormal];
            
        }
        cell.viewEvaluateBtn.layer.borderColor = [UIColor btnBroungColor].CGColor;
        [cell.viewEvaluateBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
    }
    [cell setDetailsWithDictionary:self.dic];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height ;
    
    if (indexPath.row == 0) {
        
        height = 90;
        
    }else if (indexPath.row == 1) {
        
        height = 80;

    }else if (indexPath.row == 2) {
        
        height = 230;
        
    }else {
        
        height = 200;

    }
    return height;
}

//接受 预约
-(void)acceptOrderBtnClick:(UIButton *)sender{
    
    MYTMingYiAgreementViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTMingYiAgreementViewController"];
    vc.demandIdStr = self.dic[@"demand_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

//拒绝 预约
-(void)refuseOrderBtnClick:(UIButton *)sender{
    
    if (self.refuseOrderView == nil) {
        
        RefuseOrderView *view = [RefuseOrderView initWithXib];
        
        self.refuseOrderView = view;
    }
    
    self.refuseOrderView.frame = self.view.frame;
    
    [self.refuseOrderView show];
    
    [self.refuseOrderView.sureBtn addTarget:self action:@selector(refuseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.refuseOrderView.refuseReasonTextView.delegate = self;
    self.refuseOrderView.refuseReasonTextView.tag = 5;
}


//拒绝 预约 确定
-(void)refuseBtnClick:(UIButton *)sender{

    self.refuseDic[@"order_id"] = @([self.dic[@"order_id"] integerValue]);
    
    NSLog(@"refuseDic------------%@",self.refuseDic);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:RejectYuyue_URL params:self.refuseDic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata--------------------%@",showdata);
                
        [self.refuseOrderView miss];
    }];
}


//查看详情
-(void)viewDetailsBtnClick:(UIButton *)sender{
    
    MYTOrderDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderDetailsViewController"];
    vc.demandIdStr = self.dic[@"demand_id"];

    [self.navigationController pushViewController:vc animated:YES];
}

//查看合同
-(void)viewContractBtnClick:(UIButton *)sender{
    
    self.hidesBottomBarWhenPushed = YES;
    MYTMingYiAgreementViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTMingYiAgreementViewController"];
    vc.demandIdStr = self.dic[@"demand_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

//确认提交  医嘱
-(void)sureCommitBtnClick:(UIButton *)sender{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    MYTOrderProcessTableViewCell *cell =[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (![cell.instructionsTextView.text isEqualToString:@""] || self.fileImgArr.count > 0 ) {
        //创建透明view
        self.alphaView =[[AlphaView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.alphaView];
        
        
        ClinicRemindView *view = [ClinicRemindView initWithXib];
        
        self.clinicRemindView = view;
        
        self.clinicRemindView.delegate  = self;
        
        [self.view addSubview:self.clinicRemindView];
        
        
        __weak typeof(self) weakSelf = self;
        [self.clinicRemindView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view.mas_top).offset(200);
            make.left.equalTo(weakSelf.view.mas_left).offset(40);
            make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-200);
            make.right.equalTo(weakSelf.view.mas_right).offset(-40);
        }];
        
        // [self.clinicRemindView show];
        
        [self.clinicRemindView.sureBtn addTarget:self action:@selector(clinicRemindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.clinicRemindView.timePickerBtn addTarget:self action:@selector(timePickerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.clinicRemindView.contentTextView.delegate = self;
        self.clinicRemindView.contentTextView.tag = 4;
        
        
    }else{
    
        [self alertViewShow:@"请填写嘱咐或者上传照片！"];
    }
    
}

//点击取消按钮回调方法 ClinicRemindViewDelegate
-(void)selectdCancelBtn
{
    [self.alphaView removeFromSuperview];

}

//就医提醒 确定
-(void)clinicRemindBtnClick:(UIButton *)sender{
    
    //移除透明view
    [self.alphaView removeFromSuperview];
    
    
    self.yiZhuDic[@"order_id"] = @([self.dic[@"order_id"] integerValue]);
    
    self.yiZhuDic[@"instructions_img"] = self.fileImgArr;
    
    NSLog(@"yiZhuDic------------%ld",self.yiZhuDic.count);
    
  
    
    [[KRMainNetTool sharedKRMainNetTool]upLoadData:SubInstructions_URL params:self.yiZhuDic andData:self.fileImgArr waitView:nil complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata--------------------%@",showdata);
        
        [self.clinicRemindView miss];
         
        [self loadDataWithView:self.view];
        
        self.cell.instructionsPlaceHolder.hidden = YES;
        
        //按钮颜色标致不可用
        self.clinicRemindView.sureBtn.userInteractionEnabled= NO;
        
    }];
   

}

- (void)instructionsBtnClick:(UIButton *)sender{
    
    self.selectedBtn = sender;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
            pickerController.delegate = self;
            pickerController.allowsEditing = YES;
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相册
        UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
        pickerController.delegate = self;
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel  handler:^(UIAlertAction * _Nonnull action) {
        //取消
    }];
    [controller addAction:action];
    [controller addAction:action1];
    [controller addAction:action2];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

-(NSString *)getImgName{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%@_%f.jpg",[self getMember_id], a];
    return timeString;
}

//上传头像
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.03);
    
    NSString *timeString =[self getImgName];
    NSDictionary * imgDict = @{
                               @"data":data,
                               @"name":timeString
                               };
    [self.fileImgArr addObject: imgDict];
    
    [self.selectedBtn setImage:image forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//申请仲裁
-(void)applyArbitrationBtnClick:(UIButton *)sender{
    
    TextInputView *view = [TextInputView textViewLoadFromXibWithTitleString:@"申请仲裁原因"];
    [view inputViewShow];
    view.delegate = self ;
    return ;
}

- (void)didClickSureBtn:(NSString *)content {
    
    if ([content isEqualToString:@""]) {
        
        [self alertViewShow:@"请输入仲裁原因"];
        return ;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@([self.dic[@"order_id"] integerValue])
            forKey:@"order_id"];
    
    self.orderModel.type = applyArbitrate ;
    [self.orderModel centerBtnOperatorWithUrl:APPLY_ZHONGCAI_URL params:dic andImages:nil andView:self.view];
}

//确认提交 评价
-(void)sureCommitBtn2Click:(UIButton *)sender{
    
    self.pingJiaDic[@"order_id"] = @([self.dic[@"order_id"] integerValue]);

    NSLog(@"pingJiaDic------------%@",self.pingJiaDic);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:EVALUATE_URL
    params:self.pingJiaDic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata--------------------%@",showdata);
        
        [self.tableView reloadData];
        
    
        [self loadDataWithView:self.view];

    }];
}

//查看评价
-(void)viewEvaluateBtnClick:(UIButton *)sender{
    
    TAEvaluateViewController *vc = [[UIStoryboard storyboardWithName:@"Evaluate" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"TAEvaluateViewControlellerIdentifier"];
    vc.demand_model = self.model ;
    vc.order_idStr = self.dic[@"order_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

//联系患者
-(void)contactBtnClick:(UIButton *)sender{
    
    MessageView *messageView = [MessageView messageWithXib];
    messageView.delegate = self ;
   
    if (self.dic[@"member_mobile"]) {
        
        messageView.phone = self.dic[@"member_mobile"] ;
    }
    [messageView messageShow];
}

- (void)callNumber:(NSString *)number {
    if (!number) {
        [self alertViewShow:@"未获取到雇主电话号码"];
        return ;
    }
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.dic[@"member_mobile"]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}

- (void)sendMessageOperator:(id)value {
    //联系患者
    NSString *huanxinid = self.dic[@"huanxinid"];
    TalkViewController *vc = [[TalkViewController alloc]initWithConversationType:1 targetId:huanxinid];
    vc.title = self.dic[@"leagure_name"];
    NSLog(@"%@",huanxinid);
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)textViewDidChange:(UITextView *)textView{
    
    self.textView = textView;
    
    if (self.textView.tag == 2) {
        
        //主述
        self.yiZhuDic[@"instructions_content"] = self.textView.text;

    }else{
        
        //评价
        self.pingJiaDic[@"doctor_ping"] = self.textView.text;
    }
    
    //复诊提醒
    if (self.textView.tag == 4){
        
        self.yiZhuDic[@"fuzhen_tips"] = self.textView.text;
    }
    
    //拒绝预约
    if (self.textView.tag == 5){
        
        self.refuseDic[@"note"] = self.textView.text;
    }
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.textView = textView;
    
    if (self.textView.tag == 2) {
        
        //主述
        self.yiZhuDic[@"instructions_content"] = self.textView.text;

        if (self.textView.text.length == 0) {
            
            self.instructionsPlaceHolder.hidden = NO ;
            
        }
        
    }else{
        
        //评价
        self.pingJiaDic[@"doctor_ping"] = self.textView.text;

        if (self.textView.text.length == 0) {
    
            self.evaluatePlaceHolder.hidden = NO ;
    
        }
    }
    
    //复诊提醒
    if (self.textView.tag == 4){
        
        self.yiZhuDic[@"fuzhen_tips"] = self.textView.text;
        
        if (self.textView.text.length == 0) {
            
            self.clinicRemindView.placeHolderLab.hidden = NO ;
            
        }
        CGRect cliniViewFrame = self.clinicRemindView.frame;
        cliniViewFrame.origin.y += 80;
        [UIView animateWithDuration:1 animations:^{
            self.clinicRemindView.frame = cliniViewFrame;
        }];
        
    }
    
    //拒绝预约
    if (self.textView.tag == 5){
        
        self.refuseDic[@"note"] = self.textView.text;
        
        if (self.textView.text.length == 0) {
            
            self.refuseOrderView.reasonPlaceHolderLab.hidden = NO ;
            
        }
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    self.textView = textView;
    
    if (self.textView.tag == 2) {
        
        self.instructionsPlaceHolder.hidden = YES ;

    }else{
        
        self.evaluatePlaceHolder.hidden = YES ;
    }
    
    //复诊提醒
    if (self.textView.tag == 4){
        
        self.clinicRemindView.placeHolderLab.hidden = YES ;
        
        CGRect cliniViewFrame = self.clinicRemindView.frame;
        cliniViewFrame.origin.y -= 80;
        [UIView animateWithDuration:1 animations:^{
            self.clinicRemindView.frame = cliniViewFrame;
        }];

    }
    
    //拒绝预约
    if (self.textView.tag == 5){
        
        self.refuseOrderView.reasonPlaceHolderLab.hidden = YES ;

    }
    
    return YES ;
}


- (void)selected:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.dateView.frame;
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
        }
        else {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            self.tableView.scrollEnabled = YES;
            
        }
        self.dateView.frame = rect;
    }];
    if (sender.tag == 101) {
        
        NSDate *date = self.datePicker.date;
        
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"yyyy-MM-dd";
        
        NSString * timeStr = [dateformatter stringFromDate:date];
        
        [self.clinicRemindView.timePickerBtn setTitle:timeStr forState:UIControlStateNormal];
        
        self.yiZhuDic[@"fuzhen_time"] = timeStr;
        
    }
}


- (void)makeDateView {
    
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 315)];
    _dateView.backgroundColor = [UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1];
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 270)];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.backgroundColor = [UIColor whiteColor];
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 45)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    cancle.titleLabel.textColor = [UIColor whiteColor];
    cancle.titleLabel.font = [UIFont systemFontOfSize:15];
    cancle.backgroundColor = [UIColor clearColor];
    cancle.tag = 100;
    [cancle addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 10 - 50, 0, 50, 45)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.tag = 101;
    button.titleLabel.textColor = [UIColor whiteColor];
    UIView *linview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    linview.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview];
    UIView *linview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 1)];
    linview1.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1];
    [self.dateView addSubview:linview1];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:button];
    [self.dateView addSubview:cancle];
    [self.dateView addSubview:self.datePicker];
    
    [self.view addSubview:self.dateView];
    UILabel *titlesLabel = [[UILabel alloc]init];
    [self.dateView addSubview:titlesLabel];
    titlesLabel.font = [UIFont systemFontOfSize:15];
    titlesLabel.text = @"请选择时间";
    titlesLabel.textColor = [UIColor whiteColor];
    
    [titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.top.equalTo(self.dateView.mas_top);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.width.lessThanOrEqualTo(@250);
    }];
    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//     [window addSubview:self.dateView];

    [[self getKeWindow] insertSubview:self.dateView atIndex:0];
    
}

-(UIWindow *)getKeWindow{
    
    return [UIApplication sharedApplication].keyWindow;
}

//时间选择
-(void)timePickerBtnClick:(UIButton *)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect rect = self.dateView.frame;
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
           
        }
        else {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            self.tableView.scrollEnabled = YES;
            
        }
        self.dateView.frame = rect;
    }];
    
     [[self getKeWindow] bringSubviewToFront:self.dateView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
