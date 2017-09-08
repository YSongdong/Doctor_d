//
//  SystemMessageViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "SystemMessageViewController.h"
#import "SystemMessageCellTableViewCell.h"

@interface SystemMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *dataList ;
@property (nonatomic,assign)NSInteger page ;

@end
@implementation SystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate  = self ;
    _tableView.dataSource = self ;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    self.title = @"系统消息";
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.tableView.footer = footer ;
    
    self.navigationItem.leftBarButtonItem = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO ;

    self.page = 1 ;
    [self requestData];
}

- (void)requestData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]) {
        dic[@"member_id"] = [self getMember_id];
    }
    
    dic[@"curpage"] = @(self.page);
    
        [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Messages_url  params:dic withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                
                if ([self.tableView.header isRefreshing]) {
                    [self.tableView.header endRefreshing];
                }
                if ([self.tableView.footer isRefreshing]) {
                    [self.tableView.footer endRefreshing];
                }
                NSLog(@"%@",showdata);
                NSMutableArray *array = [NSMutableArray array];
                [showdata[@"_message"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    DemandModel *model = [DemandModel new];
                    [model setValuesForKeysWithDictionary:obj];
                    model._logo = showdata[@"_logo"];
                    [array addObject:model];
                }];
                self.dataList = array ;
                [self.tableView reloadData];
        }
    }];
}

- (void)refreshData {
    
    self.page = 1;
}

- (void)loadMoreData {
    
    self.page += 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    [self.tableView setAlertViewWithTitle:@"暂无系统消息"
                                withCount:[self.dataList count]];
    return [self.dataList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SystemMessageCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"systemeMessageTableViewCellIdentifier"];
    cell.model = self.dataList[indexPath.row];
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [SystemMessageCellTableViewCell calcuteHeihtWithWIthModel:self.dataList[indexPath.row]];
}


@end
