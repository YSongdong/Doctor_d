//
//  ImageUtil.h
//  zcm-v2
//
//  Created by sjw-mac on 14-4-22.
//  Copyright (c) 2014年 Beijing Three Plus Five Software Techonolgy Co,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  <UIKit/UIKit.h>

@interface ImageUtil : NSObject

+ (UIImage *)imageResizeTo:(CGSize) rect image:(UIImage *)image;

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

+ (UIImage *)imageStretchBackground:(NSString *)imagePath;

+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
+ (UIImage*)imageByScalingsourceImage:(UIImage *)sourceImage Size:(CGSize)targetSize;

+ (CGFloat)imageWithBig:(UIImage *)sourceImage;
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+(UIImage*)clipImage:(UIImage*)image;
@end
