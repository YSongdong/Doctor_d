//
//  YMDoctorHomePageHeaderView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YMDoctorDetailsModel.h"

@class YMDoctorHomePageHeaderTableViewCell;

@protocol YMDoctorHomePageHeaderTableViewCellDelegate <NSObject>

-(void)HeaderTableViewCell:(YMDoctorHomePageHeaderTableViewCell *)headerTableViewCell sender:(UIButton *)sender;

//关注医生
-(void)selectdFollowDoctorBtnClick;


@end

@interface YMDoctorHomePageHeaderTableViewCell : UITableViewCell

@property(nonatomic,weak)id<YMDoctorHomePageHeaderTableViewCellDelegate> delegate;

@property(nonatomic,assign)BOOL clcickEvent;

//@property(nonatomic,copy)NSString *infor;

@property (nonatomic,assign) BOOL isFollowDoctor; //是否关注医生

@property(nonatomic,strong)YMDoctorDetailsModel *model;

+(CGFloat)DetailsViewHeight:(NSString *)text detailsClick:(BOOL)detailsClick;

+(CGFloat)goodAtHeight:(NSString *)specialty_tags;

+(CGFloat)memberPersonalInfoHeight:(NSString *)memberPersonalInfo;
@end
