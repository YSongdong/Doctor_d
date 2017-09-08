    //
//  DemandOrderViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandProgressViewController.h"
#import "DemandOrderViewController.h"
#import "DemandOrderTableViewCell.h"
#import "OrderHeadView.h"
#import "DemandOrderDetailViewController.h"
#import "DemandHallDetailViewController.h"

#import "MYTOrderDetailsViewController.h"
#import "MYTOrderProcessViewController.h"

@interface DemandOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderHeadViewDelegate,DemandOrderModelDelegate>

@property (weak, nonatomic) IBOutlet OrderHeadView *headOrderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *keyArr;

@end

@implementation DemandOrderViewController

- (void)dealloc {
    [self.orderModel removeObserver:self forKeyPath:@"dataList"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.orderModel addObserver:self forKeyPath:@"dataList"
     options:NSKeyValueObservingOptionNew context:nil];
    
    [self requestDataWithUrl];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (DemandOrderModel *)orderModel {
    if (!_orderModel) {
        _orderModel = [DemandOrderModel new];
        _orderModel.delegate = self ;
    }
    return _orderModel ;
}

//刷新
- (void)refreshData {
    self.page = 1;
    [self requestDataWithUrl];
}

//加载
- (void)loadMoreData {
    self.page += 1 ;
    
    [self requestDataWithUrl];
    
}
- (void)setUp {

    _tableView.sectionFooterHeight = 10 ;
//    [_headOrderView setTitles:@[@"全部",@"投标中",@"进行中",@"已完成",@"已失败"]];
    
    self.keyArr = [[NSMutableArray alloc]initWithObjects:@"all",@"going",@"over",@"fail", nil];
    [_headOrderView setTitles:@[@"全部",@"进行中",@"已完成",@"已失败"]];
    
    _headOrderView.selectedIndex = 0 ;
    _headOrderView.delegate = self ;    
    self.selectedIndex = _headOrderView.selectedIndex ;
    
    [self.tableView addImageView];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.tableView.footer = footer ;
    self.page = 1;
}

- (void)requestDataWithUrl {
    NSString *url  ;
    
    if (self.requestUrlType == requestTypeDemandOrderUrl) {
        url = DMAND_ORDER_URL ;
    }
    else if (self.requestUrlType == requestTypeEmployerOrderUrl) {
//        url = EMPLOYER_ORDER_URL ;
        url = DMAND_ORDER_URL ;
    }
    else{
        url = INCRUABLE_ORDER_URL ;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
//    if ([self getStore_id]) {
//        [dic setObject:[self getStore_id] forKey:@"store_id"];
//    }
//    [dic setObject:@(self.page) forKey:@"curpage"];
//    [dic setObject:@(self.selectedIndex) forKey:@"tb"];
    
    [dic setObject:@([[self getMember_id] integerValue]) forKey:@"member_id"];
    [dic setObject:@(self.requestUrlType+1) forKey:@"type"];
    [dic setObject:self.keyArr[self.selectedIndex] forKey:@"status_mark"];
    [dic setObject:@(self.page) forKey:@"curpage"];

    [self.orderModel requestDataWithUrl:url andParams:dic view:self.view];
    
}

- (void)selectedIndexChangeRequest {
    
    _selectedIndex = _headOrderView.selectedIndex ;
    
    self.page = 1;
    
    [self requestDataWithUrl];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.dataList count] ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DemandOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderCellIdentifeir"];
    cell.model = self.dataList[indexPath.section];
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10 ;
    }
    return 0.0001f ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self pushNextPageWithIndexPath:indexPath];

}

-(void)pushNextPageWithIndexPath:(NSIndexPath*)indexPath{
    
    DemandModel *model = self.dataList[indexPath.section];
    NSString *doctorSignedStr = model.doctor_signed;
    
    self.hidesBottomBarWhenPushed = YES;
    
    if ([doctorSignedStr isEqualToString:@"0"]) {
        
        MYTOrderDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderDetailsViewController"];
        
        vc.demandIdStr = model.demand_id;
        
        [self.fartherVC.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        MYTOrderProcessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
        
        vc.orderIdStr = model.order_id;
        
        [self.fartherVC.navigationController pushViewController:vc animated:YES];
    }

    
//    MYTOrderProcessViewController * OrderProcessVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
    
//    DemandModel *model = self.dataList[indexPath.section];
//    DemandProgressViewController * vc = detailVC;
//    vc.model = model ;
//    vc.type = self.requestUrlType ;
//    vc.slectedIndex = [model.demand_schedule integerValue];
    
//    [self.fartherVC.navigationController pushViewController:OrderProcessVC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[DemandOrderDetailViewController class]]) {
        UIViewController *vc =  segue.destinationViewController ;
        DemandOrderDetailViewController *detailVC = (DemandOrderDetailViewController *)vc ;
        switch (self.requestUrlType) {
            case requestTypeDemandOrderUrl:{
                detailVC.detailType = demandDetailType ;
            }break;
            case requestTypeEmployerOrderUrl:{
                detailVC.detailType = employerDetailType ;
            }break ;
            case requestTypeIncurableUrl:{
                detailVC.detailType = incruableDetailTyppe ;
            }break;
        }
        NSIndexPath *indexPath = (NSIndexPath *)sender ;
        DemandModel *model = self.dataList[indexPath.section];
        detailVC.demand_id = model.demand_id ;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"dataList"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([self.tableView.header isRefreshing]) {
                [self.tableView.header endRefreshing];
            }
            if ([self.tableView.footer isRefreshing]) {
                [self.tableView.footer endRefreshing];
            }
            
            if (self.page == 1) {
                self.dataList = self.orderModel.dataList ;
            }
            else {
                NSMutableArray *mutaArray = [self.dataList mutableCopy];
                [mutaArray addObjectsFromArray:self.orderModel.dataList];
                self.dataList = mutaArray ;
            }
            if ([self.dataList count] == 0) {
                [self.tableView addImageView];
            }
            else {
                [self.tableView hiddenImageView];
            }
                        
            [self.tableView reloadData];
        });
    }
}

- (void)requestDataFailureWithReason:(NSString *)failure {
    
    if ([self.tableView.header isRefreshing]) {
        [self.tableView.header endRefreshing];
    }
    if ([self.tableView.footer isRefreshing]) {
        [self.tableView.footer endRefreshing];
    }
    [self alertViewShow:failure];
}

@end
