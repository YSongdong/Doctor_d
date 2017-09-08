//
//  MYTDiseaseViewController.h
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYTDiseaseViewController;

@protocol MYTDiseaseViewControllerDelegate <NSObject>

-(void)diseaseViewController:(MYTDiseaseViewController *)diseaseView selectDiseaseArry:(NSArray *)selectDiseaseArry;

@end

@interface MYTDiseaseViewController : UIViewController

@property(nonatomic,weak)id<MYTDiseaseViewControllerDelegate> delegate;

@end
