//
//  Health_historyModel.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Health_historyModel : NSObject

@property(nonatomic,copy) NSString *history_id;
@property(nonatomic,copy) NSString *title;   //就诊历史标题
@property(nonatomic,copy) NSString *history_image;
@property(nonatomic,copy) NSString *history_time;   //就诊历史时间

-(NSString *)year;
-(NSString *)month;
-(NSString *)day;


@end
