//
//  NetworkManager.m
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (void)GetRequestDataWithParams:(id)params
                          andUrl:(NSString *)url
              andSuccessBlock:(void(^)(id response))reponseBlock
             andFailureBlock:(void(^)(NSError * error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url
      parameters:params
        progress:^(NSProgress * _Nonnull downloadProgress){
    } success:^(NSURLSessionDataTask * _Nonnull task,
                id  _Nullable responseObject) {
        reponseBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (void)PostRequestWithParams:(id)parmas
                       andUrl:(NSString *)url
              andSuccessBlock:(void(^)(id reponse))responseBlock
              andFailureBlock:(void(^)(NSError *error))errorBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url
       parameters:parmas
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                responseBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task,
                NSError * _Nonnull error) {
        errorBlock(error);
        
    }];
    
}

@end
