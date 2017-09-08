//
//  BillViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/20.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "BillViewController.h"
#import "BillTableCell.h"
#import "PersonViewModel.h"
@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)PersonViewModel *viewModel ;


@end
//CellReuseIdentifier
//cellTitleIdentifier
@implementation BillViewController

- (void)dealloc {
    [_viewModel removeObserver:self forKeyPath:@"billLists"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)setUp {

    _tableView.sectionFooterHeight = 0.0001f ;
    _viewModel = [PersonViewModel new];
   [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerCell"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getStore_id]) {
        dic[@"store_id"] = [self getStore_id];
    }
    if ([self getMember_id]) {
        dic[@"member_id"] = [self getMember_id];
    }
   
    NSString *url ;
    if (self.type == demandOrderType) {
        url = BILL_ACCOUNT_URL ;
    }
    if (self.type == EmployerOrderType) {
        url = EMPLOY_BILL_ACCOUNT_URL ;
    }
     [_viewModel requestBillListWithParams:dic url:url view:self.view];
    [_viewModel addObserver:self forKeyPath:@"billLists" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

//    [self.tableView setAlertViewWithTitle:@"暂无数据"
//                                withCount:[self.viewModel.billLists count]];
    if ([self.viewModel.billLists count] > 0) {
        return [self.viewModel.billLists[section][@"zhangdan"] count] +1 ;
    }
    return 0 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    [self.tableView setAlertViewWithTitle:@"暂无数据"
                                withCount:[self.viewModel.billLists count]];
 
    return [self.viewModel.billLists count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BillTableCell *cell ;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellTitleIdentifier"];
    }
    else {
        
        NSArray *cellArray = self.viewModel.billLists[indexPath.section][@"zhangdan"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellReuseIdentifier"];
        cell.model = cellArray[indexPath.row -1] ;
    }
    return cell ;
    
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
        
    return 40 ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        return 45 ;
    }
    return 65 ;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    view.bounds = CGRectMake(0, 0, WIDTH, 40);
    UILabel *title = [UILabel new];
    title.text = self.viewModel.billLists[section][@"finnshed_time"];
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor darkTextColor];
    [title sizeToFit];
    title.center = CGPointMake(20 + title.width/2, 40 /2);
    UILabel *detail = [UILabel new];
    detail.text = [NSString stringWithFormat:@"收入:%@",self.viewModel.billLists[section][@"order_amoun"]];
    detail.font = [UIFont systemFontOfSize:14];
    detail.textColor = [UIColor darkTextColor];
    [detail sizeToFit];
    detail.center = CGPointMake(WIDTH - 20 - detail.width/2, 40 /2);
    [view addSubview:title];
    [view addSubview:detail];
    return view;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"billLists"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }
}
@end
