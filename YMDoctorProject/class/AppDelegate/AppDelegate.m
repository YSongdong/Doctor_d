//
//  AppDelegate.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import <RongIMKit/RongIMKit.h>
#import "LoginViewController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max

#import <UserNotifications/UserNotifications.h>
#import "DemandHallDetailViewController.h"
#endif

#import "Masonry.h"
#import "DemandModel.h"
#import <AVFoundation/AVFoundation.h>
#import "YMAdvertisePageViewController.h"

#import "HomeViewController.h"
#import "YMGuidePageViewController.h"

static NSString *const FirstEnterTheHomepage = @"FirstEnterTheHomepage";

@interface AppDelegate ()<RCIMReceiveMessageDelegate,RCIMUserInfoDataSource,JPUSHRegisterDelegate,RCIMConnectionStatusDelegate,YMAdvertisePageViewControllerDelegate,YMGuidePageViewControllerDelegate>

@property (nonatomic,strong)UIView *topView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    _window.backgroundColor = [UIColor whiteColor];
    
    [self advertisePage];

    if(![[NSUserDefaults standardUserDefaults] boolForKey:FirstEnterTheHomepage]){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longinSuccess) name:@"longinSuccess" object:nil];
    }
    
    [[RCIM sharedRCIM]initWithAppKey:@"p5tvi9dsp6ap4"];
    [self configHuanxin];
    [[RCIM sharedRCIM]setUserInfoDataSource:self];
    [RCIM sharedRCIM].receiveMessageDelegate = self ;
    [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
    [RCIM sharedRCIM].connectionStatusDelegate = self ;
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5895d51cf43e481ec8000d48"];
    [self configUSharePlatforms];
    
    //极光推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"fcbcee7550c33ca4ad58d430"
                          channel:nil
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    
    return YES;
}

//设置Window chongxin delngu
-(void)setWindow{
    //jinqu
    
    NSLog(@"getMember_id----------------%@",[self getMember_id]);
    
    if (![self getMember_id]) {
        
        _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init] ];
        
    }else{
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:FirstEnterTheHomepage]){
            YMGuidePageViewController *vc = [YMGuidePageViewController new];
            
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:FirstEnterTheHomepage];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            //jinqua jinqu
            vc.delegate = self;
            self.window.rootViewController =vc;
            [self.window makeKeyAndVisible];
            
        }else{
        
//            _window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init] ];
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow ;
            UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateInitialViewController];
            window.rootViewController = vc ;
        }
    }
}

- (void)configUSharePlatforms {
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2c0732cbd24c633a" appSecret:@"dbd6622b491eb2d4d14226b819c90719" redirectURL:@"https://ys9958.com//api//index.php?act=users_hire&op=gvrp"];
//    /*
//     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//     */
    NSString *string  = [NSString stringWithFormat:@"1105972810"];
       [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:string appSecret:nil redirectURL:@"https://ys9958.com//api//index.php?act=users_hire&op=gvrp"];
//
//    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"4146579012"  appSecret:@"7715389774dbc1bec483e3b146622e0e" redirectURL:@"https://ys9958.com//api//index.php?act=users_hire&op=gvrp"];

}

- (void)configHuanxin {

    KRMainNetTool *tool = [KRMainNetTool new];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
    if ([self getMember_id]) {
        [dic setObject:[self getMember_id] forKey:@"member_id"];
        [tool sendRequstWith:Get_Token_Url params:dic
           withModel:nil complateHandle:^(id showdata, NSString *error) {
           if (showdata) {
               if ([showdata isKindOfClass:[NSDictionary class]]) {
                  NSString *token = showdata[@"huanxinpew"];
                   [[RCIM sharedRCIM]connectWithToken:token success:^(NSString *userId) {
                       
                       RCUserInfo *userInfo = [[RCUserInfo alloc]initWithUserId:userId name:[self getUserName] portrait:[self getAvatar]];
                       [RCIM sharedRCIM].currentUserInfo = userInfo;
                   } error:^(RCConnectErrorCode status) {
                   } tokenIncorrect:^{
                       
                   }];
               }
           }
       }];
    }
}

- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left {
    
    NSInteger count =  [[RCIMClient sharedRCIMClient]getTotalUnreadCount];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];
    if ([[self getVibrates]isEqualToString:@"1"]) {
            AudioServicesPlaySystemSound(1600);
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    //取消震动
    else {
        
    }
    
    if (message.receivedStatus == ReceivedStatus_UNREAD) {
        
    }
    //铃声
}

- (BOOL)onRCIMCustomAlertSound:(RCMessage *)message {
    
    if ([[self getAlert] isEqualToString:@"1"]) {
        
        return YES ;
    }
    return NO;
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_Connected) {
        
    }
}

- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *))completion {
    
    RCUserInfo *userInfo =  [[RCIM sharedRCIM]currentUserInfo];
    if ([userId isEqualToString:userInfo.userId]) {
        userInfo.name = [self getUserName];
        userInfo.portraitUri = [self getAvatar];
        return completion(userInfo);
    }
    else {
        
        NSDictionary *dic = @{@"member_id":userId};
        [[KRMainNetTool sharedKRMainNetTool ]sendRequstWith:Get_userInfo_URl params:dic withModel:nil waitView:nil complateHandle:^(id showdata, NSString *error) {
            if (!error) {
                NSString *name = @"" ;
                if (![showdata[@"member_names"]isEqual:[NSNull null]]) {
                    name = showdata[@"member_names"];
                }
                NSString *portrait = showdata[@"member_avatar"];
                RCUserInfo *userInfo = [[RCUserInfo alloc]initWithUserId:userId name:name portrait:portrait];
                return completion(userInfo);
            }
        }];
    }
      // return completion(nil);
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return YES ;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:

(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [application setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-[UIScreen mainScreen].bounds.size.width, -[UIScreen mainScreen].bounds.size.height) forBarMetrics:UIBarMetricsDefault];
    
   
}


- (void)applicationWillTerminate:(UIApplication *)application {

}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        [self showTopViewWith:userInfo];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionSound); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}
- (void)showTopViewWith:(NSDictionary *)userInfo {
    
    if (_topView && _topView.superview) {
        [_topView removeFromSuperview];
        _topView = nil ;
    }
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    __block UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    //topLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    topLabel.font = [UIFont systemFontOfSize:13];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.text = userInfo[@"aps"][@"alert"];
    topLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *gesture  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickShowDemandHallDetail:)];
    objc_setAssociatedObject(self, "userInfo", userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    topLabel.userInteractionEnabled = YES ;
    [topLabel addGestureRecognizer:gesture];
    [_topView addSubview:topLabel];
    [self.window addSubview:_topView];
    UIButton *close = [[UIButton alloc]init];
    [_topView addSubview:close];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).with.offset(10);
        make.right.equalTo(_topView.mas_right).with.offset(-10);
    }];
    [close setImage:[UIImage imageNamed:@"取消"] forState:UIControlStateNormal];
    [close addTarget:self action:@selector(hiddenTop:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (void)didClickShowDemandHallDetail:(UITapGestureRecognizer *)gesture {
    
    [self jumpPage];
    
    if (gesture.view){
        
        [self hiddenTop:gesture.view.superview];
    }
}

- (void)jumpPage{
    
    id userInfo = objc_getAssociatedObject(self, "userInfo");
    
    NSLog(@"userInfo-----------------%@",userInfo);
    
    if (userInfo[@"extras"]){
        
        if (userInfo[@"extras"][@"member_id"] &&
            userInfo[@"extras"][@"demand_id"]) {
            
            if ([userInfo[@"extras"][@"type"]integerValue] != 1
                || [userInfo[@"extras"][@"type"]integerValue] != 2) {
                return ;
            }
            UIViewController *topmostVC = [self topViewController];
            if (topmostVC ) {
                //表示雇佣订单
                DemandHallDetailViewController *detail = [[UIStoryboard storyboardWithName:@"DemandHall" bundle:nil]instantiateViewControllerWithIdentifier:@"DemandHallDetailViewController"];
                DemandModel *model = [DemandModel new];
                if ([userInfo[@"extras"][@"type"] integerValue] == 1) {
                    detail.type = 1;
                }
                else if ([userInfo[@"extras"][@"type"] integerValue] == 2) {
                    detail.type = 0 ;
                }
                model.demand_id = userInfo[@"extras"][@"demand_id"];
                detail.model = model;
                detail.title =@"需求详情";
                [topmostVC.navigationController pushViewController:detail animated:YES];
                return ;
            }
        }
    }
    if (userInfo[@"member_id"] && userInfo[@"demand_id"]) {
        {
            if ([userInfo[@"type"]integerValue] != 1
                && [userInfo[@"type"]integerValue] != 2) {
                return ;
            }
            UIViewController *topmostVC = [self topViewController];
            if (topmostVC ) {
                 DemandHallDetailViewController *detail = [[UIStoryboard storyboardWithName:@"DemandHall" bundle:nil]instantiateViewControllerWithIdentifier:@"DemandHallDetailViewController"];
                if ([userInfo[@"type"] integerValue] == 1) {
                    detail.type = 1; //雇佣订单
                }
                else if ([userInfo[@"type"] integerValue] == 2) {
                    detail.type = 0 ; //一般订单
                }
                DemandModel *model = [DemandModel new];
                model.demand_id = userInfo[@"demand_id"];
                detail.model = model;
                detail.title = @"需求详情";
                [topmostVC.navigationController pushViewController:detail animated:YES];
                return ;
            }
        }
    }
}

- (void)hiddenTop:(UIView *)label {
    
    if (label) {
        if ([label isKindOfClass:[UIButton class]]) {
            [label.superview removeFromSuperview];
        } else {
            [label removeFromSuperview];
            label = nil;
        }
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
          objc_setAssociatedObject(self, "userInfo", userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSLog(@"iOS10 收到远程通知:=======》%@", [self logDic:userInfo]);
        [self jumpPage];
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

#pragma mark - 广告
-(void)advertisePage{
    YMAdvertisePageViewController *vc = [[YMAdvertisePageViewController alloc]init];
    vc.delegate =self;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

-(void)advertisePageController:(YMAdvertisePageViewController *)advertisePageController{
    [self setWindow];
}

-(void)advertisePageController:(YMAdvertisePageViewController *)advertisePageController  requrtUrl:(NSString *)reqrutUrl inputadvertising:(BOOL)inputadvertising{
    
    if (inputadvertising) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"inputadvertisingClick"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [[NSUserDefaults standardUserDefaults]setObject:reqrutUrl forKey:@"webUrl"];
        [self setWindow];
    }
}

-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController IKnow:(BOOL)IKnow{
    [self setWindow];
}

-(void)GuidePageController:(YMGuidePageViewController *)GuidePageController inputPerson:(BOOL)inputPerson{
    [self setWindow];
}

-(void)longinSuccess{
    [self setWindow];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
