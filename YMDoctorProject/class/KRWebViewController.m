//
//  KRWebViewController.m
//  fitnessDog
//
//  Created by kupurui on 17/2/4.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "KRWebViewController.h"

@interface KRWebViewController ()<UIWebViewDelegate>

@end

@implementation KRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"加载中。。。";
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 64)];
    webView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    if ([self.saoceUrl hasPrefix:@"https://"] ) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.saoceUrl]]];
    }
    else {
        
        if (self.saoceUrl.length> 0) {            
            self.saoceUrl = [@"https://" stringByAppendingString:self.saoceUrl];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.saoceUrl]]];

        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    //self.navigationController.navigationBar.translucent = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    //self.navigationController.navigationBar.translucent = NO;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
//失败返回
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    [self showErrorWithTitle:@"加载失败" autoCloseTime:2];
    
}


@end
