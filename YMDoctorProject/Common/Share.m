//
//  Share.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Share.h"

@implementation Share

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType shareUrl:(NSString *)url shareConnet:(NSString *)connet
{
    
    //创建分享消息对象
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.title = @"鸣医通分享";
    //创建图片内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"鸣医通分享" descr:connet thumImage:[UIImage imageNamed:@"icon.png"]];
    shareObject.webpageUrl = url ;
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

@end
