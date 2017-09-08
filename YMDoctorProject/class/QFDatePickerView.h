//
//  QFDatePickerView.h
//  dateDemo
//
//  Created by 情风 on 2017/1/12.
//  Copyright © 2017年 情风. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QFDatePickerView;

@protocol QFDatePickerViewDelegate <NSObject>

-(void)datePickerView:(QFDatePickerView *)datePickerView disMiss:(BOOL)dismiss;

-(void)datePickerView:(QFDatePickerView *)datePickerView selectStr:(NSString *)yearAndMonth;

@end

@interface QFDatePickerView : UIView

@property(nonatomic,weak)id<QFDatePickerViewDelegate> delegage;

- (instancetype)initDatePacker;

- (void)show:(UIView *)view;
- (void)dismiss;
@end
