//
//  IncurableOrderViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "IncurableOrderViewController.h"
#import "OrderHeadView.h"
#import "DemandOrderTableViewCell.h"
#import "DemandOrderDetailViewController.h"

@interface IncurableOrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderHeadViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet OrderHeadView *headView;

@end

@implementation IncurableOrderViewController

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.requestUrlType = requestTypeIncurableUrl;
    
   [self setup];
}
- (void)setup {
    
    _tableView.sectionFooterHeight = 10 ;
//    [_headView setTitles:@[@"全部",@"投标中",@"进行中",@"已完成",@"已失败"]];
    
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

    [self.tableView addImageView];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
}


- (void)selectedIndexChangeRequest {
    
    self.selectedIndex = self.headView.selectedIndex ;
    [self requestDataWithUrl];
}


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.orderModel.dataList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DemandOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IncurableIdentifier"];
    cell.model = self.orderModel.dataList[indexPath.section];
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
    
//    [self performSegueWithIdentifier:@"diseaIntOrderDetailIdentifier" sender:indexPath];
    
    [self pushNextPageWithIndexPath:indexPath];
}


//-(void)pushNextPageIndexPath:(NSIndexPath*)indexPath{
//    DemandOrderDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DemandOrderDetailIdentifier"];
//    
//    
//    [self.fartherVC.navigationController pushViewController:detailVC animated:YES];
//}




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

}

@end
