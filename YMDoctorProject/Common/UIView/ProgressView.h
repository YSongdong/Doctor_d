//
//  ProgressView.h
//  YMDoctorProject
//
//  Created by kupurui on 2017/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property (nonatomic,assign)NSInteger progress ;
@property (nonatomic,assign)NSInteger account ;

@property (nonatomic,assign)CGFloat lineHeight ;

@property (nonatomic,strong)UIColor *backColor;

@property (nonatomic,strong)UIColor *roundViewColor ;
@property (nonatomic,assign)CGFloat viewWidth ;

- (void)addViews  ;

- (void)setText ;
@end
