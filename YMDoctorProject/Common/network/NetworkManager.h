//
//  NetworkManager.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

//get
+ (void)GetRequestDataWithParams:(id)params
                          andUrl:(NSString *)url
                 andSuccessBlock:(void(^)(id response))reponseBlock
                 andFailureBlock:(void(^)(NSError * error))failure;

//post
+ (void)PostRequestWithParams:(id)parmas
                       andUrl:(NSString *)url
              andSuccessBlock:(void(^)(id reponse))responseBlock
              andFailureBlock:(void(^)(NSError *error))errorBlock;

@end
