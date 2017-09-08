//
//  HomeViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"

#import "HomeHeadTableViewCell.h"
#import "HomeTableViewCell.h"
#import "HomeListTableViewCell.h"
#import "NodataCell.h"

#import "DemandOrderViewController.h"
#import "EmployerOrderViewController.h"
#import "IncurableOrderViewController.h"
#import "DemandHallViewController.h"

#import "DemandOrderDetailViewController.h"
#import "DemandHallDetailViewController.h"
#import "MYTQualificationAuditViewController.h"

#import "AggrementViewController.h"
#import "MYTScannerView.h"

#import "HMScannerController.h"
#import "UIImageView+WebCache.h"

#import "TalkViewController.h"

#import "MYTCertificationViewController.h"
#import <UIImageView+WebCache.h>

#import "MYTHomePageViewController.h"
#import "YMDoctorHomePageViewController.h"
#import "KRWebViewController.h"

#import "QualificationViewController.h"

#import "MYTOrderDetailsViewController.h"
#import "MYTOrderProcessViewController.h"

#import "UIButton+LZCategory.h"
#import "HomeFunctionTableViewCell.h"
#import "MYTOfficialViewController.h"
#import "HomeManageTableViewCell.h"
#import "ZMFloatButton.h"
#import "MYOrderFarther_VC.h"

#import "SDPatientManagerViewController.h"

#import "SDHosporViewController.h"

#import "NewOrderViewController.h"

#define HOMEFUNCTIONTABLEVIEW_CELL @"HomeFunctionTableViewCell"
#define HOMEMANAGATETABLEVIEW_CELL  @"HomeManageTableViewCell"


@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,HomeFunctionTableViewCellDelegate,HomeManageTableViewCellDelegate,ZMFloatButtonDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)HomeViewModel *viewModel ;

@property (nonatomic,assign)BOOL havePictures ;
@property (nonatomic,assign)BOOL observeOn ;

@property (nonatomic,strong)UISearchBar *headerSearchBar ;
@property (nonatomic,strong)NSArray *dataList ;

@property (nonatomic,strong)NSMutableDictionary *params ;
@property (nonatomic,assign)NSInteger type ;

@property (nonatomic,strong)MYTScannerView *scannerView;

@property (nonatomic,strong)NSString *Qrcode;

@property(nonatomic,strong)NSDictionary *assistantDict;

@property (nonatomic,strong) NSMutableDictionary *dict;

@property (nonatomic,strong)UIView * centerView;

@property (nonatomic,strong)UILabel *lab;

@property (nonatomic,strong)NSMutableArray *dataListArr ;
@property (nonatomic,strong) NSString *completeStr;  //获取是否实名认证

@property (nonatomic,assign)NSInteger currentIndex ;


@end

static NSString *headCellIdentifier = @"HomeHeadTableViewCellIdentifier";
static NSString *selectedItemTableCellIdentifier = @"HomeTableCellChoiceSelectorIdentifier";
static NSString *listCellIdentifier = @"HomeTableViewCellListIdentifier";

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO ;
    if (self.havePictures == NO) {
        [self.viewModel getHeadImage];
    }
    [self requestListDataWithView:self.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createLeftBarButtonItem];
    [self createRightBarButtonItem];
    [self createCenterBarButtonItem];

    [self loadDataWithView:self.view];

    _type = 1;
    [self inputWebView];
    [self setup];
    [self initFloatBtn];
    self.dataListArr = [NSMutableArray new];
  
}

//在个人中心 是否实名认证
- (void)loadDataWithView:(UIView *)view{
    
    NSLog(@"Member_id-------------%@",[self getMember_id]);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Person_Info_Url
    params:@{ @"member_id":@([[self getMember_id] integerValue]) }withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                 
     if (showdata == nil){
         
         return ;
     }
     self.completeStr = showdata[@"complete_status"];
                 
     if ([_completeStr isEqualToString:@"1"]) {
//         前往实名认证
         [self createAlertView];
         
     }else if ([_completeStr isEqualToString:@"2"]) {
//         实名认证完成
         [self createAlertView1];
     }
                 
    NSString *userName = showdata[@"member_names"];
    if (![NSString isEmpty:userName ]) {
         _lab.text =[NSString stringWithFormat:@"欢迎您! %@",userName];
//         if (_lab.intrinsicContentSize.width>(SCREEN_WIDTH-200)) {
//             _lab.width = SCREEN_WIDTH-200;
//         }else{
//             _lab.width = _lab.intrinsicContentSize.width;
//         }
    }
    //_centerView.width =_lab.width+50;//50:重庆和图片的宽度+10的间隔
        self.navigationItem.title = _lab.text;
   }];
}

-(void)createAlertView1{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"认证提示"
                                                                   message:@"请前往实名认证资质提交!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
      handler:^(UIAlertAction * action) {
          //资质提交
          QualificationViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"QualificationViewControllerIdentifier"];
          
          [self.navigationController pushViewController:vc animated:YES];
          
      }];
    
    [alert addAction:defaultAction1];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)createAlertView{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"认证提示"
                                                                   message:@"请前往实名认证!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
    }];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * action) {
          //实名认证
          MYTCertificationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTCertificationViewController"];
//          vc.status = self.params[@"realname_auth_status"];
          vc.status = @"0";

          [self.navigationController pushViewController:vc animated:YES];
      }];
    
    [alert addAction:defaultAction1];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)sureBtnClick:(UIButton *)sender{
    
    //实名认证
    MYTCertificationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTCertificationViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidLayoutSubviews {
    self.observeOn = YES ;
}
//全局浮动按钮
-(void) initFloatBtn
{
    ZMFloatButton * floatBtn = [[ZMFloatButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, SCREEN_HEIGHT-176, 98, 50)];
    floatBtn.delegate = self;
    //floatBtn.isMoving = NO;
    floatBtn.bannerIV.image = [UIImage imageNamed:@"home_floatBtnImage"];
    [self.view addSubview:floatBtn];
    [self.view bringSubviewToFront:floatBtn];
    
}

-(void)setup {
    
    _tableView.sectionFooterHeight = 10 ;
    
    [self.viewModel addObserver:self forKeyPath:@"pics" options:NSKeyValueObservingOptionNew context:nil];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag ;
    
    [self.tableView registerNib:[UINib nibWithNibName:HOMEFUNCTIONTABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:HOMEFUNCTIONTABLEVIEW_CELL];
    [self.tableView registerNib:[UINib nibWithNibName:HOMEMANAGATETABLEVIEW_CELL bundle:nil] forCellReuseIdentifier:HOMEMANAGATETABLEVIEW_CELL];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestListDataWithView:nil];
        [self performSelector:@selector(hiddenRefresh) withObject:nil afterDelay:2];
    }];
}


- (void)hiddenRefresh {
    
    [self.tableView.header endRefreshing];
}


//请求列表数据
- (void)requestListDataWithView:(UIView *)view{
    
    self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    self.params[@"type"] = @(_type);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:HOME_LIST_URL
        params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
          
           // NSLog(@"showdata------------%@",showdata);
            
            self.dataListArr = showdata[@"_order"];
            
        if ([showdata[@"_order"] isKindOfClass:[NSArray class]]) {
            NSArray *array = showdata[@"_order"];
            NSMutableArray  *mutArray =  [NSMutableArray array];
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DemandModel *model = [DemandModel new];
                [model setValuesForKeysWithDictionary:obj];
                [mutArray addObject:model];
            }];
            self.dataList = [mutArray mutableCopy];
        }
            
        self.assistantDict = showdata[@"assistant"];
   
    [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3 ) {
        
        if ([self.dataList count] > 0) {
            
            return self.dataList.count + 1 ;
        }
        else {
            return 2 ;
        }
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
    
        HomeHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellIdentifier];
        
        cell.pictures = self.viewModel.pics ;
    
        cell.block = ^(NSString *url){
            AggrementViewController *vc = [[UIStoryboard storyboardWithName:@"Aggrement" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
            vc.url = url ;
            vc.title = @"详情";
            [self.navigationController pushViewController:vc animated:YES];
        };
        return cell ;
    }
     if (indexPath.section == 1) {
         HomeFunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOMEFUNCTIONTABLEVIEW_CELL forIndexPath:indexPath];
         cell.delegate =self;
        //HomeTableViewCell *cell = [HomeTableViewCell cellWithTableView:tableView andIdentifier:selectedItemTableCellIdentifier];
        return cell ;
    }
    if (indexPath.section == 2) {
        HomeManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HOMEMANAGATETABLEVIEW_CELL forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }
    
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            
            HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCellListIdentifierWithHead"];
            
            cell.block = ^(NSInteger type){
                
                _type = type ;
                [self requestListDataWithView:self.view];

            };
            return cell ;
            
        }else if ([self.dataList count] > 0){
            
            HomeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCellIdentifier];
            cell.type = self.type ;
            
            cell.model = self.dataList[indexPath.row - 1];
            
            return cell ;
        }
        else {
            {
                NodataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NodataCellIdentifier"];
                if (![self getStore_id]) {
                    
                    cell.type = Authen ;
                }
                else if (self.type == 2) {
                    
                    cell.type = NoSystemOrder ;
                }
                else if (self.type == 1) {
                    
                    cell.type = DemandOrder ;
                }
                [cell juadge];
                cell.block = ^(){
                    if (![self getStore_id]) {
                        
                        //让去认证
                        UIViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateInitialViewController];
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }else {
                        
                    }
                };
                return cell ;
            }
        }
    }
    return nil ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        return 160 ;
    }
    if (indexPath.section == 1) {
        return 150 ;
    }
    if (indexPath.section == 2) {
        return 85;
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 45 ;
        }
        else {
            if ([self.dataList count] == 0) {
                 return tableView.height - 205 -
                75 *VerticalRatio()- 20  - 64 - 54 - 45;
            }
            else {
                return 80 ;
            }
        }
    }
    return 0.00f ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    return 0.001f ;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 3 && [self.dataList count] > 0) {
        
        if (indexPath.row == 0) {
            
            return ;
        }
        if(self.type == 1 ){
          
            self.hidesBottomBarWhenPushed = YES;
            NSString *currentSigned =self.dataListArr[indexPath.row-1][@"current_docter_signed"];
            if ([currentSigned isEqualToString:@"1"]) {
                
                MYTOrderProcessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
                
                vc.orderIdStr = self.dataListArr[indexPath.row-1][@"order_id"];
                
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
                MYTOrderDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderDetailsViewController"];
                
                vc.demandIdStr = self.dataListArr[indexPath.row-1][@"demand_id"];
                
                vc.current_docter_signed =  currentSigned;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
//          //订单流程
//            MYTOrderProcessViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderProcessViewController"];
//            
//            vc.orderIdStr = self.dataListArr[indexPath.row-1][@"order_id"];
//         
//            NSLog(@"order_id-------------%@",vc.orderIdStr);
//            
//            [self.navigationController pushViewController:vc animated:YES];
             self.hidesBottomBarWhenPushed = NO;
            
        }else if (self.type == 2) {
            self.hidesBottomBarWhenPushed= YES;
            //订单详情
            MYTOrderDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOrderDetailsViewController"];

            vc.demandIdStr = self.dataListArr[indexPath.row-1][@"demand_id"];
            
            NSLog(@"demand_id-------------%@",vc.demandIdStr);

            [self.navigationController pushViewController:vc animated:YES];
             self.hidesBottomBarWhenPushed = NO;
        }
    }
}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    self.tabBarController.tabBar.hidden = YES ;
//    if ([segue.identifier isEqualToString:@"demandOrderSegueIdentifier"]) {
//        
//        DemandOrderViewController *vc = (DemandOrderViewController *)segue.destinationViewController ;
//        vc.requestUrlType = requestTypeDemandOrderUrl ;
//    } else if ( [segue.identifier isEqualToString:@"employerIdentifeir"]) {
//        EmployerOrderViewController *vc = (EmployerOrderViewController *)segue.destinationViewController ;
//        vc.requestUrlType = requestTypeEmployerOrderUrl ;
//        
//    } else if ( [segue.identifier isEqualToString:@"homtToOrderDetailIdentifier"]) {
//        UIViewController *vc =  segue.destinationViewController ;
//        DemandOrderDetailViewController *detailVC = (DemandOrderDetailViewController *)vc ;
//        NSIndexPath *indexPath = (NSIndexPath *)sender ;
//        
//        DemandModel *model = self.dataList[indexPath.row - 1];
//        detailVC.demand_id = model.demand_id ;
//        if ([model.demand_hire integerValue] == 1) {
//            detailVC.detailType = employerDetailType ;
//        }
//        if (!model.demand_hire ||
//            [model.demand_hire integerValue] == 0) {
//            if ([model.demand_qb integerValue] == 3) {
//                detailVC.detailType = incruableDetailTyppe ;
//            }
//            else {
//                detailVC.detailType = demandDetailType ;
//            }
//        }
//    }
//    if ([segue.identifier isEqualToString:@"pushDemandHallIdentifier"]) {
//        //需求大厅
//        DemandHallViewController *demandHall = segue.destinationViewController ;
//        demandHall.ways = 1 ;
//        demandHall.searchContent = sender ;
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"pics"]) {
        if ([self.viewModel.pics count] > 0) {
            self.havePictures = YES ;
        }
        [self.tableView reloadData];
    }
}
#pragma mark   - 功能cell点击方法 --HomeFunctionTableViewCellDelegate
-(void) selectdCellBtnIndex:(NSInteger)index
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (index) {
        case 0:{
            //鸣医订单
            self.hidesBottomBarWhenPushed = YES;
          //  MYOrderFarther_VC  *mingyiVC = [sb instantiateViewControllerWithIdentifier:@"MYOrderFarther_VC"];
           //   [self.navigationController pushViewController:mingyiVC animated:YES];
            
            NewOrderViewController *orderVC = [[NewOrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
            
            self.hidesBottomBarWhenPushed = NO;
        }
            break;
        case 1:
            //官方活动
        {
            self.hidesBottomBarWhenPushed = YES;
            MYTOfficialViewController *officialVC = [sb instantiateViewControllerWithIdentifier:@"MYTOfficialViewController"];
            [self.navigationController pushViewController:officialVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
            break;

        case 2:
        {
            //患者管理
            self.hidesBottomBarWhenPushed = YES;
            SDPatientManagerViewController *patiManagerVC = [[SDPatientManagerViewController alloc]init];
            [self.navigationController pushViewController:patiManagerVC animated:YES];
             self.hidesBottomBarWhenPushed = NO;
        }
            break;

        case 3:
            //我的动态
            
            [self alertViewShow:@"该功能正在建设中!"];
            
            break;

        default:
            break;
    }
    
}

#pragma mark --- 点击热点 ---
-(void)selectdHospotUrl:(NSString *)url andTitle:(NSString *)title
{
    SDHosporViewController *hospotVC = [[SDHosporViewController alloc]init];
    hospotVC.url =url;
    hospotVC.shopTitle = title;
    [self.navigationController pushViewController:hospotVC animated:YES];

}

#pragma mark  -- 管理manage HomeManageTableViewCellDelegate --- 
-(void)selectdManageBtnIndex:(NSInteger)manageIndex
{

    switch (manageIndex) {
        case 0: {
            //个人主页
            if ([_completeStr isEqualToString:@"5"]) {
                //我的主页
                self.hidesBottomBarWhenPushed = YES;
              //  MYTHomePageViewController *homePageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTHomePageViewController"];
                YMDoctorHomePageViewController *homePageVC = [[YMDoctorHomePageViewController alloc]init];
                homePageVC.store_id = [self getStore_id] ;
                homePageVC.isUserDoctor = YES;
               // [homePageVC requestListDataWithView:homePageVC.view];
                
                [self.navigationController pushViewController:homePageVC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                
            }
            if ([_completeStr isEqualToString:@"10"]){
                //         前往实名认证
                // [self createAlertView];
                self.hidesBottomBarWhenPushed = YES;
                MYTQualificationAuditViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"MYTQualificationAuditViewController"];
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            if ([_completeStr isEqualToString:@"2"]){
                //前往资质提交
                self.hidesBottomBarWhenPushed = YES;
                
                //资质提交
                QualificationViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"QualificationViewControllerIdentifier"];
                
                [self.navigationController pushViewController:vc animated:YES];
                self.hidesBottomBarWhenPushed = NO;
            }
            
        }
            
            break;
        case 1:{
            //我的服务
            
            [self alertViewShow:@"该功能正在建设中!"];
            
        }
            break;

        case 2:{
            //案例管理
            self.hidesBottomBarWhenPushed = YES;
            [self MYTHomePushNextPageWithStoryboardID:@"MYTCaseViewController"];
             self.hidesBottomBarWhenPushed =NO;
        }
            
            break;

        case 3:{
            //荣誉管理
             self.hidesBottomBarWhenPushed = YES;
            [self MYTHomePushNextPageWithStoryboardID:@"MYTHonourViewController"];
            self.hidesBottomBarWhenPushed = NO;
        }
            
            break;

        default:
            break;
    }

}

#pragma mark - 从主页面跳到下一个页面
-(void)MYTHomePushNextPageWithStoryboardID:(NSString *)storyboardID {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:storyboardID];
    [self.navigationController pushViewController:vc animated:YES];
}

- (HomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [HomeViewModel new];
    }
    return _viewModel ;
}
- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params ;
}

-(void)createCenterBarButtonItem{
    // 自定义导航栏中间按钮
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 100, 30)];

    _lab = [UILabel new];
    _lab.frame = CGRectMake(0, 0, 150, 30);
    _lab.text = @"欢迎您 ! 用户";
    _lab.textColor = [UIColor whiteColor];
    _lab.font = [UIFont systemFontOfSize:15];
    _lab.textAlignment = NSTextAlignmentCenter;
   
    [_centerView addSubview:_lab];
    
  //  self.navigationItem.titleView = _centerView;
    
}

- (void)createLeftBarButtonItem{
    // 自定义导航栏左侧按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 2, 64, 40);
    UIImage *image =[[UIImage imageNamed:@"home_nav_adrees"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftBtn setImage:image forState:UIControlStateNormal];
    
    [leftBtn setTitle:@"重庆" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftBtn LZSetbuttonType:LZCategoryTypeLeft];
    
    [leftBtn addTarget:self action:@selector(onLeftTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
   
}

// 左侧导航栏点击事件处理
- (void)onLeftTap {
    NSLog(@"点击了导航栏左侧按钮");
    
}
- (void)createRightBarButtonItem{
    // 自定义导航栏右侧按钮
    //扫描二维码
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame =CGRectMake(0, 0, 28, 28);
    [codeBtn setBackgroundImage:[UIImage imageNamed:@"home_nav_saomiao"]forState:UIControlStateNormal];
    [codeBtn addTarget:self action:@selector(onRightTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithCustomView:codeBtn];
   // UIBarButtonItem *scanItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_nav_saomiao"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightTap)];
    
    //排行榜
    UIButton *doctroChartsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doctroChartsBtn.frame =CGRectMake(0, 0, 30, 30);
    [doctroChartsBtn setBackgroundImage:[UIImage imageNamed:@"doctor_chart"]forState:UIControlStateNormal];
    [doctroChartsBtn addTarget:self action:@selector(doctorChartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *chartItem = [[UIBarButtonItem alloc]initWithCustomView:doctroChartsBtn];
    
 
    self.navigationItem.rightBarButtonItems = @[scanItem,chartItem];
    
}

#pragma mark  --- 右侧导航栏点击事件处理 -----
//扫描二维码
- (void)onRightTap {

    [self requestDataWithView:self.view];
}
//点击排行榜
-(void)doctorChartBtnClick:(UIButton *)sender
{
    self.hidesBottomBarWhenPushed = YES;
    //排行榜
    [self MYTHomePushNextPageWithStoryboardID:@"MYTRankViewController"];
    self.hidesBottomBarWhenPushed = NO;
}
//请求列表数据
- (void)requestDataWithView:(UIView *)view{
    
    if ([self getMember_id]){
        self.params[@"member_id"] = [self getMember_id];
    }
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:doctorQrcode_URL
    params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata ===%%%%%%%%==== %@",showdata);
        
        self.Qrcode = showdata[@"qrcode"];
        //弹出医生二维码
        if (self.scannerView == nil) {
            
            MYTScannerView *view = [MYTScannerView initWithXib];

            self.scannerView = view;
        }
        
        [self.scannerView.imgView sd_setImageWithURL:[NSURL URLWithString:self.Qrcode]];
        self.scannerView.frame = self.view.frame;
        
        [self.scannerView show];
        
    }];
}


////记录消息个数
//- (void)setTableBarItemNumber{
//    
//    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
//    item.badgeValue = [NSString stringWithFormat:@"%d",2];
////    item.badgeColor = [UIColor redColor];
//}

-(void)inputWebView{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"inputadvertisingClick"]) {
        
        NSString *strUrl = [[NSUserDefaults standardUserDefaults]objectForKey:@"webUrl"];
        KRWebViewController *webVC = [[KRWebViewController alloc]init];
        webVC.saoceUrl = strUrl;
        [self.navigationController pushViewController:webVC animated:YES];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"inputadvertisingClick"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
#pragma makr   -- 悬浮按钮点击事件 --  ZMFloatButtonDelegate
- (void)floatTapAction:(ZMFloatButton *)sender{
    //点击执行事件
    NSString *huanxinid = self.assistantDict[@"huanxinid"];
    TalkViewController *vc = [[TalkViewController alloc]initWithConversationType:1 targetId:huanxinid];
    NSLog(@"%@",huanxinid);
    vc.title = @"鸣医助手";
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
