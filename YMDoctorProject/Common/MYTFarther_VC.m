//
//  MYTFarther_VC.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTFarther_VC.h"

@interface MYTFarther_VC ()

@end

@implementation MYTFarther_VC




-(DJRefresh *)refresh{
    if (_refresh==nil) {
        DJRefresh *refresh  = [DJRefresh refreshWithScrollView:self.tableView];
        
        
        
        
        _refresh = refresh;
    }
    return _refresh;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.refresh.topEnabled = YES;
    self.refresh.bottomEnabled = YES;
//    self.refresh.enableInsetTop = 128;
//    self.refresh.enableInsetBottom = 128;
   
    
    
    __weak typeof(self) weakSelf = self;
    [self.refresh didRefreshCompletionBlock:^(DJRefresh *refresh, DJRefreshDirection direction, NSDictionary *info) {
        
        
        [weakSelf didRefreshComplectWith:refresh direction:direction info:info];
    }];
    
     [self.refresh startRefreshingDirection:DJRefreshDirectionTop animation:YES];
}


-(void)didRefreshComplectWith:(DJRefresh*)refresh direction:(DJRefreshDirection)direction info:(NSDictionary *)info{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
