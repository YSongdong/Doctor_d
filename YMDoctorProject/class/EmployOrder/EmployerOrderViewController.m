//
//  EmployerOrderViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "EmployerOrderViewController.h"
#import "DemandHallDetailViewController.h"
#import "OrderHeadView.h"
#import "DemandOrderTableViewCell.h"
#import "DemandOrderDetailViewController.h"

#import "MYTOrderProcessViewController.h"

@interface EmployerOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderHeadViewDelegate>

@property (weak, nonatomic) IBOutlet OrderHeadView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EmployerOrderViewController

-(void)dealloc {

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.requestUrlType = requestTypeEmployerOrderUrl;
   [self setup];
}


- (void)setup {

    _headView.delegate =self ;
    _headView.selectedIndex = 0 ;
    _tableView.sectionFooterHeight = 10 ;
    [_headView setTitles:@[@"全部",@"进行中",@"已完成",@"已失败"]];
    _headView.selectedIndex = 0 ;
    _headView.delegate = self ;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.tableView.footer = footer ;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
    [self requestDataWithUrl];

}

- (void)selectedIndexChangeRequest {
    self.page = 1 ;
    self.selectedIndex = _headView.selectedIndex ;
    
    [self requestDataWithUrl];
}


- (void)loadView {
    [super loadView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    cell.orderType = 1 ;
    
    return cell ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100 ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    if(section == 0) {
        return 10 ;
    }
    return 0.0001f ;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

//    DemandModel *model = self.dataList[indexPath.section];
//    
//    if ([model.order_apply integerValue] == 0) {
//        
////        [self performSegueWithIdentifier:@"showOrderDetailIdentifier" sender:model];
//        
//        [self pushNextHallPageModel:model];
//    }
//    else {
////        [self performSegueWithIdentifier:@"EmployIntoorderDetialIdentifier" sender:indexPath] ;
//        
//         [self pushNextPageWithIndexPath:indexPath];
//    }
    
    DemandModel *model = self.dataList[indexPath.section];

    MYTOrderProcessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
    
    vc.orderIdStr = model.order_id;
    
    vc.orderTypeStr = model.order_type;
    
    [self.fartherVC.navigationController pushViewController:vc animated:YES];
}


//-(void)pushNextPageIndexPath:(NSIndexPath*)indexPath{
//    DemandOrderDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DemandOrderDetailIdentifier"];
//    detailVC.detailType = requestTypeEmployerOrderUrl ;
//    
//    DemandModel *model = self.dataList[indexPath.section];
//    detailVC.demand_id = model.demand_id ;
//    
//    [self.fartherVC.navigationController pushViewController:detailVC animated:YES];
//}


-(void)pushNextHallPageModel:(DemandModel *)model{
    DemandHallDetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"DemandHall" bundle:nil] instantiateViewControllerWithIdentifier:@"DemandHallDetailViewController"];
    detailVC.title = @"需求详情";
    detailVC.buttonTitle = @"接受雇佣";
   
    detailVC.type = 1 ;
    
    detailVC.model = model ;
    [self.fartherVC.navigationController pushViewController:detailVC animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *vc = segue.destinationViewController ;
    if ([vc isKindOfClass:[DemandHallDetailViewController class]]) {
        DemandHallDetailViewController *  detailVC = (DemandHallDetailViewController *)vc ;
        detailVC.title = @"需求详情";
        detailVC.buttonTitle = @"接受雇佣";
        DemandModel *model = (DemandModel *)sender ;
        detailVC.type = 1 ;
        detailVC.model = model ;
    }
  if ([vc isKindOfClass:[DemandOrderDetailViewController class]]) {
        DemandOrderDetailViewController *vc = segue.destinationViewController ;
        vc.detailType = requestTypeEmployerOrderUrl ;
        NSIndexPath *indexPath = (NSIndexPath *)sender ;
        DemandModel *model = self.dataList[indexPath.section];
      vc.demand_id = model.demand_id ;
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"dataList"]) {        
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
                    
                }else {
                    
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
}

@end
