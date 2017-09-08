//
//  SDHosporViewController.m
//  YMDoctorProject
//
//  Created by dong on 2017/8/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SDHosporViewController.h"

#import "SDNewShareView.h"

#import <UMSocialCore/UMSocialCore.h>

@interface SDHosporViewController ()

@end

@implementation SDHosporViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor  whiteColor];
    [self createWebView];
    [self initShareView];
}
//创建分享按钮
-(void)initShareView{

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"doctor_share"] style:UIBarButtonItemStylePlain target:self action:@selector(selectdShareBtnAction)];
    self.navigationItem.rightBarButtonItem = rightItem;

}
-(void)selectdShareBtnAction{
  
        BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
        BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
        
        NSMutableArray *titlearr = [NSMutableArray arrayWithCapacity:5];
        NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:5];
        
        int startIndex = 0;
        
        if (hadInstalledWeixin) {
            [titlearr addObjectsFromArray:@[@"微信", @"微信朋友圈"]];
            [imageArr addObjectsFromArray:@[@"person",@"friends"]];
        } else {
            startIndex += 2;
        }
        
        if (hadInstalledQQ) {
            [titlearr addObjectsFromArray:@[@"QQ", @"QQ空间"]];
            [imageArr addObjectsFromArray:@[@"qq",@"qzone"]];
        } else {
            startIndex += 2;
        }
    
        [titlearr addObjectsFromArray:@[@"微博"]];
        [imageArr addObjectsFromArray:@[@"sina"]];
    
        __weak typeof(self) weakSelf = self;
        
        SDNewShareView *newShareView = [[SDNewShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"分享到"];
        [newShareView setBtnClick:^(NSInteger btnTag) {
            NSLog(@"\n点击第几个====%d\n当前选中的按钮title====%@",(int)btnTag,titlearr[btnTag]);
            switch (btnTag + startIndex) {
                case 0: {
                    // 微信
                     [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatSession];
                }
                    break;
                case 1: {
                    // 微信朋友圈
                    [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine];
                }
                    break;
                case 2: {
                    // QQ
                    [weakSelf shareImageToPlatformType:UMSocialPlatformType_QQ];
                }
                    break;
                case 3: {
                    // QQ空间
                    [weakSelf shareImageToPlatformType:UMSocialPlatformType_Qzone];
                }
                    break;
                case 4: {
                    // 微博
                    [weakSelf shareImageToPlatformType:UMSocialPlatformType_Sina];
                }
                    break;
                default:
                    break;
            }
        }];
        [[UIApplication sharedApplication].keyWindow addSubview:newShareView];
  

}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title =@"分享";
    //创建图片内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.shopTitle descr:@"我正在使用鸣医通，看病找专家，预约不排队，快来试试吧！" thumImage:[UIImage imageNamed:@"login_background_image"]];
//    NSString *url;
//    url = @"http://ys9958.com/shop/index.php?act=invite&op=reg";
//    shareObject.webpageUrl = [url stringByAppendingFormat:@"&inviter_id=%@&type=1",[YMUserInfo sharedYMUserInfo].member_id];
    
    shareObject.webpageUrl = self.url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
  
}
-(void)setUrl:(NSString *)url{

    _url = url;

}
-(void)setShopTitle:(NSString *)shopTitle{

    _shopTitle = shopTitle;
    self.navigationItem.title = shopTitle;
}
-(void) createWebView{

    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
