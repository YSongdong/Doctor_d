//
//  MYTOrderViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/11.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTRankViewController.h"
#import "MYTRankTableViewCell.h"
#import "MYTHomePageViewController.h"

#import "YMDoctorHomePageViewController.h"


@interface MYTRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *dic;

@end

@implementation MYTRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"服务明星排行榜";
    
    [self requestDataWithView:self.view];
}

//请求列表数据
- (void)requestDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Rank_URL
    params:nil withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
    self.dataArray = showdata;
        
    [self.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"rankCell";
    MYTRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setContentData:self.dataArray[indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //我的主页
//    MYTHomePageViewController *homePageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTHomePageViewController"];
//    
//   // homePageVC.dictionary = self.dataArray[indexPath.row];
//    homePageVC.store_id = self.dataArray[indexPath.row][@"store_id"];
    
    YMDoctorHomePageViewController *homePageVC = [[YMDoctorHomePageViewController alloc]init];
    homePageVC.store_id =self.dataArray[indexPath.row][@"store_id"];
    homePageVC.isUserDoctor = NO;
    [self.navigationController pushViewController:homePageVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
