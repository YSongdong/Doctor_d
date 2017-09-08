//
//  MessageModel.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

- (void)requestMessageWithParams:(id)params
                andCommpletBlock:(void(^)(id data))commplete ;

@end
