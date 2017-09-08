//
//  YMCaseTopView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CaseTreatmentNumber,
    CaseCaseNumber,
    CaseHonorNumber,
    CaseServerNumber,
} CaseNumber;

@class YMCaseTopView;

@protocol YMCaseTopViewDelegate <NSObject>

-(void)CaseTopView:(YMCaseTopView *)CaseTopView CaseNumber:(CaseNumber)CaseNumber;

@end

@interface YMCaseTopView : UIView

@property(nonatomic,weak)id<YMCaseTopViewDelegate> delegate;

-(void)selectCaseNumber:(CaseNumber)CaseNumber;

@end
