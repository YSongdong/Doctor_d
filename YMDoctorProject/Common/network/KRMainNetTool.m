//
//  KRMainNetTool.m
//  Dntrench
//
//  Created by kupurui on 16/10/19.
//  Copyright © 2016年 CoderDX. All rights reserved.
//

#import "KRMainNetTool.h"
#import "AFNetworking.h"
//#import "MBProgressHUD+KR.h"
#import "MBProgressHUD.h"

#define baseURL @"这里写基础的url"

@implementation KRMainNetTool
singleton_implementation(KRMainNetTool)
//不需要上传文件的接口方法
- (void)sendRequstWith:(NSString *)url params:(NSDictionary *)dic withModel:(Class)model complateHandle:(void (^)(id showdata, NSString *error))complet {
    [self sendRequstWith:url params:dic withModel:model waitView:nil complateHandle:complet];
    
}
//上传文件的接口方法
- (void)upLoadData:(NSString *)url params:(NSDictionary *)param andData:(NSArray *)array complateHandle:(void (^)(id, NSString *))complet {
    [self upLoadData:url params:param andData:array waitView:nil complateHandle:complet];
}
//需要显示加载动画的接口方法 不上传文件
- (void)sendRequstWith:(NSString *)url params:(NSDictionary *)dic withModel:(Class)model waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet {
    //拼接网络请求url
   // NSString *path = [NSString stringWithFormat:@"%@%@",baseURL,url];
    //定义需要加载动画的HUD
    __block MBProgressHUD *HUD;
    if (waitView != nil) {
        //如果view不为空就添加到view上
        dispatch_async(dispatch_get_main_queue(), ^{
             HUD = [MBProgressHUD showHUDAddedTo:waitView animated:YES];
             HUD.bezelView.color =[UIColor colorWithWhite:0 alpha:0.7];
             HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
        });
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  //  manager.responseSerializer = [AFHTTPResponseSerializer serializer] ;
    //开始网络请求
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject---------%@",responseObject);
        
        //请求成功，隐藏HUD并销毁
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [HUD hide:YES];
        });

        //判断返回的状态，200即为服务器查询成功，500服务器查询失败
        NSString *num = responseObject[@"status"];
        
        if ([num integerValue] == 200) {
            
            if (model == nil) {
                
                if (responseObject[@"show_data"]) {
                    
                    complet(responseObject[@"show_data"],nil);
                    
                } else {
                    
                    complet(responseObject[@"message"],nil);
                }
            } else {
                
                complet([self getModelArrayWith:responseObject[@"show_data"] andModel:model],nil);
            }
        } else {
            
            complet(nil,responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        //网络请求失败，隐藏HUD，服务器响应失败。网络问题 或者服务器崩溃
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [HUD hide:YES];
        });
        complet(nil,@"网络错误");
    }];
}

//需要显示加载动画的接口方法 上传文件
- (void)upLoadData:(NSString *)url params:(NSDictionary *)param andData:(NSArray *)array waitView:(UIView *)waitView complateHandle:(void(^)(id showdata,NSString *error))complet {
    //拼接网络请求url
  //  NSString *path = [NSString stringWithFormat:@"%@%@",baseURL,url];
    //定义需要加载动画的HUD
    __block MBProgressHUD *HUD;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (waitView != nil) {
            //如果view不为空就添加到view上
            HUD = [MBProgressHUD showHUDAddedTo:waitView animated:YES];
            HUD.bezelView.color =[UIColor colorWithWhite:0 alpha:0.7];
            HUD.contentColor = [UIColor colorWithWhite:1 alpha:1];
        }
    });
    //开始上传数据并网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //通过遍历传过来的上传数据的数组，把每一个数据拼接到formData对象上
        for (NSDictionary *dic in array) {
            
            //NSString *str = [NSString stringWithFormat:@"picture%ld.png",[array indexOfObject:data]];
           
            [formData appendPartWithFileData:dic[@"data"] name:dic[@"name"] fileName:@"image.jpg" mimeType:@"image/jpeg"];//
        }
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"responseObject---------------%@",responseObject);
        
        //请求成功，隐藏HUD并销毁
        [HUD hide:YES];
        NSNumber *num = responseObject[@"status"];
        //判断返回的状态，200即为服务器查询成功，500服务器查询失败
        if ([num longLongValue] == 200) {
            complet(@"修改成功",nil);
            
        } else {
            
            complet(nil,responseObject[@"message"]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        
        //网络请求失败，隐藏HUD，服务器响应失败。网络问题 或者服务器崩溃
        [HUD hideAnimated:YES];
        complet(nil,@"网络错误");
    }];
}
//把模型数据传入返回模型数据的数组
- (NSArray *)getModelArrayWith:(NSArray *)array
                      andModel:(Class)modelClass {
    NSMutableArray *mut = [NSMutableArray array];
    //遍历模型数据 用KVC给创建每个模型类的对象并赋值过后放进数组
    for (NSDictionary *dic in array) {
        id model = [modelClass new];
        [model setValuesForKeysWithDictionary:dic];
        [mut addObject:model];
    }
    return [mut copy];
}











@end
