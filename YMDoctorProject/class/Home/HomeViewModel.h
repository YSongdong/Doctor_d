//
//  HomeViewModel.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^RequestDataSuccess)(id value);

typedef void(^RequestDataFailure)(NSString *error);
@interface HomeViewModel : NSObject

@property (nonatomic,strong)NSArray *dataList ;

@property (nonatomic,strong)NSArray *pics ;


- (void)requestHomePageDataWithView:(UIView *)view
                          andParams:(id )params ;

- (void)getHeadImage ;

- (void)requestOrderWithParmas:(id)params
                       andView:(UIView *)view
                andReturnBlock:(void(^)(id status))statusBlock ;
@end
