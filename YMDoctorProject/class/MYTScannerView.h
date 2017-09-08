//
//  MYTScannerView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/5/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTScannerView : UIView

@property (weak, nonatomic) IBOutlet UIView *saveScannerView;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

+(instancetype)initWithXib;
-(void)show;
-(void)miss;


@end
