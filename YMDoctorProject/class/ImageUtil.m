//
//  ImageUtil.m
//  zcm-v2
//
//  Created by sjw-mac on 14-4-22.
//  Copyright (c) 2014年 Beijing Three Plus Five Software Techonolgy Co,Ltd. All rights reserved.
//

#import "ImageUtil.h"

@implementation ImageUtil

+(UIImage *)imageResizeTo:(CGSize) rect image:(UIImage *)image
{
    UIGraphicsBeginImageContext(rect);
    [image drawInRect:CGRectMake(0, 0, rect.width, rect.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)imageByScalingsourceImage:(UIImage *)sourceImage Size:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    UIGraphicsBeginImageContext(thumbnailRect.size);
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    newImage = [UIImage imageWithData:UIImageJPEGRepresentation(sourceImage, 0.6)];
    return newImage;
}
+ (UIImage *)imageStretchBackground:(NSString *)imagePath
{
    UIImage *image = [UIImage imageNamed:imagePath];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.7 topCapHeight:image.size.height*0.7];
}

+ (UIImage*)imageFromImage:(UIImage *)image inRect:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}
+ (CGFloat)imageWithBig:(UIImage *)sourceImage{
    
    NSData *data = UIImagePNGRepresentation(sourceImage);
    CGFloat scale = [data length]/(1024*2*1024);
    if (scale<1) {
        scale = 1;
    }
    else if(scale<=2&&scale>1&&scale==1){
        scale = 2;
    }else if(scale>2)
    {
        scale = 3;
    }
    return scale;
}
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width1 = imageSize.width;
    CGFloat height1 = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width1;
        CGFloat heightFactor = targetHeight / height1;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width1 * scaleFactor;
        scaledHeight = height1 * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
+(UIImage*)clipImage:(UIImage*)image
{
    NSMutableData *imageData = [[NSMutableData alloc] initWithData:UIImageJPEGRepresentation(image,1)];
    NSLog(@"==================%lu",(unsigned long)imageData.length);
    
    image = [self imageCompressForSize:image targetSize:CGSizeMake(image.size.width*0.7, image.size.height*0.7)];
    imageData = [[NSMutableData alloc] initWithData:UIImageJPEGRepresentation(image,0.2)];
    
    return image;
}
@end
