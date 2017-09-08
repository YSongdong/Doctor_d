//
//  TakeDrugFootView.h
//  YMDoctorProject
//
//  Created by dong on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TakeDrugFootViewDelegate <NSObject>

-(void)selectdAddTakeDrugBtn;

@end


@interface TakeDrugFootView : UIView

@property(nonatomic,weak) id<TakeDrugFootViewDelegate>delegate;


@end
