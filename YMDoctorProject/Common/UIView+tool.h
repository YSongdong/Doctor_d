//
//  UIView+tool.h
//  MYTDoctor
//
//  Created by 王梅 on 2017/5/13.
//  Copyright © 2017年 kupurui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (tool)


/**
 设置圆角 和 圆周线条 颜色

 @param cornerRadius 角度
 @param hexColor 16进制颜色
 @param borderWidth 线条宽度
 */
-(void)setCornerRadius:(CGFloat)cornerRadius hexColor:(NSString *)hexColor borderWidth:(CGFloat)borderWidth;

/**
 view 加载xib
 
 @return view
 */
+(instancetype )initWithNib;

/**
 设置背景颜色

 @param hexClor 16进制色值
 */
-(void)setBackGroundColorWithHexColor:(NSString *)hexClor;
@end

