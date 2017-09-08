//
//  LineView.h
//  FenYouShopping
//
//  Created by fenyounet on 16/5/31.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView


+ (instancetype)LineViewWithPosition:(CGFloat)position_Y
                            andWidth:(CGFloat)width;


@property (nonatomic,assign)CGFloat ratio ;
@property (nonatomic,strong)UIColor *color;


- (void)setColor:(UIColor *)color ;



@end
