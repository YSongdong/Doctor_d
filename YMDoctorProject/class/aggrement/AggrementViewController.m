//
//  AggrementViewController.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AggrementViewController.h"

@interface AggrementViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation AggrementViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self ;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.view add_Indactor];    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    self.tabBarController.tabBar.hidden = YES ;
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.view stopIndactor];
    [self alertViewShow:@"加载失败"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view stopIndactor];
}
@end
