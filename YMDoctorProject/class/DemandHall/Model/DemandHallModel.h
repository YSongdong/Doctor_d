//
//  DemandHallModel.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//
#import <Foundation/Foundation.h>


@protocol DemandHallModelDelegate <NSObject>

- (void)getDataFailureWithReason:(nonnull NSString *)reason ;

- (void)requestDataSucess:(NSString *) success;

@end
@interface DemandHallModel : NSObject

@property (nonatomic,assign,nonnull)id params ;

@property (nonnull,nonatomic,strong)NSArray *demandLists;
@property (nonnull,nonatomic,strong)NSArray *departmentDic ;
@property (nonnull,nonatomic,strong)NSArray *forumDataList ;//医生

@property (nonatomic,strong,nonnull)NSArray *areas ;

@property (nonatomic,weak)id <DemandHallModelDelegate>delegate ;

@property (nonnull,strong)id model;


@property (nonnull,strong)NSArray *data;
- (void)requetNetworkDataWithView:(UIView *)view ;

- (NSArray *)getsearchChoice ;
- (NSArray *)getsearchChoice2 ;

- (void)requestArea ;

//demand hall detail 
- (void)getDemandHallDetailWithView:(nonnull UIView *)view andModel:(nonnull id )model ;


- (void)submitTenderWithParams:(id)params view:(UIView *)view;


@end
