//
//  UIColor+CustomColor.m
//  FenYouShopping
//
//  Created by fenyou on 15/12/5.
//  Copyright © 2015年 fenyou. All rights reserved.
//

#import "UIColor+CustomColor.h"
#import "UIColor+LSFoundation.h"

@implementation UIColor (CustomColor)

+ (UIColor *)light_GrayColor {
    
    UIColor *color = [UIColor colorWithRGBHex:0xf3f3f3];//0xf8f8f6
    return color ;
}

+(UIColor *)navigationColor {
    
    UIColor *color = [UIColor colorWithRed:1.0 green:0.5755 blue:0.3997 alpha:1.0];//colorWithRGBHex:0xffa27c];//0xff7e4a
    
    return color ;
}

+ (UIColor *)backgroundColor {
    UIColor *color = [UIColor colorWithRGBHex:0xFFFFFF];
    return color ;
}

+(UIColor *)textLabelColor {
    UIColor *color = [UIColor colorWithRGBHex:0xA1A1A1]; //6F7179
    return color ;
}

+(UIColor *)hightBlackClor {    
    UIColor *color = [UIColor colorWithRGBHex:0x1C1C1C]; //
    return color ;
}

+ (UIColor *)deliveryInfoColor{
    
    UIColor *color = [UIColor colorWithRGBHex:0x94c40f];
    return color ;
}

+ (UIColor *)alphaColor {
    return [UIColor colorWithRGBHex:0xe4e4e4];
}

+(UIColor *)alphaColorWithHead {
    
    return [UIColor colorWithRGBHex:0xf7f7f7];
}
+(UIColor *)bluesColor
{
    return [UIColor colorWithRGBHex:0x0091FF];
}

+(UIColor *)lineColor{
    return [UIColor colorWithRGBHex:0xe5e5e5];
}

+ (UIColor *)deliveryMoneyColor{
    
    return [UIColor colorWithRGBHex:0xe1e1e1];
}

+ (UIColor *)orangesColor{
    
    return [UIColor colorWithRGBHex:0xFD9B0E];
}

+(UIColor *) btnBroungColor
{

    return [UIColor colorWithHexString:@"4CA6FF"];
}
//按钮文字颜色
+(UIColor *) btnTextColor
{

    return [UIColor colorWithHexString:@"#666666"];

}
//按钮背景蓝色
+(UIColor *) btnBlueColor
{
    
    return [UIColor colorWithHexString:@"4CA6FF"];
    
}
//cell分割线颜色
+(UIColor *)cellBackgrounColor
{

    return [UIColor colorWithHexString:@"#EEEFF5"];


}
//lable文字颜色
+(UIColor *)lableText99Color{

   return [UIColor colorWithHexString:@"#999999"];

}


@end
