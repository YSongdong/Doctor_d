//
//  LineView.m
//  FenYouShopping
//
//  Created by fenyounet on 16/5/31.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "LineView.h"

@interface LineView ()


@end

@implementation LineView


+(instancetype)LineViewWithPosition:(CGFloat)position_Y
                andWidth:(CGFloat)width
{
    LineView *view = [[LineView alloc]initWithPosition:position_Y
                                            andWidth:width];
    return view ;
}
-(instancetype)initWithPosition:(CGFloat)position_Y
                         andWidth:(CGFloat)width {
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, position_Y, width, 1);
self.backgroundColor = [UIColor colorWithRGBHex:0xe1e1e1];
        //_ratio = 0.5 ;
    }
    return self ;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
   // CGFloat center_Y = self.frame.origin.y +  1 / 2  ;
  //  CGFloat center_X = self.superview.width *_ratio;
   // self.center = CGPointMake(center_X, center_Y);
}


- (void)setRatio:(CGFloat)ratio {
    _ratio = ratio ;
    [self layoutSubviews];
}


- (void)setColor:(UIColor *)color {
    _color = color ;
    self.backgroundColor = color ;
}
@end
