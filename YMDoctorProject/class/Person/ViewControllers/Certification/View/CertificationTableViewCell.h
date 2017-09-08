//
//  CertificationTableViewCell.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    cellTypeGender, //性别
    cellTypeBirthDay, //出身日期
    cellTypeIdCardValidData,//证件有效期
    cellTypeDepartMent,//科室
    cellTypeHightestEducational, //最高学历
    cellTypeQualification ,//医师资质
    cellTypeHospital,
    cellTypePicture ,
    cellTypeIDCard 
    
} Celltype;

@class CertificationTableViewCell ;


@protocol CertificationTableViewCellDelegate <NSObject>

- (void)didClickWithPoint:(CGPoint)point andView:(CertificationTableViewCell *)view ;

- (void)didClickChoiceTimeView:(CertificationTableViewCell *)view andType:(Celltype)type ;

- (void)didClickChoiceValidateTimeView:(CertificationTableViewCell *)view ;

- (void)didClickChoicePicture:(UIButton *)sender ;

- (void)didClickChoiceDepartmentWithView:(CertificationTableViewCell *)view;

@end

@interface CertificationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *validStartTime;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;

@property (weak, nonatomic) IBOutlet UILabel *writeTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *writeTextField;
@property (weak, nonatomic) IBOutlet UIButton *positivePhoto;
@property (weak, nonatomic) IBOutlet UIButton *oppositePhoto;

@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;
@property (weak, nonatomic) IBOutlet UILabel *photoAlertLabel;

@property (weak,nonatomic)id <CertificationTableViewCellDelegate>delegate ;


@property (nonatomic,assign)Celltype type ;




@end
