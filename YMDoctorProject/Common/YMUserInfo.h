//
//  YMUserInfo.h
//  doctor_user
//
//  Created by kupurui on 17/2/8.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMUserInfo : NSObject
singleton_interface(YMUserInfo)
@property (nonatomic, strong) NSString *member_id;
@property (nonatomic, strong) NSString *member_name;
@property (nonatomic, strong) NSString *member_email;
@property (nonatomic, strong) NSString *is_buy;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *ref_url;
@property (nonatomic, strong) NSString *isShow;
@property (nonatomic,strong)NSString *store_id ;

@end
