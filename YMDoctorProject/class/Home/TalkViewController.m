//
//  TalkingViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TalkViewController.h"
#import <RongIMKit/RongIMKit.h>

@interface TalkViewController ()

@end

@implementation TalkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
