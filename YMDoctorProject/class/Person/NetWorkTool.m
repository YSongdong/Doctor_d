
//
//  NetWorkTool.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//


#import "NetWorkTool.h"

@implementation NetWorkTool

+(void)netWorkGetDataWithView:(UIView *)view
                         path:(NSString *)path
                       params:(id) params
               complateHandle:(void(^)(id showdata,NSString *error))complet{
    [[KRMainNetTool sharedKRMainNetTool]sendRequstWith:path
    params:params withModel:nil waitView:view complateHandle:^(id showdata, NSString *error) {
                                                    
                                                    complet(showdata,error);
                                                }];
}
///获取个人中心数据
+(void)GetPersonDataWithView:(UIView *)view complateHandle:(void(^)(id showdata,NSString *error))complet{
    
    [self netWorkGetDataWithView:view path:Person_Info_Url params:@{@"member_id":@([[self getMember_id] integerValue])} complateHandle:^(id showdata, NSString *error) {
        complet(showdata,error);
    }];
    
    
}
///获取资料完善状态
+(void)GetPerson_complateStatusWithView:(UIView *)view complateHandle:(void(^)(id showdata,NSString *error))complet{
    
    [self netWorkGetDataWithView:view path:Person_complateStatus params:@{@"member_id":@([[self getMember_id] integerValue])} complateHandle:^(id showdata, NSString *error) {
        complet(showdata,error);
    }];
}



//获取个人中心的完成状态
+(void)GetComplete_statusFromPersonDataWithView:(UIView*)view
                                 complateHandle:(void(^)(NSString * complete_status,NSString *error))complet{
    [self GetPersonDataWithView:view complateHandle:^(id showdata, NSString *error) {
      NSString * complete_status =   showdata[@"complete_status"];
        complete_status = complete_status==nil ? @"":complete_status;
        
            complet(complete_status,error);
        
        
    }];
}


@end
