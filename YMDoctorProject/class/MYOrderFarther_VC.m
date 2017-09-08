//
//  MYOrderFarther_VC.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

#import "HY3TabbarView.h"
#import "MYOrderFarther_VC.h"

#import "DemandOrderViewController.h"
#import "EmployerOrderViewController.h"
#import "IncurableOrderViewController.h"


@interface MYOrderFarther_VC ()

@property (nonatomic,strong) HY3TabbarView * tabbarView;

@end

@implementation MYOrderFarther_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tabbarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

//懒加载
- (HY3TabbarView *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = ({
            HY3TabbarView * tabbar = [[HY3TabbarView alloc]initWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            
            DemandOrderViewController *vc0 = [self.storyboard instantiateViewControllerWithIdentifier:@"DemandOrderViewController"];
            vc0.title = @"鸣医订单";
            vc0.view.backgroundColor = [UIColor redColor];
            vc0.fartherVC = self;
            [tabbar addSubItemWithViewController:vc0];
            
            
            EmployerOrderViewController * vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerOrderViewController"];
            vc1.title = @"预约订单";
            vc1.view.backgroundColor = [UIColor greenColor];
            vc1.fartherVC = self;
            [tabbar addSubItemWithViewController:vc1];
            
            
            IncurableOrderViewController * vc2 = [self.storyboard instantiateViewControllerWithIdentifier:@"IncurableOrderViewController"];
            vc2.title = @"出售的服务";
            vc2.view.backgroundColor = [UIColor blueColor];
            vc2.fartherVC = self;
            [tabbar addSubItemWithViewController:vc2];
            
            tabbar;
        });
    }
    
    return _tabbarView;
}


@end

