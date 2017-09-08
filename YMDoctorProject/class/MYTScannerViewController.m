//
//  MYTScannerViewController.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/22.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTScannerViewController.h"

@interface MYTScannerViewController ()

@end

@implementation MYTScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
