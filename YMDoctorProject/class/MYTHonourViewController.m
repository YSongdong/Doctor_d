//
//  MYTHonourViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTHonourTableViewCell.h"
#import "MYTHonourViewController.h"
#import "MYTAddHonourTableViewController.h"

#import "DJRefresh.h"
#import "DJRefreshProgressView.h"
#import <UIImageView+WebCache.h>


@interface MYTHonourViewController ()<UITableViewDelegate,UITableViewDataSource,DJRefreshDelegate>

@property (nonatomic,strong)DJRefresh *refresh;

// 0 是刷新 1 是加载
@property (nonatomic,assign) int stateR;

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, assign) NSInteger curpageNum;


@end

@implementation MYTHonourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    for (int i = 0; i<10; i++) {
//        NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//        [dict setValue:@"1" forKey:@"显示"];
//        
//        [self.dataArray addObject:dict];
//    }
//    
    
    NSLog(@"self.honor_idStr--------------%@",self.honor_idStr),
    
    self.curpageNum = 0;
    
    _refresh=[[DJRefresh alloc] initWithScrollView:self.tableView delegate:self];
    _refresh.topEnabled = YES;
    _refresh.bottomEnabled  = YES;
    
    if (_type == eRefreshTypeProgress) {
        
        [_refresh registerClassForTopView:[DJRefreshProgressView class]];
    }
    
    [_refresh startRefreshingDirection:DJRefreshDirectionTop animation:YES];
    
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    [self requestListDataWithView:self.view];
}

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDataWithDirection:direction];
    });
}

- (void)addDataWithDirection:(DJRefreshDirection)direction{
    
    //下拉刷新
    if (direction == DJRefreshDirectionTop) {
        
        self.curpageNum = 0;
        self.stateR = 0;
    }else {
        
        self.stateR = 1;
        self.curpageNum ++;
    }
    
    [self requestListDataWithView:self.view];
}


//请求列表数据
- (void)requestListDataWithView:(UIView *)view{
    
    if([self getMember_id]){
        
        self.params[@"member_id"] = @([[self getMember_id] integerValue]);
    }
    self.params[@"curpage"] = @(self.curpageNum);
    self.params[@"is_admin"] = @(1);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Honor_URL
    params:self.params withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
                                                    
    NSLog(@"showdata ===--------==== %@",showdata);
        
    self.dataArray = showdata;
        
    [self.tableView reloadData];
    }];
}


-(void)yinBtnClick:(UIButton*)sender{
    
    NSInteger state1= [self.dataArray[sender.tag][@"honor_state"] integerValue];
    NSInteger state = state1 == 2 ? 1:2;
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Honor_ChangeStatus
    params:@{@"honor_id":@([self.dataArray[sender.tag][@"honor_id"]  integerValue]) ,@"type": @(state)} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
    
    NSLog(@"showdata ===--------==== %@",showdata);
    [self requestListDataWithView:self.view];
        
    }];
}

-(void)delBtnClick:(UIButton*)sender{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Honor_Del
    params:@{@"honor_id":@([self.dataArray[sender.tag][@"honor_id"] integerValue])} withModel:nil waitView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata ===--------==== %@",showdata);
        
        
        [self requestListDataWithView:self.view];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    NSString *cellIdentifier = @"honourCell";
    MYTHonourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary * dict =(NSDictionary *) self.dataArray[indexPath.row];
    cell.titleLab.text = dict[@"honor_name"];
    
    [cell.honourImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"honor_image"]]];
//    cell.imageView.image = [UIImage imageNamed:dict[@"honor_image"]];
    if ([dict[@"honor_state"] isEqualToString:@"1"]) {
//    if ([dict[@"显示"] isEqualToString:@"1"]) {
   
        self.typeStr = @"1";
        cell.imagHeight.constant = 115 ;
        [cell.contentView layoutIfNeeded];
        [cell.contentView updateConstraints];
        
        [cell.yinCangBtn setTitle:@"  隐藏" forState:UIControlStateNormal];
        [cell.yinCangBtn setTitleColor:[UIColor colorWithRed:156.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1] forState:UIControlStateNormal];
        [cell.yinCangBtn setImage:[UIImage imageNamed:@"隐藏"] forState:UIControlStateNormal];
        
    }else
        if([dict[@"honor_state"] isEqualToString:@"2"])
        {
        
        self.typeStr = @"2";
        cell.imagHeight.constant = 0;
        [cell.contentView layoutIfNeeded];
        [cell.contentView updateConstraints];
        
        [cell.yinCangBtn setTitle:@"  显示" forState:UIControlStateNormal];
        [cell.yinCangBtn setTitleColor:[UIColor colorWithRed:75.0/255.0 green:166.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
        [cell.yinCangBtn setImage:[UIImage imageNamed:@"显示"] forState:UIControlStateNormal];
    }
    
    cell.yinCangBtn.tag = indexPath.row;
    cell.deleteBtn.tag = indexPath.row;
    
    [cell.yinCangBtn addTarget:self action:@selector(yinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.yinCangBtn.tag = indexPath.row;

    
    [cell.deleteBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.tag = indexPath.row;

    
    [cell.bianjiBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.bianjiBtn.tag = indexPath.row;
    return cell;    
}

-(void)editBtnClick:(UIButton*)sender{
    
    MYTAddHonourTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTAddHonourTableViewController"];
    vc.title = @"编辑荣誉";
    
    [vc.params setValue:self.dataArray[sender.tag][@"honor_id"] forKey:@"honor_id"];
    
    NSDictionary * tempDict = @{
                              @"honor_name":self.dataArray[sender.tag][@"honor_name"],
                              @"honor_time":self.dataArray[sender.tag][@"honor_time"],
                              @"honor_image":self.dataArray[sender.tag][@"honor_image"]
                              };
    
    vc.pushDict = tempDict;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableDictionary*)params{
    if (!_params) {
        _params = [NSMutableDictionary new];
    }
    
    return _params;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
        
    }
    return _dataArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
