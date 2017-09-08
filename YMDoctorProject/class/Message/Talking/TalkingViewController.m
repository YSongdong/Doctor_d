//
//  TalkingViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/13.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "TalkingViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface TalkingViewController ()
@end
@implementation TalkingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES ;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.tabBarController.tabBar.hidden = NO ;
}

@end
