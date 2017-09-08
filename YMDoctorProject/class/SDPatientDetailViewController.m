//
//  SDPatientDetailViewController.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SDPatientDetailViewController.h"

#import "DetailHomePageInfoTableViewCell.h"
#import "DetailDosageTableViewCell.h"
#import "SDPatientDetailTableViewCell.h"

#import "PatienDetailModel.h"
#import "Health_historyModel.h"
#import "Medication_drugModel.h"
#define DETAILHOMEPAGEINFOTABLEVIEW_CELL @"DetailHomePageInfoTableViewCell"
#define DETAILDOSAGETABLEVIEW_CELL   @"DetailDosageTableViewCell"
#define SDPATIENTDETAILTABLEVIEW_CELL  @"SDPatientDetailTableViewCell"

@interface SDPatientDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DetailDosageTableViewCellDelegate>

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UIView *bottomView; //就医Viwe
@property (nonatomic,strong) UIButton *bottomBtn; //就医btn
@property (nonatomic,strong) PatienDetailModel *model;
@property (nonatomic,assign) CGFloat cellHeight; //cell的高度

@end

@implementation SDPatientDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"患者信息";
    [self initTableView];
    [self initBottomView];
    [self initloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;

}
-(void)initTableView
{
    _detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Screen_HEIGHt) ];
    [self.view addSubview:_detailTableView];
    _detailTableView.dataSource = self;
    _detailTableView.delegate = self;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.detailTableView registerNib:[UINib nibWithNibName:DETAILHOMEPAGEINFOTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:DETAILHOMEPAGEINFOTABLEVIEW_CELL];
    [self.detailTableView registerNib:[UINib nibWithNibName:DETAILDOSAGETABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:DETAILDOSAGETABLEVIEW_CELL];
    [self.detailTableView registerNib:[UINib nibWithNibName:SDPATIENTDETAILTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDPATIENTDETAILTABLEVIEW_CELL];
}
-(void)initBottomView
{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_HEIGHt-50, SCREEN_WIDTH, 50)];
    [self.view addSubview:_bottomView];
    _bottomView.backgroundColor  =[UIColor btnBroungColor];
    _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomView addSubview:_bottomBtn];
    _bottomBtn.backgroundColor = [UIColor whiteColor];
    [_bottomBtn setTitle:@" 提醒就医" forState:UIControlStateNormal];
    [_bottomBtn setTitleColor:[UIColor btnBroungColor] forState:UIControlStateNormal];
    [_bottomBtn setImage:[UIImage imageNamed:@"patient_remind"] forState:UIControlStateNormal];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.mas_top).offset(7);
        make.left.equalTo(_bottomView.mas_left).offset(20);
        make.right.equalTo(_bottomView.mas_right).offset(-20);
        make.bottom.equalTo(_bottomView.mas_bottom).offset(-7);
        
    }];
    [_bottomBtn addTarget:self action:@selector(onBottonBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    _bottomBtn.layer.cornerRadius = 20;
    _bottomBtn.layer.masksToBounds = YES;
   
}
-(PatienDetailModel *)model
{
    if (!_model) {
        _model = [[PatienDetailModel alloc]init];
    }
    return _model;
}

#pragma mark --- UITableViewSoucre
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return _model.health_history.count;
    }else{
       return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        DetailHomePageInfoTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:DETAILHOMEPAGEINFOTABLEVIEW_CELL forIndexPath:indexPath];
        cell.model =self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        DetailDosageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DETAILDOSAGETABLEVIEW_CELL forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.model = [self.model valueForKey:@"medication_drug"];
        return  cell;
        
    }else if (indexPath.section == 2){
        SDPatientDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDPATIENTDETAILTABLEVIEW_CELL forIndexPath:indexPath];
        cell.model = [_model historyDetail][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 2 && indexPath.row == 0) {
            cell.showTitleLabel = YES;
        }
        if (indexPath.row == 0) {
            cell.showYearAndMonth = YES;
        }
        return cell;
    }
    return nil;

}
#pragma mark  -- UITableViewDelegate ---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 100;
        
    }else if (indexPath.section == 1){
        
        return self.cellHeight;
        
    }else if (indexPath.section == 2){
        Health_historyModel *hostModel =[_model health_history][indexPath.row] ;
        return [SDPatientDetailTableViewCell caseDetailViewHeight:hostModel];
    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0.0f;
    }else{
        return 10.f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 50.0f;
    }else{
        return 0.0f;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *headerview=[[UIView alloc] init];
        headerview.backgroundColor =[UIColor whiteColor];
        UILabel *title = [[UILabel alloc]init];
        title.text = @"就医历史";
        title.font = [UIFont systemFontOfSize:15];
        title.textColor =[UIColor btnBlueColor];
        [headerview addSubview:title];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerview.mas_left).offset(15);
            make.bottom.equalTo(headerview.mas_bottom).offset(-15);
        }];
        return headerview ;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *fooview = [[UIView alloc]init];
    fooview.backgroundColor =[UIColor cellBackgrounColor];
    return fooview;

}

#pragma mark   -- DetailDosageTableViewCellDelegate ---
//计算用药cell的高度
-(void)dosageCellHeigh:(CGFloat)cellHeight
{
    self.cellHeight = cellHeight;

}
#pragma mark  --- 就医提醒------
-(void)onBottonBtnAction:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"health_id"] =self.health_id;
    params[@"member_id"] = [self getMember_id];
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:PatientWarn_Url params:params.copy withModel:nil complateHandle:^(id showdata, NSString *error) {
       
        [weakSelf alertViewShow:error];
        
    }];

}
- (void)alertViewShow:(NSString *)alertString {
    AlertView *alert = [AlertView alertViewWithSuperView:self.view andData:alertString];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --- 数据相关----
-(void)initloadData
{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"member_id"] = [self getMember_id];
    params[@"health_id"] =self.health_id;
    params[@"Type"] = self.type;
    [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:PatientDetail_Url params:params.copy withModel:nil complateHandle:^(id showdata, NSString *error) {
        
        if (!error) {
            weakSelf.model = [PatienDetailModel yy_modelWithDictionary:showdata];
            [weakSelf.detailTableView reloadData];
        }else{
            [weakSelf alertViewShow:error];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
