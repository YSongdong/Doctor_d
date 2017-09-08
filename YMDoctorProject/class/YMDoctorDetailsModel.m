//
//  YMDoctorDetailsModel.m
//  doctor_user
//
//  Created by 黄军 on 17/5/20.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import "YMDoctorDetailsModel.h"
//#import <NSObject+YYModel.h>



@implementation YMDoctorDetailsModel

-(NSString *)member_id{
    if ([NSString isEmpty:_member_id]) {
        return @"";
    }
    return _member_id;
}

-(NSString *)store_id{
    if ([NSString isEmpty:_store_id]) {
        return @"";
    }
    return _store_id;
}

-(NSString*)grade_id{
    if (_grade_id) {
        return _grade_id;
    }else{
        return @"1";
    }
}

-(NSString *)follow_num{
    if (_follow_num) {
        return _follow_num;
    }else{
        return @"0";
    }
}

-(NSString *)avg_score{
    if (_avg_score) {
        return _avg_score;
    }else{
        return @"0";
    }
}
-(NSString *)member_names{
    if (_member_names) {
        return _member_names;
    }else{
        return  @"";
    }
}

-(NSString *)member_aptitude{
    if (_member_aptitude) {
        return _member_aptitude;
    }else{
       return @"";
    }
}

-(NSString *)member_bm{
    if (_member_bm) {
        return _member_bm;
    }else{
        return @"";
    }
}
-(NSString *)member_occupation{
    if (_member_occupation) {
        return _member_occupation;
    }else{
        return @"";
    }
}

-(NSString *)member_service{
    if (_member_service) {
        return _member_service;
    }else{
        return @"";
    }
}

-(NSString *)store_sales{
    if (_store_sales) {
        return _store_sales;
    }else{
        return @"0";
    }
}

-(NSString *)stoer_browse{
    if (_stoer_browse) {
        return _stoer_browse;
    }else{
        return @"0";
    }
}

-(NSMutableArray<YMDoctorTimeModel *> *)doctorTimeArry{
    _doctorTimeArry = [NSMutableArray array];
    for (NSDictionary *dic in _doctor_time) {
        [_doctorTimeArry addObject:[YMDoctorTimeModel modelWithJSON:dic]];
    }
    return _doctorTimeArry;
}

@end
