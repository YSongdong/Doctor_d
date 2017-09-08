//
//  MYTMingYiAgreementViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTMingYiAgreementViewController.h"
#import "MYTMingYiAgreementTableViewCell.h"

#import "MYTOrderProcessViewController.h"

@interface MYTMingYiAgreementViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong,nonatomic) NSMutableDictionary *dic;

@property (nonatomic, strong) UIView *dateView;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIButton *timeBtn;

@property (strong,nonatomic) NSMutableDictionary *paramsDic;

@property (nonatomic,assign) BOOL hidddenImageView1;
@property (nonatomic,assign) BOOL hidddenImageView2;

@end

@implementation MYTMingYiAgreementViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.paramsDic  = [NSMutableDictionary new];

    [self makeDateView];
    
    [self loadDataWithView:self.view];
    
    UITapGestureRecognizer * pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(panfunction:)];
    
    [self.view addGestureRecognizer:pan];
    
    self.tableView.estimatedRowHeight = 650.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.hidddenImageView1 = YES;
    self.hidddenImageView2 = YES;
}

-(void)panfunction:(UIGestureRecognizer*)pan{
    [self.view  endEditing:YES];
}

//查看合同  数据
- (void)loadDataWithView:(UIView *)view{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@([[self getMember_id] integerValue]) forKey:@"doctor_member_id"];
    [dic setObject:@([self.demandIdStr integerValue]) forKey:@"demand_id"];
    
   // NSLog(@"dic---------------%@",dic);

    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Doctor_Contract_URL
    params:dic withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
       // NSLog(@"showdata---------------%@",showdata);
        
        self.dic = showdata;
        
        NSString *doctor_is_signStr = self.dic[@"doctor_is_sign"];
        NSString *user_is_signStr = self.dic[@"user_is_sign"];
        
        if ([doctor_is_signStr isEqualToString:@"1"] && [user_is_signStr isEqualToString:@"0"]) {
            
            self.hidddenImageView1 = YES;
            self.hidddenImageView2 = NO;
        }
        
        if ([doctor_is_signStr isEqualToString:@"1"] && [user_is_signStr isEqualToString:@"1"]) {
            
            self.hidddenImageView1 = NO;
            self.hidddenImageView2 = NO;
        }

        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *doctor_is_signStr = self.dic[@"doctor_is_sign"];
    
    if ([doctor_is_signStr isEqualToString:@"0"]) {
        
        return 6;
        
    }else{
       return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier1 = @"MingYiAgreementCell1";
    NSString *cellIdentifier2 = @"MingYiAgreementCell2";
    NSString *cellIdentifier3 = @"MingYiAgreementCell3";
    NSString *cellIdentifier4 = @"MingYiAgreementCell4";
    NSString *cellIdentifier5 = @"MingYiAgreementCell5";
    NSString *cellIdentifier6 = @"MingYiAgreementCell6";

    MYTMingYiAgreementTableViewCell *cell;
    
    if (indexPath.row == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        
    }else if (indexPath.row == 1) {
                
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        
        [cell.service_start_timeBtn addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.service_end_timeBtn addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([self.dic[@"demand_type"] isEqualToString:@"1"]) {
            
            cell.service_start_timeBtn.hidden = YES;
        }
        
        cell.service_start_timeBtn.tag = 1;
        cell.service_end_timeBtn.tag = 2;
        
    }else if (indexPath.row == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3] ;
        
        NSString *doctor_is_signStr = self.dic[@"doctor_is_sign"];

        if ([doctor_is_signStr isEqualToString:@"1"]) {
            
            if (self.dic[@"tiparr"]) {
                
                cell.tipArr = [self.dic[@"tiparr"]  mutableCopy];
            }
            
        }else{
            
            cell.tipArr = nil;
        }        
        __weak typeof(self) weakSelf = self;
        cell.selectedTipBlock = ^(NSMutableArray *tipArr) {
            
            //  将array数组转换为string字符串
            NSString *str = [tipArr componentsJoinedByString:@","];
            weakSelf.paramsDic[@"tips"] = [str mutableCopy];
        };

    }else if (indexPath.row == 3) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
        
        cell.other_tipsTF.delegate = self;
        
    }else if (indexPath.row == 4) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
        
        cell.imageView1.hidden = self.hidddenImageView1;
        cell.imageView2.hidden = self.hidddenImageView2;

        
    }else{
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier6];
        
        NSString *doctor_is_signStr = self.dic[@"doctor_is_sign"];
        
        if ([doctor_is_signStr isEqualToString:@"0"]) {
            
            [cell.secondTimeBtn setTitle:@"签订合同" forState:UIControlStateNormal];
            
        }else{
            cell.secondTimeBtn.hidden = YES;
           // [cell.secondTimeBtn setTitle:@"再约时间" forState:UIControlStateNormal];
        }
        
        [cell.secondTimeBtn addTarget:self action:@selector(secondTimeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [cell setDetailsWithDictionary:self.dic];
    
    return cell;
}

-(void)secondTimeBtnClick:(UIButton *)sender{
    
//    NSString *doctor_is_signStr = self.dic[@"doctor_is_sign"];
//    if ([doctor_is_signStr isEqualToString:@"0"]) {
        
        //签订  合同
        [self requestDataWithView:self.view];

//    }else{
        
//        //再约  时间
//        [self getDataWithView:self.view];
//   }
}

////再约  时间  数据
//- (void)getDataWithView:(UIView *)view{
//    
//    if (self.dic[@"order_id"] == nil || [self.dic[@"order_id"] isEqualToString:@""]) {
//        
//        [self alertViewShow:@"请填写订单ID"];
//        return;
//    }
//    
//    if (self.paramsDic[@"service_end_time"] == nil || [self.paramsDic[@"service_end_time"] isEqualToString:@""]) {
//        
//        [self alertViewShow:@"请填写服务结束时间"];
//        return;
//    }
//    
//    NSString *service_start_timeStr = self.paramsDic[@"service_start_time"];
//    NSString *service_end_time = self.paramsDic[@"service_end_time"];
//
//    if (service_start_timeStr == nil) {
//        
//        return;
//    }
//    if ([service_end_time isEqualToString:@""] || service_end_time == nil) {
//        
//        return;
//    }
//    
//    [self.paramsDic setObject:@([self.dic[@"order_id"] integerValue]) forKey:@"order_id"];
//    
//    [self.paramsDic setObject:self.paramsDic[@"service_start_time"] forKey:@"service_start_time"];
//    [self.paramsDic setObject:self.paramsDic[@"service_end_time"] forKey:@"service_end_time"];
//    
//    NSLog(@"paramsDic---------------%@",self.paramsDic);
//    
//    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Update_ServiceTime_URL
//    params:self.paramsDic withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
//        
//        NSLog(@"showdata---------------%@",showdata);
//        
//        MYTOrderProcessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
//        
//        vc.orderIdStr = self.dic[@"order_id"];
//        [vc loadDataWithView:vc.view];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        
//        
////        MYTOrderProcessViewController *popVC =  self.navigationController.viewControllers[2];
////        
////        popVC.orderIdStr = self.dic[@"order_id"];
////        [popVC loadDataWithView:popVC.view];
////        
////        [self.navigationController popToViewController:popVC animated:YES];
//
//    }];
//}

//签订  合同  数据
- (void)requestDataWithView:(UIView *)view{
    
    if (self.demandIdStr == nil || [self.demandIdStr isEqualToString:@""]) {
        
        [self alertViewShow:@"请填写需求ID"];
        return;
    }
    
    if ([self getMember_id] == nil || [[self getMember_id] isEqualToString:@""]) {
        
        [self alertViewShow:@"请填写医生member_id"];
        return;
    }
    NSString *demand_typeStr = self.dic[@"demand_type"];
    NSInteger demand_type =[self.dic[@"demand_type"] integerValue];
   
    if (self.paramsDic[@"service_end_time"] == nil || [self.paramsDic[@"service_end_time"] isEqualToString:@""]) {
            
        [self alertViewShow:@"请填写服务结束时间"];
        return;
    }
    
    
    [self.paramsDic setObject:@([[self getMember_id] integerValue]) forKey:@"doctor_member_id"];
    [self.paramsDic setObject:@([self.demandIdStr integerValue]) forKey:@"demand_id"];
    
    
    if (demand_type > 1) {
        [self.paramsDic setObject:self.paramsDic[@"service_start_time"] forKey:@"service_start_time"];
        [self.paramsDic setObject:self.paramsDic[@"service_end_time"] forKey:@"service_end_time"];
    }else{
         [self.paramsDic setObject:@"" forKey:@"service_start_time"];
        [self.paramsDic setObject:self.paramsDic[@"service_end_time"] forKey:@"service_end_time"];
    }
    

//    if ((![demand_typeStr isEqualToString:@"1"]) || (![demand_typeStr isEqualToString:@"0"])) {
//        
//        [self.paramsDic setObject:self.paramsDic[@"service_start_time"] forKey:@"service_start_time"];
//    }else{
//        
//        [self.paramsDic setObject:@"" forKey:@"service_start_time"];
//    }
//    if (![demand_typeStr isEqualToString:@"1"] || ![demand_typeStr isEqualToString:@"0"]) {
//        [self.paramsDic setObject:self.paramsDic[@"service_end_time"] forKey:@"service_end_time"];
//    
//    }else{
//       [self.paramsDic setObject:@"" forKey:@"service_end_time"];
//    }
   
   // [self.paramsDic setObject:self.paramsDic[@"tips"] forKey:@"tips"];
   // [self.paramsDic setObject:self.paramsDic[@"other_tips"] forKey:@"other_tips"];

    NSLog(@"paramsDic---------------%@",self.paramsDic);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Doctor_Bid_URL
    params:self.paramsDic withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata---------------%@",showdata);
        
        self.hidddenImageView2 = NO;
        
        MYTOrderProcessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
        vc.orderIdStr = showdata;
        
        [vc loadDataWithView:vc.view];
        
        [self.navigationController pushViewController:vc animated:YES];
        
        
//        MYTOrderProcessViewController *popVC =  self.navigationController.viewControllers[2];
//        
//        popVC.orderIdStr = showdata;
//        [popVC loadDataWithView:popVC.view];
//        
//        [self.navigationController popToViewController:popVC animated:YES];
        
    }];
}

- (void)selected:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect rect = self.dateView.frame;
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 300;
            
        }else {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
            self.tableView.scrollEnabled = YES;
        }
        self.dateView.frame = rect;
    }];
    if (sender.tag == 101) {
        
        NSDate *date = self.datePicker.date;
        
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"yyyy-MM-dd HH:mm";
        
        NSString * timeStr = [dateformatter stringFromDate:date];
        
        
        if (self.timeBtn.tag == 1) {
            
            [self.timeBtn setTitle:[NSString stringWithFormat:@"开始时间: %@",timeStr] forState:UIControlStateNormal];

            self.paramsDic[@"service_start_time"] = timeStr;
            
            return;
            
        }else{
            
            NSString *demand_typeStr = self.dic[@"demand_type"];
            //判断是只显示一个时间还是2个时间
            if ([demand_typeStr isEqualToString:@"1"] ||[demand_typeStr isEqualToString:@"0"]) {
                [self.timeBtn setTitle:[NSString stringWithFormat:@"开始时间: %@",timeStr] forState:UIControlStateNormal];
                self.paramsDic[@"service_end_time"] = timeStr;
            }else{
                [self.timeBtn setTitle:[NSString stringWithFormat:@"结束时间: %@",timeStr] forState:UIControlStateNormal];
                
                self.paramsDic[@"service_end_time"] = timeStr;
            }
            
        }        
    }
}


- (void)makeDateView {
    
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM-dd HH:mm";
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
    
    [[self getKeWindow] addSubview:self.dateView];
}

-(UIWindow *)getKeWindow{
    
    return [UIApplication sharedApplication].keyWindow;
}

-(void)timeButtonClick:(UIButton *)sender{
    
    self.timeBtn = sender;
    
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
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES ;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.paramsDic[@"other_tips"] = textField.text ;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
