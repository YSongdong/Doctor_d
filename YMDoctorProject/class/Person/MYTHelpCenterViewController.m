//
//  MYTHelpCenterViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTHelpCenterViewController.h"
#import "MYTHelpCenterTableViewCell.h"

#import "MYTHelpCenterDetailsViewController.h"

@interface MYTHelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)NSMutableArray *dataArr;

@end

@implementation MYTHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDataWithView:self.view];
    
    
}

- (void)requestDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:HelpCenter_URL
    params:@{@"type":@(1)} withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                
        if (showdata == nil) {
            
            return ;
        }
        
        self.dataArr = showdata;
        
        [self.tableView reloadData];
    }];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"helpCenterCell";
    MYTHelpCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.contentLab.text = self.dataArr[indexPath.row][@"article_title"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYTHelpCenterDetailsViewController *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTHelpCenterDetailsViewController"];
    detailsVC.article_id = self.dataArr[indexPath.row][@"article_id"];
    [self.navigationController pushViewController:detailsVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
