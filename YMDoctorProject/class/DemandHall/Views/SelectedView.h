//
//  SelectedView.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickShowListViewBlock)(NSInteger index );

@interface SelectedView : UIView

@property (nonatomic,assign)NSInteger selectedIndex; 
@property (nonatomic,copy)clickShowListViewBlock block ;

@property (nonatomic,strong)NSString *title ;

- (void)setDefaultTitle ;

@end
