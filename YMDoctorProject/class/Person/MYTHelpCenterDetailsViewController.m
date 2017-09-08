//
//  MYTHelpCenterDetailsViewController.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/5/31.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MYTHelpCenterDetailsViewController.h"

@interface MYTHelpCenterDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation MYTHelpCenterDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestDataWithView:self.view];
    
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.webView setScalesPageToFit:YES];
    
}

- (void)requestDataWithView:(UIView *)view{
    
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:HelpContent_URL
    params:@{@"article_id":@([self.article_id integerValue])} withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                
        if (showdata == nil) {
            
            return ;
        }
       [self.webView loadHTMLString:showdata[@"content"]  baseURL:nil];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

