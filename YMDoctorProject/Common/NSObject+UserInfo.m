//
//  NSObject+UserInfo.m
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NSObject+UserInfo.h"


NSString *notExitStoreIDNotification = @"notExitStoreIDNotification";

NSString *notExitMemberIDNotification = @"notExitMemberIDNotification";

@implementation NSObject (UserInfo)

- (NSString *)getUserName {
    return  [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
}

- (void)setUserName:(NSString *)userName {
    [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"user"];
}

- (void)removeUserName {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"user"];
}


- (NSString *)getUserNickName {
    return  [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
    
}
- (void)setUserNickName:(NSString *)userName {
    
    [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"userName"];
}


- (void)setAvatar:(NSString *)avatar {
    [[NSUserDefaults standardUserDefaults]setObject:avatar forKey:@"avatar"];
    
}

- (NSString *)getAvatar {
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"avatar"];
}

- (void)removeAvatar {
    
    if ([self getAvatar]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"avatar"];
    }
}

- (void)setStore_id:(NSNumber *)store_id {
    
    [[NSUserDefaults standardUserDefaults]setObject:store_id forKey:@"storeID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSNumber *)getStore_id {
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"storeID"];
}

- (void)removeStore_id {
    
    if ([self getStore_id]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"storeID"];
    }
}

- (NSString *)getUserPhone {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
}

- (void)setUserPhone:(NSString *)phone {
    
     [[NSUserDefaults standardUserDefaults]setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeUserPhone{
    
    if ([self getUserPhone]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"phone"];
    }
}
+(NSString *)getMember_id {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"memberID"];
}
- (NSString *)getMember_id {
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"memberID"];
}

- (void)setMember_id:(NSString *)member_id {
    [[NSUserDefaults standardUserDefaults]setObject:member_id forKey:@"memberID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeMember_id{
    if ([self getMember_id]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"memberID"];
    }
}



- (NSString *)getDoctor_member_id{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"doctorMemberID"];
}

- (void)setDoctor_member_id:(NSString *)doctor_member_id {
    [[NSUserDefaults standardUserDefaults]setObject:doctor_member_id forKey:@"doctorMemberID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeDoctor_member_id{
    if ([self getDoctor_member_id]) {
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"doctorMemberID"];
    }
}






- (void)setAlert:(NSString *)alert {

    [[NSUserDefaults standardUserDefaults]setObject:alert forKey:@"alert"];
}

- (NSString *)getAlert {
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"alert"];
}
- (void)removeAlert{
    if ([self getAlert]) {
        [[NSUserDefaults standardUserDefaults]objectForKey:@"alert"];
    }
}




- (void)setPayPass:(BOOL)payPass {
    [[NSUserDefaults standardUserDefaults]setBool:payPass forKey:@"payPass"];
}

- (BOOL)getPayPass{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"payPass"];
}

- (void)removePayPass{
    if ([self getPayPass]) {
        [[NSUserDefaults standardUserDefaults]setBool:0 forKey:@"payPass"];
    }
}

- (void)setVibrates:(NSString *)vibrates {
    
    [[NSUserDefaults standardUserDefaults]setObject:vibrates forKey:@"vibrates"];
}
- (NSString *)getVibrates {
    
  return    [[NSUserDefaults standardUserDefaults]objectForKey:@"vibrates"];
}

- (void)removeVibrates {
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"vibrates"];
}

- (void)removeUserInfo {

    [self removeMember_id];
    [self removeAlert];
    [self removePayPass];
    [self removeUserPhone];
    [self removeStore_id];
    [self removeAvatar];
    [self removeUserName];
    [self removeVibrates];
}

@end
