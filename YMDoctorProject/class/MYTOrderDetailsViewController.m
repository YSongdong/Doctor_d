//
//  MYTOrderDetailsViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/24.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOrderDetailsViewController.h"
#import "MYTOrderDetailsTableViewCell.h"



#import "MYTMingYiAgreementViewController.h"

@interface MYTOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *participateBtn;

@property (strong, nonatomic) NSMutableDictionary *dic;
@property (nonatomic,strong) NSString *completeStr;  //获取是否实名认证
@property (nonatomic,strong) NSString *demand_type; //订单类型
@property (nonatomic,assign)  BOOL isBag;  //判断投标是否已结束
@end

@implementation MYTOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dic = [NSMutableDictionary new];
    
    [self loadDataWithView:self.view];
}

//请求详情数据
- (void)loadDataWithView:(UIView *)view{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@([[self getMember_id] integerValue]) forKey:@"doctor_member_id"];
    [dic setObject:@([self.demandIdStr integerValue]) forKey:@"demand_id"];
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Demand_Order_Detail_URL
    params:dic withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        self.dic = showdata;
        NSLog(@"showdata------%@",showdata);
        //判断订单类型 1-询医问诊 2-市内坐诊 3-活动讲座
        self.demand_type =  showdata[@"demand_type"];
        if ([self.dic[@"is_bid"] isEqualToString:@"0"]) {
            
            [self.participateBtn addTarget:self action:@selector(participateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{

            self.participateBtn.backgroundColor = [UIColor lightGrayColor];
            [self.participateBtn setTitle:@"已投标" forState:UIControlStateNormal];
            [self.participateBtn  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        //判断投标是否结束
        [self getIsOrder];
        
        [self.tableView reloadData];
    }];
    //获取认证状态
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:Person_Info_Url params:@{   @"member_id":@([[self getMember_id] integerValue])  } withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if (showdata == nil){
            return ;
        }
      
        self.completeStr = showdata[@"complete_status"];
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier1 = @"OrderDetailsCell1";
    NSString *cellIdentifier2 = @"OrderDetailsCell2";
    NSString *cellIdentifier3 = @"OrderDetailsCell3";
    NSString *cellIdentifier4 = @"OrderDetailsCell4";
    NSString *cellIdentifier5 = @"OrderDetailsCell5";

    NSString *cellIdentifier6 = @"OrderDetailsCell6";
    NSString *cellIdentifier7 = @"OrderDetailsCell7";
    MYTOrderDetailsTableViewCell *cell;
    
    if (indexPath.row == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];

    }else if (indexPath.row == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        
    }
    else if (indexPath.row == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        
    }
    else if (indexPath.row == 3) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];

    }else if (indexPath.row == 4) {
       
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier5];
        
    }else if (indexPath.row == 5) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier6];

    }else if (indexPath.row == 6) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier7];
    }
    
    [cell setDetailsWithDictionary:self.dic];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height;
    if (indexPath.row == 0) {
        
        height = 90 ;
        
    }else if (indexPath.row == 6){
        
        height = 80;

    }else if (indexPath.row == 2){
        //判断订单类型 1-询医问诊 2-市内坐诊 3-活动讲座
        NSLog(@"demand_type===%@",self.demand_type);
        if ([self.demand_type isEqualToString:@"1"]) {
            height = 40 ;
        }else{
            height = 80;
        }
        
    }else{
        
        height = 40;

    }
    return height;
}
//判断投标是否已经结束
-(void)getIsOrder
{
    NSString *nowTime= [self getCurrentTimes];
    NSString *xuqieTime =self.dic[@"demand_time"];
    NSString *endTime = self.dic[@"demand_time2"];
    
    //结束时间等于空
    if (![endTime isEqualToString:@""]) {
        self.isBag  = [self dateTimeDifferenceWithStartTime:nowTime endTime:endTime];
        if (self.isBag) {
            _participateBtn.backgroundColor = [UIColor lightGrayColor];
            [_participateBtn setTitle:@"投标结束" forState:UIControlStateNormal];
        }
    }
    if (![xuqieTime isEqualToString:@""]) {
        self.isBag  = [self dateTimeDifferenceWithStartTime:nowTime endTime:xuqieTime];
        if (self.isBag) {
            _participateBtn.backgroundColor = [UIColor lightGrayColor];
            [_participateBtn setTitle:@"投标结束" forState:UIControlStateNormal];
        }
    }
    if (self.isState) {
        _participateBtn.backgroundColor = [UIColor lightGrayColor];
        [_participateBtn setTitle:@"投标结束" forState:UIControlStateNormal];
        self.isBag = YES;
    }
    
    if ([self.current_docter_signed isEqualToString:@"0"]) {
        _participateBtn.backgroundColor = [UIColor lightGrayColor];
        [_participateBtn setTitle:@"投标结束" forState:UIControlStateNormal];
    }
    
}
//跳转到合同页面
- (void)participateBtnClick:(UIButton *)sender {
    if (!_isBag) {
        if ([self.current_docter_signed isEqualToString:@"0"]) {
            
            [self alertViewShow:@"该订单已选择医生服务! "];
        }else{
            
            //判断是否通过实名认证
            if ([self.completeStr isEqualToString:@"5"] ||[self.completeStr isEqualToString:@"40"] ) {
                MYTMingYiAgreementViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTMingYiAgreementViewController"];
                vc.demandIdStr = self.dic[@"demand_id"] ;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
                [self alertViewShow:@"资质审核还未通过，暂不能进行此操作"];
            }
        
        }
        
    }else{
        if ([self.current_docter_signed isEqualToString:@"0"]) {
            
            [self alertViewShow:@"该订单已选择医生服务! "];
        }else{
            [self alertViewShow:@"投标时间已结束!"];
        }
        
    }

}
- (void)alertViewShow:(NSString *)alertString {
    AlertView *alert = [AlertView alertViewWithSuperView:self.view andData:alertString];
    [alert show];
}
-(BOOL )dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    BOOL  isBag;
    if (value < 0 ) {
        isBag = YES;
    }else{
        isBag =  NO;
    }
    return isBag;
}
//获取当前的时间
-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
