//
//  Share.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface Share : NSObject

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType  ;

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType shareUrl:(NSString *)url shareConnet:(NSString *)connet;

@end
