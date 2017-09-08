///Users/kupurui/Desktop/DoctorProject/YMDoctorProject/YMDoctorProject/Common/UIView
//  TakingAlertView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/23.
//  Copyright © 2017年 mac. All rights reserved.
//



typedef enum : NSUInteger {
    singleType,
    multiplyType,
    
} ChoiceType;
#import <UIKit/UIKit.h>

@protocol TakingAlertViewDelegate <NSObject>


- (void)didClickSureBtn:(id)value andType:(ChoiceType)type;

@end

@interface TakingAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)NSArray *labelContents ; ;
@property (nonatomic,assign)ChoiceType type ;
@property (nonatomic,weak)id <TakingAlertViewDelegate>delegate ;

+ (TakingAlertView *)takingViewWithXIBWithtitles:(NSArray *)titles ;
- (void)viewShow ;
- (void)hiddenView ;

@end
