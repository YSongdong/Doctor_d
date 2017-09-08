//
//  refuseOrderView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/6/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefuseOrderView : UIView


@property (weak, nonatomic) IBOutlet UITextView *refuseReasonTextView;
@property (weak, nonatomic) IBOutlet UILabel *reasonPlaceHolderLab;


@property (weak, nonatomic) IBOutlet UIButton *sureBtn;


+(instancetype)initWithXib;
-(void)show;
-(void)miss;


@end
