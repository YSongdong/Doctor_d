//
//  NSObject+UserInfo.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>



extern NSString *notExitStoreIDNotification ;

extern NSString *notExitMemberIDNotification ;


@interface NSObject (UserInfo)
- (void)setStore_id:(NSNumber *)store_id ;

- (NSString *)getStore_id ;

- (void)setUserPhone:(NSString *)phone ;

- (NSString *)getUserPhone ;


- (void)setMember_id:(NSString *)member_id;
- (NSString *)getMember_id ;


- (void)setDoctor_member_id:(NSString *)doctor_member_id;
- (NSString *)getDoctor_member_id;


- (void)setAvatar:(NSString *)avatar ;
- (NSString *)getAvatar ;

- (void)setAlert:(NSString *)alert ;

- (NSString *)getAlert ;

- (void)setPayPass:(BOOL)payPass ;

- (BOOL)getPayPass;

- (NSString *)getUserNickName  ;
- (void)setUserNickName:(NSString *)userName ;

- (void)removeUserInfo ;

- (NSString *)getUserName ;

- (void)setUserName:(NSString *)userName;
- (void)removeUserName ;
- (void)removeStore_id ;

- (void)setVibrates:(NSString *)vibrates ;
- (NSString *)getVibrates;

+(NSString *)getMember_id;
@end
