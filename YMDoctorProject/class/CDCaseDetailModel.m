//
//  CDCaseDetailModel.m
//  YMDoctorProject
//
//  Created by dong on 2017/7/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CDCaseDetailModel.h"

@implementation CDCaseDetailModel
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{@"case_detail":[Case_detailModel class],@"doctor_info":[Case_doctorModel class]};

}
@end
@implementation Case_detailModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{

    return @{@"detail":[Case_detail_Model class]};
}

@end
@implementation Case_detail_Model

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    
    return @{@"d_imgs":[d_imgsModel class]};
}

@end
@implementation Case_doctorModel



@end
@implementation d_imgsModel



@end
