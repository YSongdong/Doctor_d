//
//  SDPatientManagerViewController.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SDPatientManagerViewController.h"

#import "VIPPatientTableViewCell.h"
#import "PatientManagerModel.h"

#import "SDPatientDetailViewController.h"
#import "TalkViewController.h"

#define VIPTABLEVIEW_CELL  @"VIPPatientTableViewCell"
@interface SDPatientManagerViewController ()<UITableViewDelegate,UITableViewDataSource,VIPPatientTableViewCellDelegate>
@property (nonatomic,strong) UIView *headerView; //头视图
@property (nonatomic,strong) UIButton *vipPatiBtn; // vip患者btn
@property (nonatomic,strong) UIButton *fullowMyBtn; //关注我的患者
@property (nonatomic,strong) UIView *lineView ; // 线条view
@property (nonatomic,strong) UIButton *pageBtn; //记录上次按钮
@property (nonatomic,strong) UITableView *managerTableView;
@property (nonatomic,assign)NSInteger page ;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation SDPatientManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"患者管理";
   // [self leftNavigationBar];
    [self initHeaderView];
    [self initTableView];
    [self requestDataWithUrl];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)initHeaderView
{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _headerView.backgroundColor = [UIColor lineColor];
    [self.view addSubview:_headerView];
    
    self.vipPatiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.vipPatiBtn.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.vipPatiBtn];
    [self.vipPatiBtn setTitle:@"我的VIP患者" forState:UIControlStateNormal];
    self.vipPatiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.vipPatiBtn.selected = YES;
    self.pageBtn = self.vipPatiBtn;
    [self.vipPatiBtn setTitleColor:[UIColor colorWithHexString:@"#4595E6"] forState:UIControlStateSelected];
    [self.vipPatiBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [self.vipPatiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_headerView);
        make.bottom.equalTo(_headerView.mas_bottom).offset(-1);
    }];
    [_vipPatiBtn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //线条view
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#4595E6"];
    [_headerView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipPatiBtn);
        make.width.equalTo(_vipPatiBtn.mas_width);
        make.height.equalTo(@1);
        make.bottom.equalTo(_headerView);
    }];

    //关注我的患者
    self.fullowMyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headerView addSubview:self.fullowMyBtn];
    self.fullowMyBtn.backgroundColor = [UIColor whiteColor];
    [self.fullowMyBtn setTitle:@"关注我的患者" forState:UIControlStateNormal];
    self.fullowMyBtn.selected = NO;
    self.fullowMyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.fullowMyBtn setTitleColor:[UIColor colorWithHexString:@"#4595E6"] forState:UIControlStateSelected];
    [self.fullowMyBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [self.fullowMyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vipPatiBtn.mas_right).offset(1);
        make.right.equalTo(_headerView.mas_right);
        make.centerY.equalTo(_vipPatiBtn.mas_centerY);
        make.width.equalTo(_vipPatiBtn.mas_width);
        make.height.equalTo(_vipPatiBtn.mas_height);
    }];
    [_fullowMyBtn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)initTableView
{
    _managerTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), SCREEN_WIDTH, Screen_HEIGHt-CGRectGetMaxY(_headerView.frame))];
    [self.view addSubview:_managerTableView];
    
    _managerTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _managerTableView.dataSource = self;
    _managerTableView.delegate = self;
    
    [_managerTableView registerNib:[UINib nibWithNibName:VIPTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:VIPTABLEVIEW_CELL];
    self.managerTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
//    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self loadMoreData];
//    }];
//    footer.refreshingTitleHidden = YES ;
//    footer.stateLabel.hidden = YES ;
//    self.managerTableView.footer = footer ;
}

#pragma  mark  -- UITableViewSoucre
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VIPPatientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VIPTABLEVIEW_CELL forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    PatientManagerModel *model = self.dataArr[indexPath.row];
    cell.model =model;
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80;
}
#pragma mark  --- UITableViewDelegate --
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PatientManagerModel *model = self.dataArr[indexPath.row];
    SDPatientDetailViewController *detailVC = [[SDPatientDetailViewController alloc]init];
    if (_vipPatiBtn.selected) {
       
        detailVC.health_id = model.health_id;
        detailVC.type = [NSString stringWithFormat:@"1"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
      
        detailVC.health_id = model.health_id;
        detailVC.type = [NSString stringWithFormat:@"2"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
   
}

#pragma mark   ---点击联系患者按钮事件  ------
-(void)selectdPatientCellIndexPath:(NSIndexPath *)indexPath{

    PatientManagerModel *model = self.dataArr[indexPath.row];
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  
    
    if (_vipPatiBtn.selected) {
        [alterVC addAction:[UIAlertAction actionWithTitle:@"拨打电话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //拨打电话
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.mealth_mobile];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
            
        }]];
    }
    
    [alterVC addAction:[UIAlertAction actionWithTitle:@"在线聊天" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //融云
        TalkViewController *vc = [[TalkViewController alloc]initWithConversationType:1 targetId:model.health_id];
        vc.title = model.mealth_name;
      
        [self.navigationController pushViewController:vc animated:YES];
        
     
       }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alterVC animated:YES completion:nil];


}


#pragma mark  --按钮点击事件 ----
-(void)onBtnAction:(UIButton *) sender
{
    //判断是否选择重复
    if ([sender isEqual:self.pageBtn]) {
        return;
    }else{
       //删除数组
        [self.dataArr removeAllObjects];
        //关注我的患者
        if (sender == _fullowMyBtn) {
            sender.selected = YES;
            _vipPatiBtn.selected = NO;
            
        }else{
            sender.selected = YES;
            _fullowMyBtn.selected = NO;
            
        }
        //记录当前选择按钮
        self.pageBtn = sender;
        //修改线条view的位置
        [self lineViewFrame:sender];
        //重新请求数据
        [self requestDataWithUrl];
    }
}
//修改lineview的位置
-(void)lineViewFrame:(UIButton *)sender
{
    CGRect lineViewFrame = self.lineView.frame;
    lineViewFrame.origin.x = sender.frame.origin.x;
    [UIView animateWithDuration: 1 animations:^{
        self.lineView.frame = lineViewFrame;
    }];
    
}
//刷新
- (void)refreshData {
    self.page = 1;
    [self.dataArr removeAllObjects];
    [self requestDataWithUrl];
}

//加载
- (void)loadMoreData {
    self.page += 1 ;
    [self requestDataWithUrl];
    
}
- (void)requestDataWithUrl {
    NSString *url = Patient_Url ;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.vipPatiBtn.selected) {
        
        [dic setObject:@(1) forKey:@"type"];
    }else{
         [dic setObject:@(2) forKey:@"type"];
    }

    [dic setObject:@([[self getMember_id] integerValue]) forKey:@"member_id"];
   // [dic setObject:@(1739) forKey:@"member_id"];
    [dic setObject:@(self.page) forKey:@"curpage"];
    
    [self requestDataWithUrl:url andParams:dic view:self.view];
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
#pragma mrak  ---- 数据相关--------
//患者管理列表
- (void)requestDataWithUrl:(NSString *)url
                 andParams:(id)params view:(UIView *)view
{
    __weak typeof(self) weakSelf = self;
    KRMainNetTool *tool = [KRMainNetTool new];
    [tool sendRequstWith:url params:params withModel:nil complateHandle:^(id showdata, NSString *error) {

        if (showdata == nil) {
            return ;
        }
        if (!error) {
            [weakSelf.managerTableView.header endRefreshing];
            [weakSelf.managerTableView.footer endRefreshing];
            if ([showdata isKindOfClass:[NSArray class]]||[showdata isKindOfClass:[NSMutableArray  class]]) {
                NSArray *arr = showdata;
                if (arr.count > 0) {
                    
                    for (NSDictionary *dic in showdata) {
                        
                        [weakSelf.dataArr addObject:[PatientManagerModel yy_modelWithDictionary:dic]];
                    }
  
                }
              [weakSelf.managerTableView reloadData];
            }
        }else{
            [weakSelf.view setAlertViewWithTitle:error withCount:2];
            
        
        }
        
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
