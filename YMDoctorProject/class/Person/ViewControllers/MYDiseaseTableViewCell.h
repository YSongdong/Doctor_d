//
//  MYDiseaseTableViewCell.h
//  YMDoctorProject
//
//  Created by 黄军 on 2017/6/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MYDiseaseModel.h"

@class MYDiseaseTableViewCell;
@protocol MYDiseaseTableViewCellDelegate <NSObject>

-(void)diseaseCell:(MYDiseaseTableViewCell *)diseaseCell diseaseDic:(NSDictionary *)dic;

@end

@interface MYDiseaseTableViewCell : UITableViewCell

@property(nonatomic,strong)NSArray *diseaseArry;

@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,weak)id<MYDiseaseTableViewCellDelegate> delegate;

+(CGFloat)diseaseTableViewHeight:(NSArray *)diseaseArr dic:(NSDictionary *)dic;

@end
