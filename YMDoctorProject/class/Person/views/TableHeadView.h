//
//  TableHeadView.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^AvatarUploadBlock)(UIImageView *sender) ;

typedef void(^MessageBtnClickBlock)(id value);

@interface TableHeadView : UIView

@property (nonatomic,copy)AvatarUploadBlock block ;
@property (nonatomic,copy)MessageBtnClickBlock messageBlock ;

@property (weak, nonatomic) IBOutlet UIButton *improveBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;

@property (weak, nonatomic) IBOutlet UIImageView *img_1;
@property (weak, nonatomic) IBOutlet UILabel *label_1;
@property (weak, nonatomic) IBOutlet UIView *line_1;

@property (weak, nonatomic) IBOutlet UIImageView *img_2;
@property (weak, nonatomic) IBOutlet UILabel *label_2;
@property (weak, nonatomic) IBOutlet UIView *line_2;

@property (weak, nonatomic) IBOutlet UIImageView *img_3;
@property (weak, nonatomic) IBOutlet UILabel *label_3;
@property (weak, nonatomic) IBOutlet UIView *line_3;

@property (weak, nonatomic) IBOutlet UIImageView *img_4;
@property (weak, nonatomic) IBOutlet UILabel *label_4;


- (void)setPersonValue:(id)person ;

+(instancetype) tableHeadView ;

-(void)setStyleByIndex:(NSInteger )index;

@property (nonatomic,assign,readonly) NSInteger currentIndex;
@end
