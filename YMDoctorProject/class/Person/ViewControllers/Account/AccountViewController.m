//
//  AccountViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/12.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountCell.h"
#import "PersonViewModel.h"
#import "BillViewController.h"
#import "WithDrawSureViewController.h"

@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)PersonViewModel *viewModel ;
@property (nonatomic,strong)NSString *money ;
@property (nonatomic,strong)NSString *havePayPass ;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.money = @"0.00";
    
    [self setup];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"账单记录" style:UIBarButtonItemStyleDone target:self action:@selector(accountRecordBtnClick:)];
}

-(void)accountRecordBtnClick:(UIButton *)sender{
        
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MYTAccountRecordViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (PersonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
    }
    return _viewModel ;
}

- (void)setup {

    _tableView.sectionFooterHeight = 10 ;
  
//    [self addRightButton];
//    [self.rightButton setTitle:@"管理"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.hidden = NO ;
    self.tabBarController.tabBar.hidden = YES ;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    [self.viewModel requestPersonalAccountWithParams:dic
       andCommpleteBlock:^(id  value) {
           if (value) {
               self.money = value[@"available_predeposit"];
               self.havePayPass = value[@"is_paypwd"];
               [self.tableView reloadData];
           }else {
               [self alertViewShow:@"请求错误"];
           }
    }];
}

//- (void)rightButtonClickOperation {
//   [self performSegueWithIdentifier:@"AccountManagerIdentifier" sender:nil];
//}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
   
    return 1 ;   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountCell *cell ;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"acountCellHeadIdentifier"];
        cell.moneyLabel.text = self.money ;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"accountCellIdentifier"];
        if (indexPath.section == 1) {
            cell.headImageView.image = [UIImage imageNamed:@"demand_order_incom"];
            cell.titleLabel.text = @"需求订单收入";
        }
        
        if (indexPath.section == 2) {
            
            cell.headImageView.image = [UIImage imageNamed:@"employer_income"];
            cell.titleLabel.text = @"直接雇佣收入";
        }
    }
    
    return cell ;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.0001f ;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        return 220 ;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"billViewControllerIdentifier" sender:indexPath];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"billViewControllerIdentifier"]) {
        BillViewController *billVc= segue.destinationViewController ;
        NSIndexPath *indexPath  =(NSIndexPath *)sender ;
        if (indexPath.section == 1) {
            billVc.type = demandOrderType ;
        }
        if (indexPath.section == 2) {
            billVc.type = EmployerOrderType ;
        }
    }
    if ([segue.identifier isEqualToString:@"withDrawIndetifer"]) {
        
        WithDrawSureViewController *sureVC = segue.destinationViewController ;
        sureVC.money  = self.money ;
        sureVC.havePayPass= self.havePayPass ;
    }
}

@end
