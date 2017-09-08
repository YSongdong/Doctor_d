//
//  Person.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/2/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic,strong,nonnull)NSString  *member_id ;
@property (nonatomic,strong,nonnull)NSString  *member_truename ;
@property (nonatomic,strong,nonnull)NSString  *member_address ;
@property (nonatomic,strong,nonnull)NSString  *member_avatar ;
@property (nonatomic,strong,nonnull)NSString  *member_bm ;
@property (nonatomic,strong,nonnull)NSString  *member_ks ;
@property (nonatomic,strong,nonnull)NSString  *member_aptitude ;//医生资质
@property (nonatomic,strong,nonnull)NSString  *member_exppoints ;
@property (nonatomic,strong,nonnull)NSString  *goodsP ; //haopinglu
@property (nonatomic,strong,nonnull)NSString  *zfz ; // 评论人数
@property (nonatomic,strong,nonnull)NSString  *cjl ; // 成交量
@property (nonatomic,strong,nonnull)NSString  *authentication_name ; ////认证名字

@property (nonatomic,strong,nonnull)NSString  *authentication_sex ; ///性别

@property (nonatomic,strong,nonnull)NSString  *authentication_age ; // 出生年月
@property (nonatomic,strong,nonnull)NSString  *authentication_sid ; //身份证号码
@property (nonatomic,strong,nonnull)NSString  *effective ; // 身份证有效期
@property (nonatomic,strong,nonnull)NSString  *picture1 ; // 身份证正面
@property (nonatomic,strong,nonnull)NSString  *picture2 ; // 身份证背面

@property (nonatomic,strong,nonnull)NSString  *accession ; // 就职医院
@property (nonatomic,strong,nonnull)NSString  *authentication_education ; // 学历
@property (nonatomic,strong,nonnull)NSString  *authentication_bm ; // 部门
@property (nonatomic,strong,nonnull)NSString  *authentication_ks ; //科室
@property (nonatomic,strong,nonnull)NSString  *certificate_zy ; // 执业证书编号
@property (nonatomic,strong,nonnull)NSString  *certificate_zg ; // 资格证书编号

//+ (Person *)sharedPerosn;
@end
