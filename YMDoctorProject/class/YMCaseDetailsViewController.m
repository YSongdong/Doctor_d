

//
//  YMCaseDetailsViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/17.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMCaseDetailsViewController.h"

#import "YMCaseDetailViewTableViewCell.h"
#import "YMDoctorHeaderInformationView.h"
#import "YMCaseBriefingView.h"
#import "MYTHomePageViewController.h"

#import "YMCaseDetailsModel.h"
#import "CDCaseDetailModel.h"
//#import <NSObject+YYModel.h>
//#import "YMDoctorHomePageViewController.h"

static NSString *const caseDetailViewCell = @"caseDetailViewCell";

@interface YMCaseDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *caseDetailsTableView;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)YMCaseBriefingView *caseBriefingView;

@property(nonatomic,strong)YMDoctorHeaderInformationView *headerView;

@property(nonatomic,strong)YMCaseDetailsModel *model;



@end

@implementation YMCaseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"案例详情";
     self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initView];
    [self requertData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [self initTopView];
    [self initTableView];
}

-(void)requertData{
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Case_FullDetail params:@{ @"case_id":@([self.case_id integerValue])}withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        if ([showdata isKindOfClass:[NSDictionary class]]||[showdata isKindOfClass:[NSMutableDictionary class]]) {
           
            weakSelf.model = [YMCaseDetailsModel yy_modelWithJSON:showdata];
            [weakSelf refreshView];
        }
    }];
}

-(void)refreshView{
    NSLog(@"%@",_model);
    _headerView.model = [_model doctronInfo];
    _caseBriefingView.model = _model;
    
    [_caseDetailsTableView reloadData];
}

-(void)initTopView{
    _topView = [[UIView alloc]init];
    _topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(180);
    }];
    
    _headerView = [[YMDoctorHeaderInformationView alloc]init];
    [_topView addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(_topView);
        make.height.mas_equalTo(120);
    }];
    
    _caseBriefingView = [[YMCaseBriefingView alloc]init];
    _caseBriefingView.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:_caseBriefingView];
    [_caseBriefingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(_topView);
        make.top.equalTo(_headerView.mas_bottom);
    }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputDoctorDetails)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [_headerView addGestureRecognizer:tapGestureRecognizer];
    
}

-(void)initTableView{
    _caseDetailsTableView = [[UITableView alloc]init];
    _caseDetailsTableView.backgroundColor = [UIColor clearColor];
    _caseDetailsTableView.separatorStyle = NO;
    _caseDetailsTableView.delegate = self;
    _caseDetailsTableView.dataSource = self;
    [_caseDetailsTableView registerClass:[YMCaseDetailViewTableViewCell class] forCellReuseIdentifier:caseDetailViewCell];
    [self.view addSubview:_caseDetailsTableView];
    [_caseDetailsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_topView.mas_bottom).offset(10);
    }];
}


- (CGFloat)tableView:(UITableView* )tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;//section头部高度
    }
    return  0;
    
}
- (UIView *)tableView:(UITableView* )tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview=[[UIView alloc] init];
    headerview.backgroundColor =[UIColor whiteColor];
    UILabel *title = [[UILabel alloc]init];
    title.text = @"案例详情";
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = RGBCOLOR(64, 149, 255);
    [headerview addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerview.mas_left).offset(37);
        make.bottom.equalTo(headerview.mas_bottom).offset(-5);
    }];
    return headerview ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_model caseDetail].count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    YMCaseDetailsMonthInformationModel *monthModel= [_model caseDetail][indexPath.section];
    
    YMCaseDetailsDayInformationModel *dayModel =[monthModel monthDetail][indexPath.row];
    
    return [YMCaseDetailViewTableViewCell caseDetailViewHeight:dayModel];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    YMCaseDetailsMonthInformationModel *model= [_model caseDetail][section];
    return model.detail.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMCaseDetailViewTableViewCell *cell = [[YMCaseDetailViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:caseDetailViewCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    YMCaseDetailsMonthInformationModel *model= [_model caseDetail][indexPath.section];
    
    cell.model =[model monthDetail][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.showTitleLabel = YES;
        cell.titleStr = _model.case_title;
    }
    
    if (indexPath.row == 0) {
        cell.showYearAndMonth = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)inputDoctorDetails{
//    MYTHomePageViewController *vc =  [self.storyboard instantiateViewControllerWithIdentifier:@"MYTHomePageViewController"];
//    vc.store_id = _model.store_id;
//    [vc requestListDataWithView:vc.view];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
