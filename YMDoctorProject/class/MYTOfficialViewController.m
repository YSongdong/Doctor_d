//
//  MYTOfficialViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOfficialViewController.h"
#import "UIView+tool.h"
#import "MYTOfficialTableViewCell.h"
#import "SDCycleScrollView.h"

#import "MYTOfficialDetailsViewController.h"

@interface MYTOfficialViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//tag 线条200 开始 按钮 100 开始
@property (weak, nonatomic) IBOutlet UIView *anniuBtnView;
// 过去的按钮
@property (nonatomic,strong) UIButton * oldBtn;
@property (nonatomic,strong) UIView * oldXt;

@property (weak, nonatomic) IBOutlet SDCycleScrollView *saveScrollView;

@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NSMutableArray * headArray;

@end

@implementation MYTOfficialViewController

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

-(NSMutableArray *)headArray{
    if (_headArray==nil) {
        _headArray = [[NSMutableArray alloc]init];
    }
    return _headArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.params = [NSMutableDictionary new];
    
    UIButton * startBtn = [self.anniuBtnView viewWithTag:100];
    [self btnClick:startBtn];
    
    self.tableView.estimatedRowHeight = 50.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.saveScrollView.hidden = NO;
    
    self.tableView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.saveScrollView.delegate = self;
    self.saveScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

//请求  活动大厅  列表数据
- (void)requestListDataWithView:(UIView *)view{
    
    self.params[@"type"] = @(1);
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Activities_URL
    params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
    NSLog(@"showdata----------%@",showdata);
        
    if (showdata == nil){
        return ;
    }
        
    self.headArray = showdata[@"activity_banner"];
        
    NSMutableArray *imageArray = [NSMutableArray new];
    for (int i = 0; i < self.headArray.count; i++) {
            
        NSString *imageStr = self.headArray[i][@"adv_image"];
        [imageArray addObject:imageStr];
    }
    self.saveScrollView.imageURLStringsGroup = imageArray;
    
//    id activity_listStr = showdata[@"activity_list"];
//    if ([activity_listStr isKindOfClass:[NSMutableArray class]] ) {
//        self.dataArray = activity_listStr;
//    }
        
    self.dataArray = showdata[@"activity_list"];
        
    NSLog(@"dataArray------------%@",self.dataArray);
        
//    self.dataArray = showdata[@"activity_list"];
        
    [self.tableView reloadData];
    }];
}


//请求   我参与的    列表数据
- (void)requestDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Activities_ApplyList
    params:@{
             @"member_id":@([[self getMember_id] integerValue])
             }withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata----------------%@",showdata);
                 
        if (showdata == nil){
            return ;
        }
        
        self.dataArray = showdata;
        
        [self.tableView reloadData];
    }];
}


- (IBAction)btnClick:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"我参与的"]) {
        self.saveScrollView.hidden = YES;
        
        [self requestDataWithView:self.view];
    }
    if ([sender.titleLabel.text isEqualToString:@"活动大厅"]) {
        self.saveScrollView.hidden = NO;
        
        [self requestListDataWithView:self.view];
    }
    
    if (self.oldBtn!=sender) {
        self.oldBtn.selected = NO;
        self.oldBtn = sender;
        self.oldBtn.selected = YES;
        NSInteger xtTag =  sender.tag+100;
        if (self.oldXt) {
            [self.oldXt setBackGroundColorWithHexColor:@"949596"];
        }
        self.oldXt = [self.anniuBtnView viewWithTag:xtTag];
        [self.oldXt setBackGroundColorWithHexColor:@"4293E3"];
        
        if (self.oldBtn.tag == 101) {
            self.tableView.contentInset =UIEdgeInsetsMake(-136, 0, 0, 0);
        }else{
            self.tableView.contentInset =UIEdgeInsetsMake(64, 0, 0, 0);
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        
    NSString *cellIdentifier = @"officialCell";
    MYTOfficialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setContentData:self.dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hidesBottomBarWhenPushed = YES;
    MYTOfficialDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOfficialDetailsViewController"];
    vc.activity_id = self.dataArray[indexPath.row][@"activity_id"];
    [self.navigationController pushViewController:vc animated:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
