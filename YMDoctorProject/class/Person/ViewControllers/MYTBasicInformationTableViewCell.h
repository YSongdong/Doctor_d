//
//  MYTBasicInformationTableViewCell.h
//  YMDoctorProject
//
//  Created by 王梅 on 2017/5/30.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ClickHospitalType,
    ClickDiseaseType,
} ClickType;


@interface MYTBasicInformationTableViewCell : UITableViewCell

//@property (weak, nonatomic) IBOutlet UIButton *hospitalBtn;
//@property (weak, nonatomic) IBOutlet UIButton *diseaseBtn;

@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *diseaseTagesLabel;



@property (weak, nonatomic) IBOutlet UITextView *detailsTextView;
@property (weak, nonatomic) IBOutlet UILabel *detailsPlaceHolder;

@property (weak, nonatomic) IBOutlet UITextView *personTextView;
@property (weak, nonatomic) IBOutlet UILabel *personPlaceHolder;




@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;

@property (weak, nonatomic) IBOutlet UIButton *jiahaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *jianhaoBtn;

@property (weak, nonatomic) IBOutlet UITextField *contentTF;


@end

