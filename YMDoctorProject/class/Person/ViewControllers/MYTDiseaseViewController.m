//
//  MYTDiseaseViewController.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTDiseaseViewController.h"
#import "MYDiseaseTableViewCell.h"
#import "YMSearchView.h"
//#import "MYDiseaseModel.h"
#import "KTRLabelView.h"

static NSString *const diseaseCell = @"diseaseCell";

@interface MYTDiseaseViewController ()<UITableViewDelegate,UITableViewDataSource,MYDiseaseTableViewCellDelegate,KTRLabelViewDelegate>

@property(nonatomic,strong)UITableView *diseaseTableView;
@property(nonatomic,strong)UIView *searchView;
@property(nonatomic,strong)YMSearchView *searchDiseaseView;

@property(nonatomic,strong)NSDictionary *param;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NSMutableArray *diseaseArry;

@property(nonatomic,assign)BOOL searchStatus;//搜索状态

@property(nonatomic,strong)NSMutableDictionary *labelDic;

@property(nonatomic,strong)NSMutableArray *selectDiseaseArry;

@property(nonatomic,strong)NSDictionary *selectLabelDic;

@property(nonatomic,strong)UILabel *tipLabel;

@property(nonatomic,strong)UIView *bottomView;

@end

@implementation MYTDiseaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initVar];
    [self requrtDiseaseData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)initView{
    [self initSearchView];
    [self initBottomView];
    [self initTableView];
    [self initHeaderLabel];
    
}

-(void)initHeaderLabel{
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.text = @"擅长疾病：";
    _tipLabel.textColor = RGBCOLOR(51, 51, 51);
    _tipLabel.font = [UIFont systemFontOfSize:15];
    
}

-(void)initVar{
    _page = 1;
    _diseaseArry = [NSMutableArray array];
    _labelDic = [NSMutableDictionary dictionary];
    [_labelDic setObject:[NSString stringWithFormat:@"%f",SCREEN_WIDTH - 20] forKey:@"labelViewWidth"];
    [_labelDic setObject:@29 forKey:@"labelHeight"];
    [_labelDic setObject:@1 forKey:@"buttonEnable"];
    
    _selectLabelDic  = [_labelDic mutableCopy];
    [_selectLabelDic setValue:@(SCREEN_WIDTH - (_tipLabel.intrinsicContentSize.width +10)) forKey:@"labelViewWidth"];
    _selectDiseaseArry = [NSMutableArray array];
}

-(void)initSearchView{
    _searchView = [[UIView alloc] init];
    _searchView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_searchView];
    [_searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    
    UIView *backGroup = [[UIView alloc]init];
    backGroup.backgroundColor = RGBCOLOR(245, 245, 245);
    backGroup.layer.masksToBounds = YES;
    backGroup.layer.cornerRadius = 15;
    [_searchView addSubview:backGroup];
    [backGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_searchView.mas_right).offset(-10);
        make.centerY.equalTo(_searchView.mas_centerY);
        make.height.equalTo(@40);
        make.left.equalTo(_searchView.mas_left).offset(10);
    }];
    
    
    UIButton *searchButton = [[UIButton alloc]init];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:RGBCOLOR(51, 51, 51) forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchDisease:) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    _searchDiseaseView = [[YMSearchView  alloc]init];
    _searchDiseaseView.backgroundColor = [UIColor clearColor];
    _searchDiseaseView.placeholderStr = @"请根据模糊搜索的结果选择对应的疾病!";
    [backGroup addSubview:_searchDiseaseView];
    [_searchDiseaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(backGroup);
        make.right.equalTo(verticalLineView.mas_left).offset(8);
    }];
}


-(void)initBottomView{
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    UIButton *submitButton = [[UIButton alloc]init];
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [submitButton setTitleColor: RGBCOLOR(251, 151, 0) forState:UIControlStateNormal];
    submitButton.layer.masksToBounds = YES;
    submitButton.layer.borderColor = RGBCOLOR(180, 180, 180).CGColor;
    submitButton.layer.borderWidth = 1.f;
    submitButton.layer.cornerRadius = 15;
    [submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView.mas_left).offset(40);
        make.right.equalTo(_bottomView.mas_right).offset(-40);
        make.height.equalTo(@30);
        make.centerY.equalTo(_bottomView.mas_centerY);
    }];
}


-(void)initTableView{
    _diseaseTableView = [[UITableView alloc]init];
    _diseaseTableView.delegate = self;
    _diseaseTableView.dataSource = self;
    _diseaseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _diseaseTableView.backgroundColor = [UIColor clearColor];
    [_diseaseTableView registerClass:[MYDiseaseTableViewCell class] forCellReuseIdentifier:diseaseCell];
    MJRefreshAutoNormalFooter *footer  = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    footer.refreshingTitleHidden = YES ;
    footer.stateLabel.hidden = YES ;
    self.diseaseTableView.footer = footer ;
    [self.view addSubview:_diseaseTableView];
    [_diseaseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(_searchView.mas_bottom).offset(10);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
    
}

-(void)searchDisease:(UIButton *)sender{
    _searchStatus = YES;
    _page = 1;
    [_diseaseArry removeAllObjects];
    [self requrtDiseaseData];
}


-(void)requrtDiseaseData{
    __weak typeof(self) weakSelf = self;
    
    NSString *searchStr = @"";
    if (_searchStatus&&![NSString isEmpty:_searchDiseaseView.searchTextField.text]) {
        searchStr = _searchDiseaseView.searchTextField.text;
    }
    
    _param = @{@"keyword":searchStr,
               @"curpage":@(_page)};
    
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Doctor_personal_Disease params:_param withModel:nil complateHandle:^(id showdata, NSString *error) {
        
        if (!showdata) {
            return ;
        }
        
        if ([self.diseaseTableView.footer isRefreshing]) {
            [self.diseaseTableView.footer endRefreshing];
        }
        
        if ([showdata isKindOfClass:[NSArray class]] || [showdata isKindOfClass:[NSMutableArray class]]) {
            for (NSDictionary *dic in showdata) {
                NSLog(@"%@",dic);
                NSMutableDictionary *copyDic = [dic mutableCopy];
                NSLog(@"====%@",copyDic);
                [copyDic setObject:dic[@"ename"] forKey:@"text"];
                [weakSelf.diseaseArry addObject:copyDic];
            }
            [weakSelf.diseaseTableView reloadData];
        }
    }];
}

//加载
-(void)loadMoreData{
    self.page += 1 ;
    
    [self requrtDiseaseData];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_diseaseArry.count == 0) {
        return 0;
    }
    NSArray *copyDiseaseArry = [_diseaseArry copy];
    return [MYDiseaseTableViewCell diseaseTableViewHeight:copyDiseaseArry dic:_labelDic];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MYDiseaseTableViewCell *cell = [[MYDiseaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:diseaseCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = _labelDic;
    cell.diseaseArry = _diseaseArry;
    cell.delegate = self;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_selectDiseaseArry.count == 0||!_selectDiseaseArry) {
        return 0;
    }
    
    return [MYDiseaseTableViewCell diseaseTableViewHeight:_selectDiseaseArry dic:_selectLabelDic];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_selectDiseaseArry.count == 0) {
        return nil;
    }
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor whiteColor];
    
    [headerView addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(10);
        make.top.equalTo(headerView.mas_top).offset(10);
        make.width.mas_equalTo(_tipLabel.intrinsicContentSize.width);
    }];
    
    
    KTRLabelView *labeViewHeader = [[KTRLabelView alloc]init];
    labeViewHeader.showCancelImage = YES;
    
    labeViewHeader.delegate = self;
    
    labeViewHeader.labelClock = RGBCOLOR(251, 151, 0);
    labeViewHeader.borderClock = RGBCOLOR(251, 151, 0);
    labeViewHeader.roundAngle = YES;
    labeViewHeader.roundNumber = 5;
    labeViewHeader.labelProperty = _selectLabelDic;
    labeViewHeader.labelData = _selectDiseaseArry;
    [headerView addSubview:labeViewHeader];
    [labeViewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tipLabel.mas_right);
        make.right.equalTo(headerView.mas_right);
        make.top.bottom.equalTo(headerView);
    }];
    
    return headerView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 0;
    if (_selectDiseaseArry.count>0) {
        sectionHeaderHeight +=[MYDiseaseTableViewCell diseaseTableViewHeight:_selectDiseaseArry dic:_selectLabelDic];
    }
    
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0,0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - MYDiseaseTableViewCellDelegate


-(void)diseaseCell:(MYDiseaseTableViewCell *)diseaseCell diseaseDic:(NSDictionary *)dic{
    [self labelClick:dic];
    
}

#pragma mark - KTRLabelViewDelegate
-(void)labeView:(KTRLabelView *)labeView clickNumber:(NSInteger)clickNumber{
    NSDictionary *dic = _selectDiseaseArry[clickNumber];
    [self labelClick:dic];
    
}

-(void)labelClick:(NSDictionary*)dic{
    if ([_selectDiseaseArry containsObject:dic]) {
        [_selectDiseaseArry removeObject:dic];
        [_diseaseArry addObject:dic];
    }else{
        [_selectDiseaseArry addObject:dic];
        [_diseaseArry removeObject:dic];
    }
    
    [_diseaseTableView reloadData];
}

-(void)submitClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(diseaseViewController:selectDiseaseArry:)]) {
        [self.delegate diseaseViewController:self selectDiseaseArry:[_selectDiseaseArry copy]];
    }
    [self navBackAction];
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
