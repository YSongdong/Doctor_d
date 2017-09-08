//
//  NewOrderViewController.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NewOrderViewController.h"

#import "MYTOrderDetailsViewController.h"
#import "MYTOrderProcessViewController.h"


#import "OrderTypeView.h"
#import "OrderStateView.h"

#import "DemandModel.h"

#import "NewOrderTableViewCell.h"
#define NEWORDERTABLEVIEW_CELL  @"NewOrderTableViewCell"
@interface NewOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTypeViewDelegate,OrderStateViewDelegate>

@property(nonatomic,strong) UITableView *orderTableView;
@property(nonatomic,strong) NSMutableArray *dataListArr;
@property(nonatomic,strong) OrderStateView *stateView;

@property(nonatomic,assign) NSInteger type; //类型
@property(nonatomic,strong) NSString *status_mark; //状态
@property(nonatomic,assign) NSInteger curpage; //页码

@end

@implementation NewOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"鸣医订单";
    self.type = 1;
    self.status_mark = @"all";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTypeView];
    [self initTableView];
    [self requestDataWithUrl];
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
   
}
-(void)initTypeView{
    OrderTypeView *typeView = [[OrderTypeView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 45)];
    typeView.delegate = self;
    [self.view addSubview:typeView];
    
    self.stateView = [[OrderStateView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(typeView.frame), SCREEN_WIDTH, 45)];
    self.stateView.delegate = self;
    [self.view addSubview:self.stateView];
    
}
-(void)initTableView{

    self.orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stateView.frame), SCREEN_WIDTH, Screen_HEIGHt-90) style:UITableViewStyleGrouped];
    [self.view addSubview:self.orderTableView];
    self.orderTableView.dataSource = self;
    self.orderTableView.delegate = self;
    
    //注册cell
    [self.orderTableView registerNib:[UINib nibWithNibName:NEWORDERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:NEWORDERTABLEVIEW_CELL];
    self.orderTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.orderTableView.footer = footer ;
    self.curpage = 1;
    
}

#pragma mark --- UITableViewSoucre
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataListArr.count;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NewOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NEWORDERTABLEVIEW_CELL forIndexPath:indexPath];
    cell.model = self.dataListArr[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark  --- UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10 ;
    }
    return 0.0001f ;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandModel *model = self.dataListArr[indexPath.section];
    NSString *doctorSignedStr = model.doctor_signed;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    self.hidesBottomBarWhenPushed = YES;
    
    NSString *orderStr = model.order_type;
    if ([orderStr isEqualToString:@"1"]) {
        if ([doctorSignedStr isEqualToString:@"0"]) {
            
            MYTOrderDetailsViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MYTOrderDetailsViewController"];
            
            vc.demandIdStr = model.demand_id;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            MYTOrderProcessViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
            
            vc.orderIdStr = model.order_id;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
 
    }else if ([orderStr isEqualToString:@"2"]){
         //预约订单
        MYTOrderProcessViewController *vc = [sb instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
        
        vc.orderIdStr = model.order_id;
        
        vc.orderTypeStr = model.order_type;
        
        [self.navigationController pushViewController:vc animated:YES];
    
    }
    
   
}
#pragma mark  -- 订单类型-----
-(void)selectdOrderTypeNSIntager:(NSInteger)type{

    self.type =type;
    self.curpage = 1;
    [self.dataListArr removeAllObjects];
    [self requestDataWithUrl];

}
#pragma mark --- 订单状态----
-(void)selectdOrderStateNSString:(NSString *)stateStr{

    self.status_mark = stateStr;
    self.curpage = 1;
    [self.dataListArr removeAllObjects];
    [self requestDataWithUrl];
}
#pragma mark  --- 数据相关-------
- (void)requestDataWithUrl {
    NSString *url  ;
    
    if (self.type == 1) {
       
        url = DMAND_ORDER_URL ;
    }
    else if (self.type == 2) {
      
        url = DMAND_ORDER_URL ;
    }
    else{
       
        url = INCRUABLE_ORDER_URL ;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:@([[self getMember_id] integerValue]) forKey:@"member_id"];
    [dic setObject:@(self.type) forKey:@"type"];
    [dic setObject:self.status_mark forKey:@"status_mark"];
    [dic setObject:@(self.curpage) forKey:@"curpage"];
    
    [self requestDataWithUrl:url andParams:dic.copy];
    
}
-(void) requestDataWithUrl:(NSString *)url andParams:(NSDictionary *)params{

    NSLog(@"param====%@",params);
    __weak typeof(self) weakSelf = self;
   [[KRMainNetTool sharedKRMainNetTool] sendRequstWith:url params:params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
       
       if (!error) {
           if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
               for (NSDictionary *dict in showdata) {
                   DemandModel *model = [DemandModel yy_modelWithDictionary:dict];
                   [weakSelf.dataListArr addObject:model];
               }
            
             //  [weakSelf.orderTableView reloadData];
           }
           
       }else{
           
           if (weakSelf.dataListArr.count > 0) {
               [weakSelf.dataListArr removeAllObjects];
           }
         
           [weakSelf.view setAlertViewWithTitle:error withCount:2];
       
       }
        [weakSelf.orderTableView reloadData];
       if ([self.orderTableView.header isRefreshing]) {
           [self.orderTableView.header endRefreshing];
       }
       if ([self.orderTableView.footer isRefreshing]) {
           [self.orderTableView.footer endRefreshing];
       }
      
   }];
   
}
//刷新
- (void)refreshData {
    self.curpage = 1;
    [self.dataListArr removeAllObjects];
    [self requestDataWithUrl];
}

//加载
- (void)loadMoreData {
    self.curpage += 1 ;
    [self requestDataWithUrl];
    
}
-(NSMutableArray *)dataListArr{
    if (!_dataListArr) {
        _dataListArr = [NSMutableArray array];
        
    }
    return _dataListArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
