//
//  SetViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SetViewController.h"
#import "SetTableViewCell.h"
#import "ChangePassViewController.h"
#import "LoginViewController.h"


@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation SetViewController


- (void)dealloc {
    
    NSLog(@"---------");
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"设置" ;
    self.navigationController.navigationBar.hidden = NO ;
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
}
- (void)viewDidAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = YES ;    
    [super viewDidAppear:animated];
    NSLog(@"%@",self.view);
    NSLog(@"------>%@",self.tableView);
    NSLog(@"--------====>%@",self.loginBtn);
    
}

- (void)setup{
    
    _tableView.sectionFooterHeight = 20 ;
    
}

- (IBAction)loginOutOrIn:(id)sender {
       LoginViewController *login = [[LoginViewController alloc]init];
         UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:^{
        }];

}

- (void)viewWillLayoutSubviews {
    
    NSLog(@"%@",_loginBtn);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetTableViewCell *cell = [SetTableViewCell setCelltableViewWithTableView:tableView andIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleName.text = @"密码修改";
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.titleName.text = @"消息铃声提醒";
        }
        if (indexPath.row == 1) {
            cell.titleName.text = @"消息震动提醒";
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            cell.titleName.text = @"清楚缓存";
        }
        if (indexPath.row == 1) {
            cell.titleName.text = @"版本更新";
        }
    }
    if (indexPath.section == 3) {
        cell.titleName.text = @"拨打客服电话";
    }
    return cell ;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 3) {
        return 1 ;
    }
        return 2 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4 ;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 20 ;
    }
    return 0.001f ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ChangePassViewController *chanVC = [[ChangePassViewController alloc]init];
        [self.navigationController pushViewController:chanVC animated:YES];
        
    }
    
    
}





@end
