//
//  YMHospitalListViewController.m
//  doctor_user
//
//  Created by 黄军 on 17/5/27.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMHospitalListViewController.h"
#import "YMHospitalAndDepartmentModel.h"
#import "YMSearchView.h"
#import "KTRLabelView.h"

#import "YMHospitalSelectModel.h"
#import "YMAddAccountTableViewCell.h"
static NSString *const addAccountViewCell = @"addAccountViewCell";

@interface YMHospitalListViewController ()<KTRLabelViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)YMHospitalAndDepartmentModel *model;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)YMSearchView *searchHospitalView;

@property(nonatomic,strong)UIView *centerView;

@property(nonatomic,strong)KTRLabelView *labelView;

@property(nonatomic,strong)NSMutableDictionary *dic;

@property(nonatomic,strong)NSMutableArray *interestData;

@property(nonatomic,strong)NSMutableArray<YMHospitalModel *> *populaHospitalArry;//热门医院
@property(nonatomic,strong)NSMutableArray<YMHospitalSelectModel *> *hospitatSelectArry;//医院选择

@property(nonatomic,strong)NSMutableArray<YMHospitalModel *> *searchHospitalArry;//搜索医院的数据

@property(nonatomic,strong)UITableView *selectHospitalTableView;

@property(nonatomic,strong)UIView *tableViewTop;

@property(nonatomic,strong)UIButton *backSelctButton;

@property(nonatomic,assign)BOOL searchState;//搜索状态

@property(nonatomic,strong)NSDictionary *param;

@property(nonatomic,strong)NSMutableArray *labelArry ;

@end

@implementation YMHospitalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择医院";
    self.view.backgroundColor = RGBCOLOR(245, 245, 245);
    [self initVar];
    [self initView];
    [self requestPageContent];

    // Do any additional setup after loading the view.
}


-(void)initVar{
    _searchState = NO;
    _interestData = [NSMutableArray array];
    _populaHospitalArry = [NSMutableArray array];
    _hospitatSelectArry = [NSMutableArray array];
    _searchHospitalArry = [NSMutableArray array];
    
    _labelArry = [NSMutableArray array];
}

-(void)initView{
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKey)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    [self initTopView];

    [self initTableView];
}
-(void)initTopView{
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    
    UILabel *tipLabele = [[UILabel alloc]init];
    tipLabele.font = [UIFont systemFontOfSize:15];
    tipLabele.textColor = RGBCOLOR(51, 51, 51);
    tipLabele.text = @"搜索医院:";
    [_topView addSubview:tipLabele];
    [tipLabele mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).offset(10);
        make.top.equalTo(self.topView.mas_top).offset(10);
        make.right.equalTo(self.topView.mas_right).offset(-10);
    }];
    
    UIView *backGroup = [[UIView alloc]init];
    backGroup.backgroundColor = RGBCOLOR(245, 245, 245);
    backGroup.layer.masksToBounds = YES;
    backGroup.layer.cornerRadius = 15;
    [_topView addSubview:backGroup];
    [backGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView.mas_right).offset(-10);
        make.top.equalTo(tipLabele.mas_bottom).offset(5);
        make.height.equalTo(@30);
        make.left.equalTo(_topView.mas_left).offset(10);
    }];
    
    
    UIButton *searchButton = [[UIButton alloc]init];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchHospital:) forControlEvents:UIControlEventTouchUpInside];
    [backGroup addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backGroup.mas_right).offset(-3);
        make.height.top.equalTo(backGroup);
        make.width.equalTo(@40);
    }];
    
    UIView *verticalLineView = [[UIView alloc]init];
    verticalLineView.backgroundColor = RGBCOLOR(229, 229, 229);
    
    [backGroup addSubview:verticalLineView];
    [verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(searchButton.mas_left).offset(-3);
        make.top.equalTo(backGroup.mas_top).offset(5);
        make.bottom.equalTo(backGroup.mas_bottom).offset(-5);
        make.width.mas_offset(1);
    }];

    
    _searchHospitalView = [[YMSearchView  alloc]init];
    _searchHospitalView.backgroundColor = [UIColor clearColor];
    _searchHospitalView.placeholderStr = @"输入您想搜索的医院名字";
    [backGroup addSubview:_searchHospitalView];
    [_searchHospitalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(backGroup);
        make.right.equalTo(verticalLineView.mas_left).offset(8);
    }];
}


//-(void)initCenterView:(UIView *)headerView{
//    _centerView = [[UIView alloc]init];
//    _centerView.backgroundColor = self.view.backgroundColor;
//    [headerView addSubview:_centerView];
//    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(headerView);
//        if (_populaHospitalArry.count>0) {
//            make.height.equalTo(@([KTRLabelView labelViewHeight:_dic labelData:_labelArry]));
//        }else{
//            make.height.equalTo(@40);
//        }
//    }];
//    UILabel *tipLabel = [[UILabel alloc]init];
//    tipLabel.text = @"热门医院";
//    tipLabel.textColor = RGBCOLOR(80, 80, 80);
//    tipLabel.font = [UIFont systemFontOfSize:15];
//    [_centerView addSubview:tipLabel];
//    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.left.equalTo(_searchHospitalView);
//        make.top.equalTo(_centerView.mas_top).offset(10);
//    }];
//    
//    _labelView = [[KTRLabelView alloc]init];
//    _labelView.delegate = self;
//    _labelView.labelBackClock = [UIColor whiteColor];
//    _labelView.labelClock = RGBCOLOR(51, 51, 51);
//    _dic = [NSMutableDictionary dictionary];
//    [_dic setObject:@15 forKey:@"labelFontSize"];
//    [_dic setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH - 20] forKey:@"labelViewWidth"];
//    [_dic setObject:@"29" forKey:@"labelHeight"];
//    [_dic setObject:@1 forKey:@"buttonEnable"];
//
//    
//    [_centerView addSubview:_labelView];
//    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(_searchHospitalView);
//        make.top.equalTo(tipLabel.mas_bottom).offset(10);
//    }];
//    
//}
//
//-(void)initTabelViewTop:(UIView *)headerView{
//    _tableViewTop = [[UIView alloc]init];
//    _tableViewTop.backgroundColor = [UIColor whiteColor];
//    [headerView addSubview:_tableViewTop];
//    [_tableViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(_centerView);
//        make.top.equalTo(_centerView.mas_bottom);
//        make.height.mas_equalTo(44);
//    }];
//    _backSelctButton = [[UIButton alloc]init];
//    [_backSelctButton setTitle:@"选择医院: " forState:UIControlStateNormal];
//    _backSelctButton.userInteractionEnabled = NO;
//    _backSelctButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_backSelctButton setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
//    [_backSelctButton addTarget:self action:@selector(backPreviousData:) forControlEvents:UIControlEventTouchUpInside];
//    [_tableViewTop addSubview:_backSelctButton];
//    [_backSelctButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_tableViewTop.mas_left).offset(10);
//        make.top.equalTo(_tableViewTop.mas_top).offset(10);
//        make.bottom.equalTo(_tableViewTop.mas_bottom).offset(-10);
//        make.width.mas_equalTo([_backSelctButton.titleLabel intrinsicContentSize].width);
//    }];
//
//}

-(void)initTableView{

    _selectHospitalTableView = [[UITableView alloc]init];
    _selectHospitalTableView.delegate = self;
    _selectHospitalTableView.dataSource = self;
    _selectHospitalTableView.backgroundColor = [UIColor clearColor];
    _selectHospitalTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [_selectHospitalTableView registerClass:[YMAddAccountTableViewCell class] forCellReuseIdentifier:addAccountViewCell];
    [self.view addSubview:_selectHospitalTableView];
    [_selectHospitalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_topView.mas_bottom);
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchState) {
        return _searchHospitalArry.count;
    }else{
        return _hospitatSelectArry.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YMAddAccountTableViewCell *cell = [[YMAddAccountTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addAccountViewCell];;
    if (_searchState) {
         YMHospitalModel *model = _searchHospitalArry[indexPath.row];
        cell.titleName = model.hospital_name;
    }else{
        YMHospitalSelectModel *model  = _hospitatSelectArry[indexPath.row];
        cell.titleName = model.desc;
    }
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 80;
    if (_populaHospitalArry.count>0) {
      sectionHeaderHeight +=[KTRLabelView labelViewHeight:_dic labelData:_labelArry];
    }
    
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_populaHospitalArry.count>0) {
        return [KTRLabelView labelViewHeight:_dic labelData:_labelArry]+80;
    }else{
        return 80;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headerView = [[UIView alloc]init];
    
    _centerView = [[UIView alloc]init];
    _centerView.backgroundColor = self.view.backgroundColor;
    [headerView addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(headerView);
        if (_populaHospitalArry.count>0) {
            make.height.equalTo(@([KTRLabelView labelViewHeight:_dic labelData:_labelArry]+40));
        }else{
            make.height.equalTo(@40);
        }
    }];
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.text = @"热门医院";
    tipLabel.textColor = RGBCOLOR(80, 80, 80);
    tipLabel.font = [UIFont systemFontOfSize:15];
    [_centerView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(10);
        make.right.equalTo(headerView.mas_right).offset(-10);
        make.top.equalTo(_centerView.mas_top).offset(10);
    }];
    
    _labelView = [[KTRLabelView alloc]init];
    _labelView.delegate = self;
    _labelView.labelBackClock = [UIColor whiteColor];
    _labelView.labelClock = RGBCOLOR(51, 51, 51);
    _dic = [NSMutableDictionary dictionary];
    [_dic setObject:@15 forKey:@"labelFontSize"];
    [_dic setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH - 20] forKey:@"labelViewWidth"];
    [_dic setObject:@"29" forKey:@"labelHeight"];
    [_dic setObject:@1 forKey:@"buttonEnable"];
    _labelView.labelProperty = _dic;
    _labelView.labelData=_labelArry;
    
    [_centerView addSubview:_labelView];
    [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(10);
        make.right.equalTo(headerView.mas_right).offset(-10);
        make.top.equalTo(tipLabel.mas_bottom).offset(10);
        make.height.equalTo(@([KTRLabelView labelViewHeight:_dic labelData:_labelArry]));
    }];
    
    
    _tableViewTop = [[UIView alloc]init];
    _tableViewTop.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:_tableViewTop];
    [_tableViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_centerView);
        make.top.equalTo(_centerView.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    _backSelctButton = [[UIButton alloc]init];
    [_backSelctButton setTitle:@"选择医院: " forState:UIControlStateNormal];
    _backSelctButton.userInteractionEnabled = NO;
    _backSelctButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_backSelctButton setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
    [_backSelctButton addTarget:self action:@selector(backPreviousData:) forControlEvents:UIControlEventTouchUpInside];
    [_tableViewTop addSubview:_backSelctButton];
    [_backSelctButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tableViewTop.mas_left).offset(10);
        make.top.equalTo(_tableViewTop.mas_top).offset(10);
        make.bottom.equalTo(_tableViewTop.mas_bottom).offset(-10);
        make.width.mas_equalTo([_backSelctButton.titleLabel intrinsicContentSize].width);
    }];
    
//    [self initCenterView:headerView];
    
//    [self initTabelViewTop:headerView];

    return headerView;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_searchState) {
        YMHospitalModel *model = _searchHospitalArry[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(hospitalList:hospitalModel:)]) {
            [self.delegate hospitalList:self hospitalModel:model];
            [self navBackAction];
        }
    }else{
        YMHospitalSelectModel *model  = _hospitatSelectArry[indexPath.row];
        _param = @{@"type":model.type,
                   @"content":model.content};
        [self searchHospitalRequrt];
    }
}

#pragma mark - request
//获取科室等接口
- (void)requestPageContent {
    __weak typeof(self) weakSelf = self;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Hospital_URL params:nil withModel:nil complateHandle:^(id showdata, NSString *error) {
        
        if (!showdata) {
            return ;
        }
        if ([showdata isKindOfClass:[NSDictionary class]] || [showdata isKindOfClass:[NSMutableDictionary class]]) {
//           NSArray * hot_hospital = @[//热门医院
//                                           @{
//                                               @"hospital_id": @"45061",//医院ID
//                                               @"hospital_name": @"重庆医科大学附属儿童医院",//医院名称
//                                           },
//                                           @{
//                                               @"hospital_id": @"45062",
//                                               @"hospital_name": @"重庆医科",
//                                               },
//                                           @{
//                                               @"hospital_id": @"45063",
//                                               @"hospital_name": @"重科"
//                                               },
//                                           @{
//                                               @"hospital_id": @"45064",
//                                               @"hospital_name": @"院"
//                                               },
//                                           @{
//                                               @"hospital_id": @"45065",
//                                               @"hospital_name": @"儿童医院"
//                                               },
//                                           @{
//                                               @"hospital_id": @"45066",
//                                               @"hospital_name": @"重庆儿童医院"
//                                               }
//                                           ];
//            NSMutableDictionary *showDid = [showdata mutableCopy];
//            [showDid setObject:hot_hospital forKey:@"hot_hospital"];
            
            NSArray *populaArry = [showdata[@"hot_hospital"] copy];
            for (NSDictionary *dic in populaArry) {
                [weakSelf.populaHospitalArry addObject:[YMHospitalModel yy_modelWithJSON:dic]];
            }
            NSArray *selectionArry = [showdata[@"selection"] copy];
            for (NSDictionary *dic in selectionArry) {
                [weakSelf.hospitatSelectArry addObject:[YMHospitalSelectModel yy_modelWithJSON:dic]];
            }
            [weakSelf refreshView];
        }
    }];
}

-(void)searchHospitalRequrt{
    __weak typeof(self) weakSelf = self;
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:SearchHospital_URL params:_param withModel:nil complateHandle:^(id showdata, NSString *error) {
        
        if (!showdata) {
            return ;
        }
        if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
            [weakSelf.searchHospitalArry removeAllObjects];
            for (NSDictionary *dic in showdata) {
                [weakSelf.searchHospitalArry addObject:[YMHospitalModel yy_modelWithJSON:dic]];
            }
            weakSelf.searchState = YES;
            [self refreshTableView];
            [weakSelf.selectHospitalTableView reloadData];
        }
    }];
}

#pragma mark - refresh

-(void)refreshView{
    if (_populaHospitalArry.count>0) {
        for (YMHospitalModel *model in _populaHospitalArry) {
            NSDictionary *dic = @{@"text":model.hospital_name};
            [_labelArry addObject:dic];
        }
        
        _labelView.labelProperty = _dic;
        _labelView.labelData=_labelArry;
        
//        [_labelView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo([KTRLabelView labelViewHeight:_dic labelData:_labelArry]);
//        }];
//
//        [_centerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@([KTRLabelView labelViewHeight:_dic labelData:_labelArry]+40));
////            make.height.equalTo(_labelView.mas_height);
//            
////            make.height.equalTo(_labelView.mas_height+40));
//        }];
    }
    [_selectHospitalTableView reloadData];
}

-(void)refreshTableView{
    if (_searchState) {
        _backSelctButton.userInteractionEnabled = YES;
        [_backSelctButton setTitleColor:RGBCOLOR(85, 170, 249) forState:UIControlStateNormal];
        [_backSelctButton setTitle:@"返回  " forState:UIControlStateNormal];
        [_backSelctButton setImage:[UIImage imageNamed:@"imgv_arrow_left_blue"] forState:UIControlStateNormal];
    }else{
        [_backSelctButton setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
        [_backSelctButton setTitle:@"选择医院: " forState:UIControlStateNormal];
        [_backSelctButton setImage:nil forState:UIControlStateNormal];
        _backSelctButton.userInteractionEnabled = NO;
        
    }
}

#pragma mark - KTRLabelViewDelegate
-(void)labeView:(KTRLabelView *)labeView clickNumber:(NSInteger)clickNumber{

    YMHospitalModel *model = _populaHospitalArry[clickNumber];
    
    if ([self.delegate respondsToSelector:@selector(hospitalList:hospitalModel:)]) {
        [self.delegate hospitalList:self hospitalModel:model];
        [self navBackAction];
    }
    
}

#pragma mark - buttonClick
-(void)backPreviousData:(UIButton *)sender{
    _searchState = NO;
    [self refreshTableView];
    [_selectHospitalTableView reloadData];
}


-(void)searchHospital:(UIButton *)sender{
    _param = @{@"type":@"keyword",
               @"content":_searchHospitalView.searchTextField.text.length>0?_searchHospitalView.searchTextField.text:@""};
    
    [self searchHospitalRequrt];
    [self hiddenKey];
}

#pragma mark - 隐藏键盘
-(void)hiddenKey{
    [_searchHospitalView.searchTextField resignFirstResponder];
}

#pragma mark -dismis
- (void)navBackAction
{
    UIViewController *ctrl = [[self navigationController] popViewControllerAnimated:YES];
    if (ctrl == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
