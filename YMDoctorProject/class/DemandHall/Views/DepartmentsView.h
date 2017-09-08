//
//  DepartmentsView.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^returnValueBlock)(id dic,NSString *dataListID);
@interface DepartmentsView : UIView
@property (nonatomic,assign)CGFloat start_y ;
@property (nonatomic,assign)CGFloat viewOffsetX ;
@property (nonatomic,copy)returnValueBlock block ;


+ (DepartmentsView *)DepartmentsViewWithDic:(NSArray *)dataList ;

- (void)showOnSuperView:(UIView *)view subViewStartY:(CGFloat)y ;

@end
