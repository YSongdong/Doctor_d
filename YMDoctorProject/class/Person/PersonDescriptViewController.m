//
//  PersonDescriptViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PersonDescriptViewController.h"
#import "PersonViewModel.h"
#import "CertificationViewController.h"
#import "QualificationViewController.h"
#import "ReviewViewController.h"
typedef enum : NSUInteger {
    
    authenUnknow ,
    authenSuccess,
    authenFailure,
    authening,
    unAuthen
    
} AuthenStatus;

@interface PersonDescriptViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)PersonViewModel *viewModel ;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,assign)AuthenStatus authenStatus ;




@end

@implementation PersonDescriptViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUp];
    _tableView.sectionFooterHeight= 10 ;
}

- (PersonViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [PersonViewModel new];
    }
    return _viewModel ;
}

- (void)setUp {
    
    self.navigationController.navigationBar.hidden = NO ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES ;
    [self makeSureIsCertification];

}



//判断是否认证
- (void)makeSureIsCertification {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
    }
    [self.viewModel authentificationStatusWithParams:dic andReturnBlock:^(id value, NSString *reason) {
        
        if (value) {
            NSInteger status = [value integerValue];
            if (status == 40) {
                //                                                                                          成功
                self.authenStatus = authenSuccess ;
            }
            if (status == 30) {
                self.authenStatus = authenFailure ;
                [self alertViewShow:reason];
            }
            if (status == 10) {
                self.authenStatus = authening ;
            }
            if (status == 1) {
                self.authenStatus =  unAuthen ;
            }
        }else{
            self.authenStatus = authenUnknow ;
            [self alertViewShow:reason];
        }
    }];
}

- (void)setAuthenStatus:(AuthenStatus)authenStatus {
    _authenStatus = authenStatus ;
}



- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 ;
}
-  (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCellIdentifier"];    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"个人简介";
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = @"实名认证";
    }
    if (indexPath.section == 2) {
        
        cell.textLabel.text = @"资质提交";
    }
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10 ;
    }
    return 0.001f ;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UIViewController *vc =[[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"changeIntroduceIdentifier"];
        [self.navigationController pushViewController:vc animated:YES];
        return ;

    }
    if (self.authenStatus == authening) {
        ReviewViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"ReviewViewController"];
        [self.navigationController pushViewController:vc animated:YES];
        return ;
    }
    if (indexPath.section == 1) {
        CertificationViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"CertificationViewControllerIdentifier"];
        [self.navigationController pushViewController:vc animated:YES];
        if (self.authenStatus == authenSuccess) {
            vc.isAuthen = YES ;
        }
        return ;
    }
    
    if (indexPath.section == 2) {
        
        if (self.authenStatus == unAuthen) {
            CertificationViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"CertificationViewControllerIdentifier"];
            [self.navigationController pushViewController:vc animated:YES];
            return ;
        }

        QualificationViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"QualificationViewControllerIdentifier"];
         [self.navigationController pushViewController:vc animated:YES];
        
        if (self.authenStatus == authenSuccess) {
            vc.isAuthen = YES ;
        }
    }
}

@end
