//
//  MYTOfficialDetailsViewController.m
//  MYTDoctor
//
//  Created by kupurui on 2017/5/20.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "MYTOfficialDetailsViewController.h"
#import "MYTOfficialDetailsTableViewCell.h"
#import "MYTOfficialApplyViewController.h"
#import "ActivitiesShareView.h"
#import <UShareUI/UShareUI.h>
#import "Share.h"


@interface MYTOfficialDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong)NSMutableDictionary *params;
@property (nonatomic, strong)NSMutableDictionary *dataDict;

@property (nonatomic,strong)ActivitiesShareView *activitiesShareView;

@property (weak, nonatomic) IBOutlet UIButton *joinBtn;

@end

@implementation MYTOfficialDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"活动详情";
    
    self.params = [NSMutableDictionary new];
    self.dataDict = [NSMutableDictionary new];
    
    self.joinBtn.clipsToBounds = YES;
    self.joinBtn.layer.cornerRadius = self.joinBtn.frame.size.height/2;
    
  //  [self createRightBarButtonItem];
    
    [self requestListDataWithView:self.view];

    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.webView setScalesPageToFit:YES];
     
}

//请求列表数据
- (void)requestListDataWithView:(UIView *)view{
    
    if ([self getMember_id]) {
        
        self.params[@"member_id"] = [self getMember_id];
    }
    
    self.params[@"activity_id"] = self.activity_id;
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:Activities_Detail
    params:self.params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
        
        if (showdata == nil){            
            return ;
        }

        self.dataDict = showdata;

        NSString *stauts = self.dataDict[@"stauts"];
        
        if (![stauts isEqualToString:@"0"]) {
            
            [self.joinBtn setTitle:self.dataDict[@"stauts_str"] forState:UIControlStateNormal];
        }
        
        [self.webView loadHTMLString:self.dataDict[@"content"]  baseURL:nil];

        [self.tableView reloadData];
    }];
}

- (void)createRightBarButtonItem{
    
    // 自定义导航栏右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width-46, 0, 44, 44);
    
    [rightBtn setImage:[UIImage imageNamed:@"转发"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(onRightTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

// 右侧导航栏点击事件处理
- (void)onRightTap {
    
    [self shareContentShow];
}

- (void)shareContentShow {
    
    ActivitiesShareView *shareView = [ActivitiesShareView sharePlatViewWithAnimation];
    [shareView showAnimation];
    
    self.activitiesShareView = shareView;

    shareView.shareBlock = ^(UMSocialPlatformType platform,ShareType type){
    
        Share *share = [Share new];
        
        NSString *url = [NSString stringWithFormat:@"http://ys9958.com/api/index.php?act=activities&op=activityShare&activity_id=%@",self.activity_id];
        
        [share shareWebPageToPlatformType:platform shareUrl:url shareConnet:nil];
    };
}

//点击报名参加按钮
- (IBAction)joinBtnClick:(id)sender {
    
    NSString *stauts = self.dataDict[@"stauts"];
    
    if ([stauts isEqualToString:@"0"]) {
    
        MYTOfficialApplyViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MYTOfficialApplyViewController"];
        vc.activity_id = self.dataDict[@"activity_id"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
