//
//  clinicRemindView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/6/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ClinicRemindViewDelegate <NSObject>

-(void) selectdCancelBtn;

-(void) selectdTextViewEdit;


@end



@interface ClinicRemindView : UIView


@property (weak, nonatomic) IBOutlet UIButton *timePickerBtn;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UILabel *placeHolderLab;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak,nonatomic) id <ClinicRemindViewDelegate> delegate;

+(instancetype)initWithXib;
-(void)show;
-(void)miss;

@end

