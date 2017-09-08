
//
//  CustomPickerViewTool.m
//  YMDoctorProject
//
//  Created by 王梅 on 2017/6/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CustomPickerViewTool.h"

@implementation CustomPickerViewTool

+(UIWindow*)keWindow{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    return window;
}

+ (UIPickerView *)pickerViewWithVC:(UIViewController*)vc {
    UIPickerView * pickerView;
   
        pickerView = [[UIPickerView alloc]init];
        pickerView.backgroundColor = [UIColor whiteColor];
        UIWindow * window = [self keWindow];
        pickerView.center = window.center ;
        pickerView.frame = CGRectMake(0, 0,window.bounds.size.width,256);
        return pickerView ;
}
@end
