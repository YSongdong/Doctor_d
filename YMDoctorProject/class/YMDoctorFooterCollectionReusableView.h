//
//  YMDoctorFooterCollectionReusableView.h
//  doctor_user
//
//  Created by 黄军 on 17/5/15.
//  Copyright © 2017年 CoderDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDoctorTimeModel.h"

@class YMDoctorFooterCollectionReusableView;

@protocol YMDoctorFooterCollectionReusableViewDelegate <NSObject>

-(void)FooterCollection:(YMDoctorFooterCollectionReusableView *)FooterCollection sender:(UIButton *)sender;

@end

@interface YMDoctorFooterCollectionReusableView : UICollectionReusableView

@property(nonatomic,weak)id<YMDoctorFooterCollectionReusableViewDelegate> delegate;

@property(nonatomic,strong)YMDoctorTimeModel *model;

@end
