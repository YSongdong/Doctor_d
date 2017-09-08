//
//  YMDoctorCaseTableViewCell.h
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCaseTopView.h"
#import "YMDoctorDetailsCaseModel.h"
#import "YMDoctorDetailsHonorModel.h"
#import "YMDoctorDetailsEvaluationModel.h"

@class YMDoctorCaseTableViewCell;
@protocol YMDoctorCaseTableViewCellDelegate <NSObject>

-(void)DoctorCaseViewCell:(YMDoctorCaseTableViewCell *)DoctorCaseViewCell clickTopNumber:(CaseNumber )caseNumber;

-(void)DoctorCaseViewCell:(YMDoctorCaseTableViewCell *)doctorCaseViewCell caseModel:(YMDoctorDetailsCaseModel *)caseModel;

@end

@interface YMDoctorCaseTableViewCell : UITableViewCell
@property(nonatomic,weak)id<YMDoctorCaseTableViewCellDelegate> delegate;

@property(nonatomic,assign)CaseNumber selectCaseNumber;


@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsCaseModel *> *doctorCaseArry;
@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsHonorModel *> *doctorHonorArry;
@property(nonatomic,strong)NSMutableArray<YMDoctorDetailsEvaluationModel *> *doctorEvaluationArry;


+(CGFloat)cellCaseHeight:(NSMutableArray<YMDoctorDetailsCaseModel *> *) doctorCaseArry;

+(CGFloat)cellHonorHeight:(NSMutableArray<YMDoctorDetailsHonorModel *> *) doctorHonorArry;

+(CGFloat)cellEvaluationHeight:(NSMutableArray<YMDoctorDetailsEvaluationModel *> *) doctorEvaluationArry;

@end
