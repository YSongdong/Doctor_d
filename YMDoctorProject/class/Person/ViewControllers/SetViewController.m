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
#import "PersonViewModel.h"
#import "Person.h"
#import "MessageView.h"
#import <MBProgressHUD.h>
#import "CasheDisk.h"
#import <RongIMKit/RongIMKit.h>
#import "JPUSHService.h"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,SetTableViewCellDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic,strong)PersonViewModel *personModel ;
@property (nonatomic,strong)DemandModel *model ;
@property (nonatomic,strong)CasheDisk *cashe ;

@end
@implementation SetViewController
- (void)dealloc {
}


- (PersonViewModel *)personModel {
    if (!_personModel) {
        _personModel = [PersonViewModel new];
    }
    return _personModel ;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"设置" ;
    self.navigationController.navigationBar.hidden = NO ;
    [self setup];
    self.cashe = [CasheDisk new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.tabBarController.tabBar.hidden = YES ;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    
}
- (void)setup{
    
    _tableView.sectionFooterHeight = 20 ;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    [self.personModel settingWithParams:dic
                         andReturnBlock:^(id value) {
                             if ([value isKindOfClass:[DemandModel class]]) {
                                 self.model = value;
                                 [self.tableView reloadData];
                             }
    }];
}
- (IBAction)loginOutOrIn:(id)sender {
    
    //退出登录
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"确认退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [JPUSHService setTags:nil aliasInbackground:nil];

        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        [self removeUserInfo];
        [[RCIM sharedRCIM]clearUserInfoCache];
        [[RCIM sharedRCIM]disconnect:YES];
        window.rootViewController = nav ;

    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [controller addAction:action];
    [controller addAction:action1];
    [self.navigationController presentViewController:controller animated:YES completion:nil];
    
    
}

- (void)viewWillLayoutSubviews {
    
}


- (void)switchIndicatorClickedWithStatus:(NSInteger)status
                                 andCell:(SetTableViewCell *)cell{
    
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *url ;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [dic setObject:[NSString stringWithFormat:@"%ld",status] forKey:@"sound"];
        url = SOUND_URL;
    }else  {
        [dic setObject:[NSString stringWithFormat:@"%ld",status] forKey:@"vibrates"];
        url = ALERT_URL;
    }
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:url params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
        if (!error) {
            if (dic[@"vibrates"]) {
                [self setVibrates:dic[@"vibrates"]];
            }
            if (dic[@"sound"]) {
                [self setAlert:dic[@"sound"]];
            }
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetTableViewCell *cell = [SetTableViewCell setCelltableViewWithTableView:tableView andIndexPath:indexPath];
    
    cell.delegate = self ;
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.titleName.text = @"密码修改";

        }
        if (indexPath.row == 1) {
        
            cell.titleName.text = @"支付密码修改";
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            cell.openSound = [self.model.sound integerValue];
            cell.titleName.text = @"消息铃声提醒";
        }
        
        if (indexPath.row == 1) {
            cell.titleName.text = @"消息震动提醒";
            cell.openSound = [self.model.vibrates integerValue];
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            cell.titleName.text = @"清除缓存";
            cell.detailLabel.text = [NSString stringWithFormat:@"%@",[self.cashe getcashSize]] ;

        }
        if (indexPath.row == 1) {
            cell.titleName.text = @"当前版本";
            cell.detailLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        }
    }
    if (indexPath.section == 3) {
        cell.titleName.text = @"拨打客服电话";
        cell.detailLabel.text = self.model.mobile ;
        
    }
    return cell ;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3) {
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

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        SetTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        ChangePassViewController *chanVC = [[ChangePassViewController alloc]init];
        chanVC.title = cell.titleName.text;
        
        chanVC.type = indexPath.row;
        
        [self.navigationController pushViewController:chanVC animated:YES];
    }

    if (indexPath.section == 2 && indexPath.row == 0) {
        
      SetTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
      MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.7];
        hud.contentColor = [UIColor colorWithWhite:1 alpha:1];
        [hud showAnimated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                    [self.cashe action];
                           [hud hideAnimated:YES];
                cell.detailLabel.text = [NSString stringWithFormat:@"缓存0.0M"];
        });
    }
    if (indexPath.section == 3) {
        
        [self callNumber];
    }
}
- (void)callNumber {
    if (!self.model.mobile) {
        [self alertViewShow:@"未获取到客服号码"];
        return ;
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:self.model.mobile delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
     [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.mobile]]];
    }
}





@end
