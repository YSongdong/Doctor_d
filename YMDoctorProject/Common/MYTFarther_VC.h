//
//  MYTFarther_VC.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//
#import "DJRefresh.h"
#import <UIKit/UIKit.h>

@interface MYTFarther_VC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) DJRefresh *refresh ;
// 0 是刷新 1 是加载
@property (nonatomic,assign) int stateR;
//页数
@property (nonatomic, assign) NSInteger curpageNum;

-(void)didRefreshComplectWith:(DJRefresh*)refresh direction:(DJRefreshDirection)direction info:(NSDictionary *)info;
@end
