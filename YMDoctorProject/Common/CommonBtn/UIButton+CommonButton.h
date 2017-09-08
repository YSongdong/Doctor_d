//
//  UIButton+CommonButton.h
//  YMDoctorProject
//
//  Created by Ray on 2017/1/4.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ buttonUnEnableBlock)();

@interface UIButton (CommonButton)

- (void)selected:(BOOL)selected
andBackgroundColor:(UIColor *)color;
- (void)setTitle:(CGFloat )fontSize ;



- (void)vertificationButtonClickedAnimationWithTimeStart:(NSInteger )startTime beginString:(NSString *)title block:(buttonUnEnableBlock)unableBlock ;


@end
