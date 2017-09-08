//
//  NetWorkTool.h
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkTool : NSObject

//获取个人中心的所有数据
+(void)GetPersonDataWithView:(UIView *)view complateHandle:(void(^)(id showdata,NSString *error))complet;
///获取状态Complete_status

/**
 获取状态Complete_status

 @param view <#view description#>
 @param complet <#complet description#>
 */
+(void)GetComplete_statusFromPersonDataWithView:(UIView*)view
                                 complateHandle:(void(^)(NSString * complete_status,NSString *error))complet;
///获取资料完善状态
+(void)GetPerson_complateStatusWithView:(UIView *)view complateHandle:(void(^)(id showdata,NSString *error))complet;


@end
