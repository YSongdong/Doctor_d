//
//  MYTAccountRecordViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/6/22.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTAccountRecordViewController.h"
#import "Masonry.h"
#import "MYTAccountRecordTableViewCell.h"
#import "QFDatePickerView.h"
@interface MYTAccountRecordViewController ()<UITableViewDelegate,UITableViewDataSource,QFDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIView *dateView;
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) NSMutableDictionary *paramsDic;
@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (weak, nonatomic) IBOutlet UILabel *accountTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *accountMoneyLab;
@property(nonatomic,strong)QFDatePickerView *datePickerView ;
@property(nonatomic,assign)BOOL showTimeSelectView;
@property(nonatomic,copy)NSString *selectYearAndMonth;
@end

@implementation MYTAccountRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账单记录";
    
    [self createRightBarButtonItem];
    
    [self makeDateView];
    self.tableView.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    
    self.paramsDic = [NSMutableDictionary new];
    self.dataDic = [NSMutableDictionary new];

    [self loadDataWithView:self.view];
    
}

//请求详情数据
- (void)loadDataWithView:(UIView *)view{
    
    self.paramsDic[@"member_id"] = @([[self getMember_id] integerValue]);
    self.paramsDic[@"type"] = @"all";
    self.paramsDic[@"bill_date"] = _selectYearAndMonth;

    NSLog(@"paramsDic--------------%@",self.paramsDic);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:NewBILL_ACCOUNT_URL
    params:self.paramsDic withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata------------------------%@",showdata);
        
        self.dataDic = showdata;
        
        self.accountTimeLab.text = self.dataDic[@"bill_time"];
        self.accountMoneyLab.text = [NSString stringWithFormat:@"%@元",self.dataDic[@"money"]];
        
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *arr = self.dataDic[@"bill"];
    
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYTAccountRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountRecordCell"];
    
    [cell setDataWithDictionary:self.dataDic[@"bill"][indexPath.row]];

    return cell;
}

- (void)createRightBarButtonItem{
    
    // 自定义导航栏右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width-44, 10, 44, 40);
    [rightBtn setImage:[UIImage imageNamed:@"账单记录"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(onRightTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

// 右侧导航栏点击事件处理
- (void)onRightTap {
    NSLog(@"点击了导航栏右侧按钮");
    
   // [self honorTimeBtnClick];
    
    if (!_datePickerView) {
        _datePickerView = [[QFDatePickerView alloc]initDatePacker];
        _datePickerView.delegage = self;
    }
    if (!_showTimeSelectView) {
        [_datePickerView show:self.view];
    }else{
        [_datePickerView dismiss];
    }
}

//获得时间
-(void)honorTimeBtnClick{
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect rect = self.dateView.frame;
        
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 315;
        }
        else {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        }
        self.dateView.frame = rect;
    }];
}
#pragma mark - 完成  按钮  点击
- (void)selected:(UIButton *)sender {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect rect = self.dateView.frame;
        
        if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height - 315;
        }
        else {
            
            rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        }
        
        self.dateView.frame = rect;
    }];
    
    NSDate *date = self.datePicker.date;
    
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    dateformatter.dateFormat = @"yyyy-MM";
    
    self.paramsDic[@"bill_date"] = [dateformatter stringFromDate:date];
}

- (void)makeDateView {
    
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 315)];
    _dateView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.dateView];

    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, 270)];
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = [UIColor whiteColor];
    [self.dateView addSubview:self.datePicker];
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.titleLabel.textColor = [UIColor whiteColor];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:54.0/255 green:122.0/255 blue:222.0/255 alpha:1];
    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self.dateView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateView.mas_top);
        make.centerX.equalTo(self.dateView.mas_centerX);
        make.width.equalTo(self.dateView.mas_width);
        make.height.equalTo(@45);
    }];
}


#pragma mark  ---筛选日期----
-(void)datePickerView:(QFDatePickerView *)datePickerView disMiss:(BOOL)dismiss{
    _showTimeSelectView = !dismiss;
}
-(void)datePickerView:(QFDatePickerView *)datePickerView selectStr:(NSString *)yearAndMonth{
    _selectYearAndMonth = yearAndMonth;
    [self loadDataWithView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

