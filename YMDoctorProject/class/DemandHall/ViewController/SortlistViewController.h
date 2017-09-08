//
//  SortlistViewController.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^selectedTitleBlock)(NSString *title,NSNumber * selectedIndex,NSInteger type);


@interface SortlistViewController : UIViewController

@property (nonatomic,strong)NSArray *datList ;

@property (nonatomic,assign)NSInteger selectedIndex ;

@property (nonatomic,copy)selectedTitleBlock block ;


+ (CGFloat)getContentHeightWithDataList:(NSArray *)dataList ;
@end
