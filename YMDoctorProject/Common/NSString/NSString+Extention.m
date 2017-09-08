//
//  NSString+Extention.m
//  FenYouShopping
//
//  Created by fenyou on 16/1/7.
//  Copyright © 2016年 fenyou. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

- (CGSize)sizeWithBoundingSize:(CGSize)size font:(UIFont *)font
{
    if (!font) {
        font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    NSDictionary *dic = @{NSFontAttributeName:font};
    
    // 第二种文本自适应,获取相应的大小
    CGRect rect =  [self boundingRectWithSize:size
                                      options:
                    NSStringDrawingUsesFontLeading |
                    NSStringDrawingUsesLineFragmentOrigin
                                   attributes:dic
                                      context:nil];
    return rect.size;
}

@end
