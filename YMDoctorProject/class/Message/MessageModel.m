//
//  MessageModel.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

//系统消息
- (void)requestMessageWithParams:(id)params
                andCommpletBlock:(void(^)(id data))commplete {

    [self requestDataWithUrl:System_message_url
                   andParams:params
                     andView:nil
           andCommpleteBlock:^(id showData, NSString *error) {
               commplete(showData);
            
    }];
    
    
}



- (void)requestDataWithUrl:(NSString *)url andParams:(id)params andView:(UIView *)view andCommpleteBlock:(void(^)(id showData,NSString *error))commpleteBlock{
    
    
    KRMainNetTool *tool = [KRMainNetTool new];
    [tool sendRequstWith:url
                  params:params
               withModel:nil
                waitView:view complateHandle:^(id showdata, NSString *error) {
                    commpleteBlock(showdata,error);
    }];
}

@end
