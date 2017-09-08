//
//  MYTHomePageViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#define S_W [UIScreen mainScreen].bounds.size.width

#import "MYTHomePageViewController.h"

#import "MYTWDZY_RView.h"

//诊疗服务
#import "MYTZLFW_CollectionCell.h"
//案例
#import "MYTALZX_CollectionCell.h"
//荣誉中心
#import "MYTRYZX_CollectionCell.h"
//评价
#import "MYTALPJ_CollectionCell.h"
#import <UIImageView+WebCache.h>

#import "MYTCaseDetailsViewController.h"
#import "YMCaseDetailsViewController.h"

@interface MYTHomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic,strong) NSMutableArray * caseDataArray;
@property (nonatomic,strong) NSMutableArray * honourDataArray;
@property (nonatomic,strong) NSMutableArray * pingJiaDataArray;

@property (nonatomic,assign) NSInteger tempIndex;

@property (nonatomic,assign) NSInteger anniuIndex;

//默认没有点击
@property (nonatomic,assign) BOOL isDianji;
@property (nonatomic,strong) NSMutableDictionary *params;

@property (nonatomic,strong) NSMutableDictionary *dict;

@property (nonatomic,strong) NSMutableDictionary *caseParams;
@property (nonatomic,strong) NSMutableDictionary *honourParams;
@property (nonatomic,strong) NSMutableDictionary *pingJiaParams;

@end

@implementation MYTHomePageViewController

-(NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [ NSMutableArray new];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.caseDataArray = [ NSMutableArray new];
    self.honourDataArray = [ NSMutableArray new];
    self.pingJiaDataArray = [ NSMutableArray new];

    self.caseParams = [NSMutableDictionary new];
    self.honourParams = [NSMutableDictionary new];
    self.pingJiaParams = [NSMutableDictionary new];

    self.params = [NSMutableDictionary new];
    self.dict = [NSMutableDictionary new];
    
    [self.dict setValuesForKeysWithDictionary:self.dictionary];
    [self requestListDataWithView:self.view];
}
-(void)setStore_id:(NSString *)store_id
{
    _store_id = store_id;
}
//请求  我的主页  列表数据
- (void)requestListDataWithView:(UIView *)view{
    
    self.params[@"store_id"] = self.store_id;
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:DoctorInfo_URL
    params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
      
    NSLog(@"showdata---------%@",showdata);
       
    if (showdata == nil) {
        return ;
    }
        
    [self.dict setValuesForKeysWithDictionary:showdata];
        
    [self requestCaseListDataWithView:self.view];
        
    [self.collectionView reloadData];
        
    }];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(10, 5, 10, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.anniuIndex == 0) {
        
        return CGSizeMake((S_W-10-10)/2, 206);
        
    }else if(self.anniuIndex == 2){
        
        return CGSizeMake(S_W-10, 120);
    }
    return CGSizeMake(S_W-10, 200);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


-(void)loadDataWithIndex:(NSInteger)index{
    self.dataArray = nil;
    
    if (index == 0) {
     
        [self requestCaseListDataWithView:self.view];
        
    }else if (index == 1){
        
        [self requestHonourListDataWithView:self.view];
        
    }else{
        
        self.dataArray = nil;
        [self.collectionView reloadData];
       
    }
}


//请求列表数据
- (void)requestHonourListDataWithView:(UIView *)view{
    
    if([self getMember_id]){
        
        self.honourParams[@"member_id"] = self.dict[@"member_id"];
    }
    
    self.honourParams[@"curpage"] = @(0);
    
    self.honourParams[@"is_admin"] = @(0);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Honor_URL
        params:self.honourParams withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
            
  //  NSLog(@"showdata ===--------==== %@",showdata);
     
    if (showdata == nil) {
        
        return ;
    }
            
    if ([showdata isKindOfClass:[NSArray class]]    ) {
        [self.dataArray setArray:showdata];
        
    }
            [self.collectionView reloadData];
    }];
}


//请求  案例  列表数据
- (void)requestCaseListDataWithView:(UIView *)view{
    
    if([self getMember_id]){
        
        self.caseParams[@"member_id"] = @([[self getMember_id] integerValue]);
    }
//    if ([self getStore_id]){
    
        self.caseParams[@"doctor_member_id"] =  self.dict[@"member_id"];
        ;
//    }
    
    self.caseParams[@"is_admin"] = @(0);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Case_URL
    params:self.caseParams withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata ======= %@",showdata);
        
        if (showdata == nil) {
            return ;
        }
        
        if ([showdata isKindOfClass:[NSArray class]]    ) {
            [self.dataArray setArray:showdata];
        }
        
        [self.collectionView reloadData];
    }];
}

//TODO:表头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    MYTWDZY_RView * view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([MYTWDZY_RView class]) forIndexPath:indexPath];
    
    [view.headImage sd_setImageWithURL:[NSURL URLWithString:self.dict[@"member_avatar"]]];
    
    view.nameLab.text = self.dict[@"member_names"];
    view.follow_numLab.text = [NSString stringWithFormat:@"关注:%@人",self.dict[@"follow_num"]];
    
    view.aptitudeLab.text = self.dict[@"member_aptitude"];
    view.hospitalLab.text = [NSString stringWithFormat:@"%@ %@ %@",self.dict[@"member_occupation"],self.dict[@"member_bm"],self.dict[@"member_ks"]];
    
    view.store_salesLab.text = [NSString stringWithFormat:@"成交量:%@",self.dict[@"store_sales"]];
    view.stoer_browseLab.text = [NSString stringWithFormat:@"浏览量:%@",self.dict[@"stoer_browse"]];
    view.avg_scoreLab.text = [NSString stringWithFormat:@"好评率:%@",self.dict[@"avg_score"]];
    
    NSString *serviceStr = self.dict[@"member_service"];
    if ([serviceStr isEqualToString:@""] && serviceStr == nil) {
        serviceStr = @"暂未添加擅长疾病";
    }
    view.serviceLab.text = serviceStr;
    view.personalLab.text = self.dict[@"member_Personal"];
    
    __weak typeof(self) weakSelf = self;
    
    [view setSelectedBtnWithIndex:self.anniuIndex];
    view.BtnClickBack = ^(NSInteger index) {
        weakSelf.anniuIndex = index;
//        [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
        
        [weakSelf loadDataWithIndex:index];

    };    
    self.wdzy_RView = view;
    
    return view;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * collectionViewCell ;
    switch (self.anniuIndex) {
        case 0:
        {
//            案例管理
            MYTALZX_CollectionCell * cell3 = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MYTALZX_CollectionCell class]) forIndexPath:indexPath];
            
            [cell3 addCaseData:self.dataArray[indexPath.row]];
            
//            self.dataArray = self.caseDataArray;
            
            collectionViewCell = cell3;
 
        }
            break;
        case 1:
        {
//            荣誉中心
            MYTRYZX_CollectionCell * cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MYTRYZX_CollectionCell class]) forIndexPath:indexPath];
            
            [cell2 addHonourData:self.dataArray[indexPath.row]];
            
//            self.dataArray = self.honourDataArray;
            
            collectionViewCell = cell2;
        }
            break;
        default:
        {
//            案例评价
            MYTALPJ_CollectionCell * cell4 = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MYTALPJ_CollectionCell class]) forIndexPath:indexPath];
            [cell4 addPingJiaData:self.dataArray[indexPath.row]];
            
//            self.dataArray = self.pingJiaDataArray;

            collectionViewCell = cell4;
        }
            break;
        }
    return collectionViewCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.anniuIndex == 0) {
        
       // MYTCaseDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTCaseDetailsViewController"];
        YMCaseDetailsViewController *vc = [[YMCaseDetailsViewController alloc]init];
        vc.case_id = self.dataArray[indexPath.row][@"case_id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
