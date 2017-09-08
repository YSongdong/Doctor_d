//
//  DemandHallViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "DemandHallViewController.h"
#import "SelectedView.h"
#import "DemandHallDetailViewController.h"
#import "DepartmentsView.h"
#import "DemandHallModel.h"
#import "DemandHallTableCellTableViewCell.h"
#import "KRShengTableViewController.h"
#import "YMSelectedListView.h"

#import "DemandProgressViewController.h"

#import "MYTOrderDetailsViewController.h"
#import "MYTOrderProcessViewController.h"

#import "SDOrderTableViewCell.h"
#define SDORDERTABLEVIEW_CELL  @"SDOrderTableViewCell"
@interface DemandHallViewController ()<UITableViewDataSource,UITableViewDelegate,UIPopoverPresentationControllerDelegate,DemandHallModelDelegate,UITextFieldDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet SelectedView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)DemandHallModel *hallModel;
@property (nonatomic,strong)NSMutableDictionary *dicParams ;
@property (nonnull,strong)UITextField *searchTextField ;
@property (nonatomic,assign)NSInteger page ;
@property (nonatomic,strong)NSArray *dataList ;
@property (nonatomic,strong)YMSelectedListView *listView ;
@property (nonatomic,strong)UISearchBar *headerSearchBar ;
@property (nonatomic,strong)UIBarButtonItem *rightBtn ;
@property (nonatomic,strong)UILabel *titleLabel ;

@end

NSString *DemandHandleTableViewCellIdentifier = @"DemandHandleTableViewCellIdentifier";


void *demandContext = @"datalistContext";
void *departmentContext = @"departmentContext";
void *forumContext = @"forumDataList";
void *areasContext = @"areasContext";

@implementation DemandHallViewController

- (void)dealloc {

    [_hallModel removeObserver:self forKeyPath:@"demandLists"];
    [_hallModel removeObserver:self forKeyPath:@"departmentDic"];
    [_hallModel removeObserver:self forKeyPath:@"forumDataList"];
    [_hallModel removeObserver:self forKeyPath:@"areas"];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"selectedAddress" object:nil];
}

- (NSMutableDictionary *)dicParams {
    
    if (!_dicParams) {
        _dicParams = [NSMutableDictionary new];
    }
    return _dicParams ;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
     self.tabBarController.tabBar.hidden = NO ;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view resignFirstResponder];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"需求大厅";
    _hallModel = [DemandHallModel new];
    _hallModel.delegate = self ;
    self.page = 1;
    [self setup];
    [self request];
    [self addobserve];
    //searchBar显示中文取消

    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].title = @"取消";
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    self.rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"1231_03@2x.gif"] style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent:)];
     [self setSearchBar];
    self.navigationItem.rightBarButtonItem = self.rightBtn;
    UILabel *titleLabel = [UILabel new];
    titleLabel.bounds = CGRectMake(0, 0, 100, 25);
    titleLabel.font = [UIFont systemFontOfSize:15 weight:1];
    self.navigationItem.titleView = titleLabel ;
    if (self.ways == 0) {
        self.navigationItem.titleView = self.titleLabel ;
    }
    if (self.ways== 1) {
        self.navigationItem.titleView = self.headerSearchBar ;
        self.rightBtn.enabled = NO ;
        [self.headerSearchBar becomeFirstResponder];
        self.rightBtn.image = nil ;
    }
}
- (void)clickEvent:(UIBarButtonItem *)searchBtn {
    
    self.navigationItem.titleView = self.headerSearchBar;
    [self.headerSearchBar becomeFirstResponder];
   // self.rightBtn.enabled = NO ;
   // self.rightBtn.image = nil ;
}

- (void)addobserve {
    
    [_hallModel addObserver:self forKeyPath:@"demandLists"
                    options:NSKeyValueObservingOptionNew
                    context:&demandContext];
    [_hallModel addObserver:self forKeyPath:@"departmentDic"
                    options:NSKeyValueObservingOptionNew context:&departmentContext];
    [_hallModel addObserver:self forKeyPath:@"forumDataList"
                    options:NSKeyValueObservingOptionNew context:&forumContext];
    [_hallModel addObserver:self forKeyPath:@"areas" options:NSKeyValueObservingOptionNew context:areasContext];
}

//刷新数据
- (void)refreshData {

    self.page = 1;
    [self request];
}

//加载数据
- (void)loadMoreData {
    self.page += 1;
    [self request];
}

- (void)setSearchBar {
    
    UISearchBar *bar  = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 10,
                [UIScreen mainScreen].bounds.size.width - 10, 30)];
    self.headerSearchBar = bar;
    bar.backgroundImage = [UIImage new];
    bar.barTintColor = [UIColor clearColor];
    bar.delegate = self;
    [self setSearchTextFieldBackgroundColor:[UIColor colorWithRed:222.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
    bar.placeholder = @"搜索需求订单";
}
- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor
{
    UIView *searchTextField = nil;
    searchTextField = [[[self.headerSearchBar.subviews firstObject] subviews] lastObject];
    searchTextField.tintColor = [UIColor blackColor];
    searchTextField.backgroundColor = backgroundColor;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;       //显示“取消”按钮
    return YES ;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    self.navigationItem.titleView = self.titleLabel ;
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = NO; //隐藏“取消”按钮
    [searchBar resignFirstResponder];
    self.page = 1 ;
    [self searchKeyWords:searchBar.text];
    return YES ;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];

}

- (void)request {
    if ([self getMember_id]) {
        [self.dicParams setObject:[self getMember_id] forKey:@"doctor_member_id"];
    }
    [self.dicParams setObject:@(self.page) forKey:@"curpage"];
    [self selectedRequest];
}

- (void)selectedRequest {
    dispatch_queue_t queue = dispatch_queue_create("com.ymdoctor.request", DISPATCH_QUEUE_CONCURRENT);
    _hallModel.params = self.dicParams ;
        dispatch_async(queue, ^{
            
    [_hallModel requetNetworkDataWithView:self.view];
    });
}

- (void)setup {
    _headView.backgroundColor = Global_mainBackgroundColor ;
    
    [self.tableView registerNib:[UINib nibWithNibName:SDORDERTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:SDORDERTABLEVIEW_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:@"DemandHallTableCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:DemandHandleTableViewCellIdentifier];
    self.tableView.sectionFooterHeight = 10 ;
    [_tableView addImageView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
   MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.tableView.footer = footer ;
    //block
    __weak typeof(self)weakSelf = self ;

    self.headView.block = ^(NSInteger index){
        if (index == 0){
            
            //科室
            [weakSelf createAlterView];
            
            
            return  ;
        }
//        if (index == 2) {
//            
//            //区域
//            [weakSelf clickChoiceDistribution];
//            
//            return ;
//        }
        if (index == 1 || index == 2 || index == 3) {
            
            //金额 结束时间 和 职称
            UIButton *view = (UIButton *) _headView.subviews[index];
            ListType type = 0 ;
            NSArray *array ;
            
            if (index == 1) {
                
                //金额
                type = ListTypeNormal ;
                array = [self.hallModel getsearchChoice];
                
            }else if (index == 2) {
                
                //结束时间
                type = ListTypeMoney ;
                array = [self.hallModel getsearchChoice2];
                
            }else{
                
                //职称
                if ([weakSelf.hallModel.forumDataList count] == 0) {
                    //提示
                    return ;
                }
                type = ListTypeHospital;
                array = [weakSelf.hallModel.forumDataList copy];
                NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"ename"] = @"不限";
                dic[@"disorder"] = @"0";
                [arr insertObject:dic.copy atIndex:0];
                
                array = arr.copy;
            }
            
            if (_listView && _listView.superview) {
                [_listView removeFromSuperview];
                _listView = nil ;
            }
            _listView = [YMSelectedListView viewWithDataList:array type:type andViewWidth: view.frame.size.width start_Y:CGRectGetMaxY(view.frame)+ 64  andStart_X:CGRectGetMinX(view.frame)andCommpleteBlock:^(id value,ListType type) {
                
                [weakSelf.headView setTitle:value[@"ename"]];
                
                if (type == ListTypeNormal) {
                    
                    [weakSelf.dicParams setObject:value[@"key"] forKey:@"sort"];
                    if ([value[@"key"]integerValue] == 0) {
                        [weakSelf.headView setDefaultTitle];
                        [weakSelf.dicParams removeAllObjects];
                    }
                    
                }else if (type == ListTypeMoney) {
                    
                    [weakSelf.dicParams setObject:value[@"key"] forKey:@"demand_time"];
                    if ([value[@"key"]integerValue] == 0) {
                        [weakSelf.headView setDefaultTitle];
                        [weakSelf.dicParams removeAllObjects];
                    }
                    
                }else{
                    
                    [weakSelf.dicParams setObject:value[@"disorder"] forKey:@"aptitude"];
                }
                weakSelf.page = 1 ;
                
                [weakSelf request];
            
            }];
            [self.view addSubview:_listView];
        }
    };
    [_hallModel requestArea];
}

-(void) createAlterView{
    UIAlertController *alterVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"不限" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.headView setTitle:@"不限"];
        [self.dicParams setObject:@"0" forKey:@"ks"];
        [self selectedRequest];
        
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"从列表中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showDepartmentView];
    }]];
    [alterVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];

    [self presentViewController:alterVC animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_listView &&_listView.superview) {
        [_listView removeFromSuperview];
        _listView = nil ;
    }
}

//选择区域
- (void)clickChoiceDistribution {
    
    KRShengTableViewController *controller = [[KRShengTableViewController alloc]init];
    controller.type = districtTypeCity;
    controller.areas = self.hallModel.areas ;
    NSLog(@"controller.areas=========%@",controller.areas);

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addreeeChoice:) name:@"selectedAddress" object:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)addreeeChoice:(NSNotification *)notify {
    if (_headView.selectedIndex == 3) {
        [_headView setTitle:notify.object[@"area_name"]];
        [self.dicParams setObject:notify.object[@"area_id"] forKey:@"area_id"];
        [self selectedRequest];
    }
}

- (void)showDepartmentView{

    if (!self.hallModel.departmentDic) {
        [self alertViewShow:@"获取科室失败"];
        return ;
    }
    DepartmentsView *departView = [DepartmentsView DepartmentsViewWithDic:self.hallModel.departmentDic];
    departView.viewOffsetX = _headView.subviews.firstObject.width;
    departView.start_y = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    [departView showOnSuperView:self.view subViewStartY:0];
    __weak typeof(self)weakSelf = self ;
    //request data
    departView.block = ^(id dic,NSString *departID) {
        [weakSelf.headView setTitle:dic[@"ename"]];
        [weakSelf.dicParams setObject:dic[@"disorder"] forKey:@"ks"];
        [weakSelf selectedRequest];
    };
}


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;//不适配(不区分ipad或iPhone)
}

- (void)searchKeyWords:(NSString *)search{
    
    [self.dicParams setObject:search forKey:@"keyword"];
    [self selectedRequest];
    [self.dicParams removeObjectForKey:@"keyword"];
    self.headerSearchBar.text = nil ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  DemandHallTableCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DemandHandleTableViewCellIdentifier forIndexPath:indexPath];
    SDOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SDORDERTABLEVIEW_CELL forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return 95 ;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataList count] ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    DemandModel *model = self.dataList[indexPath.section] ;
//    [self performSegueWithIdentifier:@"DemandHallDetailIndentifier" sender:model];
    
//    DemandProgressViewController * detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DemandProgressViewController"];
//    DemandModel *model = self.dataList[indexPath.section];
//    DemandProgressViewController * vc =detailVC;
//    vc.model = model ;
//    vc.slectedIndex = [model.demand_schedule integerValue];
//    [self.navigationController pushViewController:detailVC animated:YES];
   
    DemandModel *model = self.dataList[indexPath.section];
    
    NSString *contractSignedStr = model.contract_signed;
    
    NSString *status_number = model.status_number;

    if ([contractSignedStr isEqualToString:@"0"]) {
        
        MYTOrderDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderDetailsViewController"];
        
        vc.demandIdStr = model.demand_id;
        
        vc.current_docter_signed =  model.current_docter_signed;
        
        if ([status_number isEqualToString:@"2"]) {
            vc.isState = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
     

    }else{
        
        NSString *current_docter_signed = model.current_docter_signed;
        if ([current_docter_signed isEqualToString:@"1"]) {
            MYTOrderProcessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
            
            vc.orderIdStr = model.order_id;
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            MYTOrderDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderDetailsViewController"];
            
            vc.demandIdStr = model.demand_id;
            vc.current_docter_signed =  model.current_docter_signed;
            
            [self.navigationController pushViewController:vc animated:YES];
        
        }
 
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([self.navigationItem.titleView isFirstResponder]) {
        [self.navigationItem.titleView resignFirstResponder];
    }
    UIViewController *vc = segue.destinationViewController ;
    if ([vc isKindOfClass:[DemandHallDetailViewController class]]) {
       DemandHallDetailViewController * detailVC = (DemandHallDetailViewController *)vc ;
        
        if ([sender isKindOfClass:[DemandModel class]]) {
            DemandModel *model = (DemandModel *)sender ;
            detailVC.model = model ;
            detailVC.title = @"需求详情";
            detailVC.buttonTitle = @"立即投标";
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10 ;
    }
    return 0.001f;
}

//observe
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"demandLists"]) {
        dispatch_async(dispatch_get_main_queue(), ^{

            if (self.page == 1) {
                self.dataList = self.hallModel.demandLists ;
            }
            else {
                NSMutableArray *array = [self.dataList mutableCopy];
                [array addObjectsFromArray:self.hallModel.demandLists];
                self.dataList = array;
            }
           [self.tableView reloadData];
            if ([self.dataList count] > 0) {
                [self.tableView hiddenImageView];
            }else{
                [self.tableView addImageView];
            }
            if ([self.tableView.header isRefreshing]) {
                [self.tableView.header endRefreshing];
            }
            if ([self.tableView.footer isRefreshing]) {
                [self.tableView.footer endRefreshing];
            }
        });
    }
    if ([keyPath isEqualToString:@"departmentDic"]) {
        
    }
    if ([keyPath isEqualToString:@"forumDataList"]) {
        
    }
    if ([keyPath isEqualToString:@"areas"]) {
        
    }
}

- (void)getDataFailureWithReason:(NSString *)reason {
    
    if ([self.tableView.header isRefreshing]) {
        [self.tableView.header endRefreshing];
    }
    if ([self.tableView.footer isRefreshing]) {
        [self.tableView.footer endRefreshing];
    }
      [self alertViewShow:reason];
}
- (void)alertViewShow:(NSString *)alertString {
    AlertView *alert = [AlertView alertViewWithSuperView:self.view andData:alertString];
    [alert show];
}

@end
