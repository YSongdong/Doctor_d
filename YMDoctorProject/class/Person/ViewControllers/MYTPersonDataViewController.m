
//
//  MYTPersonDataViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTPersonDataViewController.h"

#import "MYTCertificationViewController.h"
#import "QualificationViewController.h"
#import "MYTBasicInformationViewController.h"
#import "NetWorkTool.h"
#import "ReviewViewController.h"

#import "MYTQualificationAuditViewController.h"


@interface MYTPersonDataViewController ()<UIAlertViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSArray *textLabelArr;
@property (nonatomic, strong)NSArray *detailTextLabelArr;
@property (nonatomic, strong)NSArray *textColorArr;

@property (nonatomic, strong)NSArray *contentArr;

@property (nonatomic,copy) NSString * complete_status;

@property (nonatomic,strong) NSMutableDictionary * params;


@end

@implementation MYTPersonDataViewController

-(NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary new];
    }
    return _params;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.textLabelArr = [NSArray arrayWithObjects:@"实名认证", @"资质提交", @"基本信息", nil];
    self.detailTextLabelArr = [NSArray arrayWithObjects:@"已认证", @"未提交", @"尚未填写", nil];
    UIColor *text1Color = [UIColor colorWithRed:89.0/255.0 green:173.0/255.0 blue:254.0/255.0 alpha:1];
    UIColor *text2Color = [UIColor colorWithRed:249.0/255.0 green:164.0/255.0 blue:0.0/255.0 alpha:1];
    UIColor *text3Color = [UIColor colorWithRed:157.0/255.0 green:159.0/255.0 blue:159.0/255.0 alpha:1];
    self.textColorArr = [NSArray arrayWithObjects:text1Color, text2Color, text3Color, nil];
    
    self.complete_status = @"1";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [NetWorkTool GetPerson_complateStatusWithView:self.view complateHandle:^(id showdata, NSString *error) {
        
        NSLog(@"showdata------------%@",showdata);
        
        if ([showdata isKindOfClass:[NSDictionary class]]) {
            
            [self.params setValuesForKeysWithDictionary:showdata];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = @"PersonDataCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.textLabel.text = self.textLabelArr[indexPath.section];
    cell.detailTextLabel.text = self.detailTextLabelArr[indexPath.section];

    if (indexPath.section == 0) {
        
        cell.detailTextLabel.textColor = self.textColorArr[0];

        if ([self.params[@"realname_auth_status"] isEqualToString:@"0"]) {
            //        未认证
            cell.detailTextLabel.text = @"未认证";
            
        }else{
            //        已认证
            cell.detailTextLabel.text = @"已认证";
        }
        
    }else if (indexPath.section == 1) {
        
        cell.detailTextLabel.textColor = self.textColorArr[1];
        
        if ([self.params[@"qualification_status"] isEqualToString:@"10"]) {
            //        未认证
            cell.detailTextLabel.text = @"资质审核中";
            
        }
        if ([self.params[@"qualification_status"] isEqualToString:@"30"]) {
            //        未认证
            cell.detailTextLabel.text = @"资质审核失败";
            
        }
        if ([self.params[@"qualification_status"] isEqualToString:@"40"]) {
            //        未认证
            cell.detailTextLabel.text = @"资质审核成功";
        }
    }else if (indexPath.section == 2) {
        
        cell.detailTextLabel.textColor = self.textColorArr[2];
        
        if ([self.params[@"info_status"] isEqualToString:@"0"]) {
            //        未认证
            cell.detailTextLabel.text = @"基本信息尚未填写";
            
        }else{
            //        已认证
            cell.detailTextLabel.text = @"基本信息已完成";
        }
    }
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case 0:{
            
            //实名认证
            MYTCertificationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTCertificationViewController"];
            vc.status = self.params[@"realname_auth_status"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
           
        case 1:{
            
            if ([self.params[@"realname_auth_status"] isEqualToString:@"0"]) {
                
                [self alertViewShow:@"请先进行实名认证"];
                
                return;
            }
                       
            if ([self.params[@"qualification_status"] isEqualToString:@"10"] || [self.params[@"qualification_status"] isEqualToString:@"30"]) {
                
//                [self alertViewShow:@"你还没有通过资质审核"];
                
                MYTQualificationAuditViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"MYTQualificationAuditViewController"];
                [self.navigationController pushViewController:vc animated:YES];

            }else{
                
                //资质提交
                QualificationViewController *vc = [[UIStoryboard storyboardWithName:@"PersonDescriptViewController" bundle:nil]instantiateViewControllerWithIdentifier:@"QualificationViewControllerIdentifier"];
                vc.status = self.params[@"qualification_status"];
                [self.navigationController pushViewController:vc animated:YES];
            }

        }
            break;
            
        case 2:{
            
            if ([self.params[@"qualification_status"] isEqualToString:@"10"] || [self.params[@"qualification_status"] isEqualToString:@"30"]) {
                
                [self alertViewShow:@"你还没有通过资质审核"];
                
                return;
            }

            //基本信息
            MYTBasicInformationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTBasicInformationViewController"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
