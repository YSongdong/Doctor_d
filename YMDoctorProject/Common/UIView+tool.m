//
//  UIView+tool.m
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import "UIColor+tool.h"
#import "UIView+tool.h"

@implementation UIView (tool)

/**
 设置圆角 和 圆周线条 颜色
 
 @param cornerRadius 角度
 @param hexColor 16进制颜色
 @param borderWidth 线条宽度
 */
-(void)setCornerRadius:(CGFloat)cornerRadius hexColor:(NSString *)hexColor borderWidth:(CGFloat)borderWidth{
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderColor = [UIColor colorWithHexString:hexColor].CGColor;
    self.layer.borderWidth = borderWidth;
}

+(instancetype)initWithNib{
    
    UIView *demo1 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    
    return  demo1;
}

-(void)setBackGroundColorWithHexColor:(NSString *)hexClor{
    self.backgroundColor = [UIColor colorWithHexString:hexClor];
}



@end
