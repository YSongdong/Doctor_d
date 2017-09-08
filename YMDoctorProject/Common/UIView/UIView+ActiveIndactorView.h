//
//  UIView+ActiveIndactorView.h
//  FenYouShopping
//
//  Created by fenyounet on 16/7/31.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ActiveIndactorView)
- (UIActivityIndicatorView *)add_Indactor ;

- (void)stopIndactor ;
- (void)setIndicatorStyle:(UIActivityIndicatorViewStyle)style ;
- (void)setCenter_Y:(CGFloat)center_Y;

- (UIImageView *)addImageView ;

- (void)setImageViewCenter_Y:(CGFloat)centerY ;


- (void)hiddenImageView ;

- (void)setAlertViewWithTitle:(NSString *)title withCount:(NSInteger )rowCount ;


@end
